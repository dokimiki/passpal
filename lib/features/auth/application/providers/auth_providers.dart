import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/repository/auth_repository.dart';
import '../../domain/usecase/sign_in.dart';

/// AuthRepositoryのモックプロバイダー（テストや将来の実装で上書きされる）
final authRepositoryProvider = Provider<AuthRepository>(
  (ref) =>
      throw UnimplementedError('AuthRepository implementation not provided'),
);

/// SignInユースケースのプロバイダー
final signInProvider = Provider<SignIn>(
  (ref) => SignIn(ref.watch(authRepositoryProvider)),
);
