import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    } catch (e, stackTrace) {
      state = AsyncValue.error(
        login.InvalidStudentIdException(rawStudentId),
        stackTrace,
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

      // For now, we'll use a simplified approach
      // In a real implementation, Google sign-in would be triggered here
      // and the user would be signed in to Firebase

      // Simulate Google sign-in success for development
      // This should be replaced with actual Google sign-in implementation

      // For the example, let's assume the user is already signed in via Google
      // and we just need to verify the email domain
      final user = firebaseAuth.currentUser;
      if (user?.email == null) {
        throw const core_auth.AuthenticationException.generic(
          message: 'Please sign in with Google first',
        );
      }

      // Get auth config
      final appConfig = await ref.read(appConfigProvider.future);
      final authConfig = appConfig.auth;

      // Verify email matches expected student email
      final expectedEmail = currentState.studentId!.expectedEmail;
      if (!LoginValidators.isValidStudentEmail(
        user!.email!,
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
    } catch (e, stackTrace) {
      if (e is login.AccountLinkException) {
        state = AsyncValue.data(
          currentState!.copyWith(errorMessage: e.message, isLoading: false),
        );
      } else {
        state = AsyncValue.error(e, stackTrace);
      }
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
