import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:passpal/core/auth/providers/auth_providers.dart';
import 'package:passpal/core/auth/errors/auth_exception.dart' as core_auth;
import 'package:passpal/core/auth/idp/idp_authenticator.dart';
import 'package:passpal/core/routing/providers.dart';
import 'package:passpal/core/routing/routes.dart';
import 'package:passpal/core/config/config_providers.dart';
import 'package:passpal/features/login/domain/student_id.dart';
import 'package:passpal/features/login/domain/login_exceptions.dart' as login;
import 'package:passpal/features/login/application/login_form_state.dart';
import 'package:passpal/features/login/application/validators.dart';

/// Notifier for managing login form state and flow
class LoginFormNotifier extends AutoDisposeAsyncNotifier<LoginFormState> {
  @override
  LoginFormState build() {
    return const LoginFormState();
  }

  /// Set student ID and move to Google sign-in step
  Future<void> setStudentId(String rawStudentId) async {
    if (state.isLoading) return;

    try {
      // Validate student ID format
      final validationError = LoginValidators.validateStudentId(rawStudentId);
      if (validationError != null) {
        state = AsyncValue.data(
          state.value!.copyWith(errorMessage: validationError),
        );
        return;
      }

      state = AsyncValue.data(
        state.value!.copyWith(isLoading: true, errorMessage: null),
      );

      // Get auth config
      final appConfig = await ref.read(appConfigProvider.future);
      final authConfig = appConfig.auth;

      // Create student ID value object
      final studentId = StudentId(rawStudentId, authConfig);

      // Update state and navigate to Google sign-in
      state = AsyncValue.data(
        state.value!.copyWith(
          studentId: studentId,
          currentStep: LoginStep.google,
          isLoading: false,
        ),
      );

      // Navigate to Google sign-in page
      final router = ref.read(goRouterProvider);
      router.pushNamed(AppRoute.loginGoogle.name);
    } catch (e) {
      // 設定初期化エラーかその他のエラーかを判定
      String errorMessage;
      if (e.toString().contains('LateInitializationError') ||
          e.toString().contains('_sources')) {
        errorMessage = 'アプリの初期化に失敗しました。アプリを再起動してください。';
      } else if (e is login.InvalidStudentIdException) {
        errorMessage = '学籍番号の形式が正しくありません。';
      } else {
        errorMessage = '予期しないエラーが発生しました。';
      }

      state = AsyncValue.data(
        state.value!.copyWith(errorMessage: errorMessage, isLoading: false),
      );
    }
  }

  /// Handle Google sign-in and verification
  Future<void> handleGoogleSignin() async {
    if (state.isLoading) return;
    final currentState = state.value;
    if (currentState?.studentId == null) {
      throw const login.InvalidLoginStepException(
        'Google sign-in without student ID',
      );
    }

    try {
      state = AsyncValue.data(
        currentState!.copyWith(isLoading: true, errorMessage: null),
      );

      final googleLinkVerifier = ref.read(googleLinkVerifierProvider);
      final firebaseAuth = ref.read(firebaseAuthProvider);

      // Get auth config
      final appConfig = await ref.read(appConfigProvider.future);
      final authConfig = appConfig.auth;

      // Firebase Auth direct Google Sign-In for Android/iOS
      final GoogleAuthProvider googleProvider = GoogleAuthProvider();
      googleProvider.addScope('email');
      
      // Set hint for the expected email
      googleProvider.setCustomParameters({
        'login_hint': currentState.studentId!.expectedEmail,
      });

      // Sign out any existing users first
      await firebaseAuth.signOut();

      // Add debug logging
      debugPrint('Starting Google Sign-In with provider');
      debugPrint('Expected email: ${currentState.studentId!.expectedEmail}');

      // Use signInWithProvider for native platforms (Android/iOS)
      final UserCredential userCredential = await firebaseAuth.signInWithProvider(googleProvider);
      
      debugPrint('Google Sign-In completed, checking user data...');
      final User? user = userCredential.user;
      
      if (user == null || user.email == null) {
        throw const core_auth.AuthenticationException.generic(
          message: 'Google認証からユーザー情報を取得できませんでした。',
        );
      }
      
      debugPrint('User signed in successfully: ${user.email}');

      // Verify email matches expected student email
      final expectedEmail = currentState.studentId!.expectedEmail;
      if (!LoginValidators.isValidStudentEmail(
        user.email!,
        currentState.studentId!.value,
        authConfig,
      )) {
        // Sign out the user and throw exception
        await firebaseAuth.signOut();
        throw login.AccountLinkException(
          expected: expectedEmail,
          actual: user.email!,
        );
      }

      // Verify with GoogleLinkVerifier
      await googleLinkVerifier.ensureLinked();

      // Update state and navigate to CU-ID page
      state = AsyncValue.data(
        currentState.copyWith(
          isGoogleSignedIn: true,
          currentStep: LoginStep.cuId,
          isLoading: false,
        ),
      );

      // Navigate to CU-ID page
      final router = ref.read(goRouterProvider);
      router.pushNamed(AppRoute.loginCuId.name);
    } catch (e) {
      // Handle different types of errors
      debugPrint('Google Sign-In error: $e');
      debugPrint('Error type: ${e.runtimeType}');
      
      String errorMessage;
      
      if (e.toString().contains('sign_in_canceled') || 
          e.toString().contains('ERROR_ABORTED_BY_USER') ||
          e.toString().contains('canceled') ||
          e.toString().contains('cancelled')) {
        errorMessage = 'Googleサインインがキャンセルされました';
      } else if (e is login.AccountLinkException) {
        errorMessage = e.message;
      } else if (e.toString().contains('network')) {
        errorMessage = 'ネットワークエラーが発生しました。接続を確認してください。';
      } else if (e.toString().contains('configuration')) {
        errorMessage = 'Google認証の設定に問題があります。';
      } else if (e.toString().contains('DEVELOPER_ERROR') || 
                 e.toString().contains('developer_error')) {
        errorMessage = 'アプリの設定に問題があります。開発者にお問い合わせください。';
      } else {
        errorMessage = 'Google認証に失敗しました。もう一度お試しください。';
      }
      
      state = AsyncValue.data(
        currentState!.copyWith(errorMessage: errorMessage, isLoading: false),
      );
    }
  }

  /// Handle final login with CU-ID password
  Future<void> loginWithCuId(String password) async {
    if (state.isLoading) return;
    final currentState = state.value;
    if (currentState?.studentId == null || !currentState!.isGoogleSignedIn) {
      throw const login.InvalidLoginStepException(
        'CU-ID login without proper setup',
      );
    }

    try {
      // Validate password
      final validationError = LoginValidators.validatePassword(password);
      if (validationError != null) {
        state = AsyncValue.data(
          currentState.copyWith(errorMessage: validationError),
        );
        return;
      }

      state = AsyncValue.data(
        currentState.copyWith(isLoading: true, errorMessage: null),
      );

      final authFacade = ref.read(authFacadeProvider);

      // Attempt login
      await authFacade.login(
        portal: Portal.albo, // Using ALBO portal
        username: currentState.studentId!.value,
        password: password,
      );

      // Login successful - navigate to setup
      final router = ref.read(goRouterProvider);
      router.goNamed(AppRoute.setupCampus.name);
    } catch (e, stackTrace) {
      if (e is core_auth.AuthenticationException) {
        // Handle authentication-specific errors
        String errorMessage;
        if (e.message.contains('invalid') || e.message.contains('credential')) {
          errorMessage = 'Invalid username or password. Please try again.';
        } else if (e.message.contains('link')) {
          errorMessage = 'Account not properly linked. Please start over.';
        } else {
          errorMessage = 'Login failed. Please try again.';
        }

        state = AsyncValue.data(
          currentState.copyWith(errorMessage: errorMessage, isLoading: false),
        );
      } else {
        state = AsyncValue.error(e, stackTrace);
      }
    }
  }

  /// Clear any error message
  void clearError() {
    final currentState = state.value;
    if (currentState != null && currentState.errorMessage != null) {
      state = AsyncValue.data(currentState.clearError());
    }
  }

  /// Reset to initial state
  void reset() {
    state = const AsyncValue.data(LoginFormState());
  }
}

/// Provider for the login form notifier
final loginFormNotifierProvider =
    AutoDisposeAsyncNotifierProvider<LoginFormNotifier, LoginFormState>(
      LoginFormNotifier.new,
    );
