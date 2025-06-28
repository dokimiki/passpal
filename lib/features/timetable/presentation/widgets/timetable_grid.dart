import 'package:flutter/material.dart';
import '../../domain/entities/timetable_slot.dart';

/// 時間割グリッドウィジェット
class TimetableGrid extends StatelessWidget {
  const TimetableGrid({super.key, required this.slots});

  final List<TimetableSlot> slots;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // 時間割ヘッダー
          _buildTimeTableHeader(),
          // 時間割ボディ
          _buildTimeTableBody(context),
        ],
      ),
    );
  }

  Widget _buildTimeTableHeader() {
    const weekdays = ['', '月', '火', '水', '木', '金', '土', '日'];

    return Container(
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: weekdays
            .map(
              (day) => Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      day,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildTimeTableBody(BuildContext context) {
    return Column(
      children: List.generate(7, (periodIndex) {
        final period = periodIndex + 1;
        return _buildTimeTableRow(context, period);
      }),
    );
  }

  Widget _buildTimeTableRow(BuildContext context, int period) {
    const weekdays = [
      null,
      Weekday.monday,
      Weekday.tuesday,
      Weekday.wednesday,
      Weekday.thursday,
      Weekday.friday,
      Weekday.saturday,
      Weekday.sunday,
    ];

    return Container(
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: weekdays.map((weekday) {
          if (weekday == null) {
            // 時限表示
            return Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(color: Colors.grey.shade300),
                  ),
                  color: Colors.grey.shade100,
                ),
                child: Center(
                  child: Text(
                    '${period}限',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            );
          }

          // 授業スロット
          final slot = _findSlot(weekday, period);
          return Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border(right: BorderSide(color: Colors.grey.shade300)),
              ),
              child: slot != null
                  ? _buildCourseCard(context, slot)
                  : const SizedBox(),
            ),
          );
        }).toList(),
      ),
    );
  }

  TimetableSlot? _findSlot(Weekday weekday, int period) {
    try {
      return slots.firstWhere(
        (slot) => slot.weekday == weekday && slot.period.number == period,
      );
    } catch (e) {
      return null;
    }
  }

  Widget _buildCourseCard(BuildContext context, TimetableSlot slot) {
    return InkWell(
      onTap: slot.course != null
          ? () {
              // TODO: コース詳細ページへ遷移
              // Navigator.push(context, MaterialPageRoute(builder: (context) => CourseDetailPage(slot: slot)));
            }
          : null,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        margin: const EdgeInsets.all(2),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: slot.course != null ? Colors.blue.shade50 : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: slot.course != null
                ? Colors.blue.shade200
                : Colors.transparent,
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (slot.course?.title != null) ...[
              Text(
                slot.course!.title,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
            ],
            if (slot.course?.teacher != null) ...[
              Text(
                slot.course!.teacher,
                style: TextStyle(fontSize: 9, color: Colors.grey.shade700),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            if (slot.room != null) ...[
              Text(
                slot.room!,
                style: TextStyle(fontSize: 9, color: Colors.grey.shade600),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
