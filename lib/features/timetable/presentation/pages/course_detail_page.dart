import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/timetable_slot.dart';
import '../../domain/entities/attendance_state.dart';
import '../../application/attendance_controller.dart';
import '../widgets/course_info_card.dart';
import '../widgets/attendance_banner.dart';

/// 授業詳細ページ
class CourseDetailPage extends ConsumerWidget {
  const CourseDetailPage({super.key, required this.slot});

  final TimetableSlot slot;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final course = slot.course;

    if (course == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('授業詳細')),
        body: const Center(child: Text('授業情報が見つかりません')),
      );
    }

    final attendanceState = ref.watch(
      attendanceControllerProvider(course.manaboClassId),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(course.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref
                  .read(
                    attendanceControllerProvider(course.manaboClassId).notifier,
                  )
                  .refreshState();
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref
              .read(attendanceControllerProvider(course.manaboClassId).notifier)
              .refreshState();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 出席バナー
              Builder(
                builder: (context) {
                  if (attendanceState.status == AttendanceStatus.open ||
                      attendanceState.status == AttendanceStatus.success ||
                      attendanceState.status == AttendanceStatus.fail) {
                    return AttendanceBanner(
                      attendanceData: attendanceState,
                      onAttendanceSubmit: (password) async {
                        await ref
                            .read(
                              attendanceControllerProvider(
                                course.manaboClassId,
                              ).notifier,
                            )
                            .submitAttendance(password: password);
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),

              // 授業情報カード
              CourseInfoCard(course: course, slot: slot),

              const SizedBox(height: 16),

              // TODO: シラバス情報と授業資料は CourseDetail から取得する必要がある
              // 現在は Course エンティティにはこれらの情報が含まれていない
              // 実装時は CourseDetail を使用するか、別途データを取得する
            ],
          ),
        ),
      ),
    );
  }
}
