import 'package:flutter/material.dart';
import '../../domain/entities/course.dart';
import '../../domain/entities/timetable_slot.dart';

/// 授業情報カードウィジェット
class CourseInfoCard extends StatelessWidget {
  const CourseInfoCard({super.key, required this.course, required this.slot});

  final Course course;
  final TimetableSlot slot;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              course.title,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildInfoRow(Icons.person, '教員', course.teacher),
            if (slot.room != null) _buildInfoRow(Icons.room, '教室', slot.room!),
            _buildInfoRow(
              Icons.schedule,
              '時間',
              '${slot.weekday.displayName}曜日 ${slot.period.number}限',
            ),
            if (course.courseCode != null)
              _buildInfoRow(Icons.code, '授業コード', course.courseCode!),
            if (course.credits != null)
              _buildInfoRow(Icons.school, '単位数', '${course.credits}単位'),
            if (course.format != null)
              _buildInfoRow(Icons.category, '授業形態', course.format!),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: Colors.grey.shade600),
          const SizedBox(width: 8),
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.w500)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
