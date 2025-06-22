import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:passpal/features/auth/domain/entity/user.dart';
import 'package:passpal/features/auth/domain/failure/auth_failure.dart';
import 'package:passpal/features/auth/domain/repository/auth_repository.dart';
import 'package:passpal/features/auth/domain/usecase/sign_in.dart';

import 'sign_in_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  group('SignIn UseCase', () {
    late MockAuthRepository mockAuthRepository;
    late SignIn signIn;

    setUpAll(() {
      // EitherのダミーデータをMockitoに提供
      provideDummy<Either<AuthFailure, User>>(const Left(Unknown()));
    });

    setUp(() {
      mockAuthRepository = MockAuthRepository();
      signIn = SignIn(mockAuthRepository);
    });

    group('call', () {
      const tId = 'test_student_id';
      const tPassword = 'test_password';

      final tUser = User(
        uid: 'test_uid',
        studentId: tId,
        displayName: 'Test User',
        email: 'test@m.chukyo-u.ac.jp',
        campus: Campus.toyota,
        created: DateTime(2025, 1, 1),
      );

      test('認証成功時にUserを返すこと', () async {
        // arrange
        when(
          mockAuthRepository.signIn(tId, tPassword),
        ).thenAnswer((_) async => Right(tUser));

        // act
        final result = await signIn.call(id: tId, pw: tPassword);

        // assert
        expect(result, Right(tUser));
        verify(mockAuthRepository.signIn(tId, tPassword));
        verifyNoMoreInteractions(mockAuthRepository);
      });

      test('認証失敗時にAuthFailureを返すこと', () async {
        // arrange
        const tFailure = InvalidCredential();
        when(
          mockAuthRepository.signIn(tId, tPassword),
        ).thenAnswer((_) async => const Left(tFailure));

        // act
        final result = await signIn.call(id: tId, pw: tPassword);

        // assert
        expect(result, const Left(tFailure));
        verify(mockAuthRepository.signIn(tId, tPassword));
        verifyNoMoreInteractions(mockAuthRepository);
      });

      test('ネットワークエラー時にAuthFailure.networkを返すこと', () async {
        // arrange
        const tFailure = Network();
        when(
          mockAuthRepository.signIn(tId, tPassword),
        ).thenAnswer((_) async => const Left(tFailure));

        // act
        final result = await signIn.call(id: tId, pw: tPassword);

        // assert
        expect(result, const Left(tFailure));
        verify(mockAuthRepository.signIn(tId, tPassword));
        verifyNoMoreInteractions(mockAuthRepository);
      });

      test('サーバーエラー時にAuthFailure.serverを返すこと', () async {
        // arrange
        const tFailure = Server(500);
        when(
          mockAuthRepository.signIn(tId, tPassword),
        ).thenAnswer((_) async => const Left(tFailure));

        // act
        final result = await signIn.call(id: tId, pw: tPassword);

        // assert
        expect(result, const Left(tFailure));
        verify(mockAuthRepository.signIn(tId, tPassword));
        verifyNoMoreInteractions(mockAuthRepository);
      });
    });
  });
}
