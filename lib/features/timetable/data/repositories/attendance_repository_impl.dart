import 'dart:async';
import '../../domain/entities/attendance_state.dart';
import '../../domain/repositories/attendance_repository.dart';
import '../datasources/manabo_attendance_remote_ds.dart';
import '../parsers/manabo_attendance_parser.dart';

/// 出席リポジトリ実装
class AttendanceRepositoryImpl implements AttendanceRepository {
  const AttendanceRepositoryImpl({
    required ManaboAttendanceRemoteDataSource attendanceDataSource,
  }) : _attendanceDataSource = attendanceDataSource;

  final ManaboAttendanceRemoteDataSource _attendanceDataSource;

  @override
  Future<AttendanceState> checkState(int classId) async {
    try {
      final responseJson = await _attendanceDataSource.checkAttendanceState(
        classId,
      );
      final response = ManaboAttendanceParser.parseAttendanceCheck(
        responseJson,
      );

      AttendanceStatus status;
      String? errorMessage;

      if (response.success) {
        if (response.data != null) {
          status = AttendanceStatus.fromIsAccepted(response.data!.isAccepted);
        } else {
          status = AttendanceStatus.none;
        }
      } else {
        status = AttendanceStatus.fail;
        errorMessage = response.error;
      }

      return AttendanceState(
        classId: classId,
        status: status,
        errorMessage: errorMessage,
        lastUpdated: DateTime.now(),
      );
    } catch (e) {
      // TODO: 適切なAppExceptionに変換
      return AttendanceState(
        classId: classId,
        status: AttendanceStatus.fail,
        errorMessage: e.toString(),
        lastUpdated: DateTime.now(),
      );
    }
  }

  @override
  Future<AttendanceState> submit(int classId, {String? password}) async {
    try {
      // まず出席フォーム情報を取得
      final formHtml = await _attendanceDataSource.fetchAttendanceForm(classId);
      final formInfo = ManaboAttendanceParser.parseAttendanceForm(formHtml);

      if (formInfo == null) {
        return AttendanceState(
          classId: classId,
          status: AttendanceStatus.fail,
          errorMessage: '出席フォーム情報の取得に失敗しました',
          lastUpdated: DateTime.now(),
        );
      }

      // パスワードが必要だが提供されていない場合
      if (formInfo.requiresPassword && password == null) {
        return AttendanceState(
          classId: classId,
          status: AttendanceStatus.open,
          errorMessage: '出席コードが必要です',
          lastUpdated: DateTime.now(),
        );
      }

      // 出席登録を実行
      final submitResponseJson = await _attendanceDataSource.submitAttendance(
        classId: classId,
        entryId: formInfo.entryId,
        uniqid: formInfo.uniqid,
        password: password,
      );

      final submitResponse = ManaboAttendanceParser.parseAttendanceResponse(
        submitResponseJson,
      );

      AttendanceStatus status;
      String? errorMessage;

      if (submitResponse.success) {
        status = AttendanceStatus.success;
      } else {
        status = AttendanceStatus.fail;
        errorMessage = submitResponse.error ?? '出席登録に失敗しました';
      }

      return AttendanceState(
        classId: classId,
        status: status,
        errorMessage: errorMessage,
        lastUpdated: DateTime.now(),
      );
    } catch (e) {
      // TODO: 適切なAppExceptionに変換
      return AttendanceState(
        classId: classId,
        status: AttendanceStatus.fail,
        errorMessage: e.toString(),
        lastUpdated: DateTime.now(),
      );
    }
  }

  @override
  Stream<AttendanceState> watchState(int classId) {
    // 30秒ごとにポーリング
    return Stream.periodic(
      const Duration(seconds: 30),
      (_) => checkState(classId),
    ).asyncMap((future) => future);
  }
}
