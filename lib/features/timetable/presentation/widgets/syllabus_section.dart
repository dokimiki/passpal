import 'package:flutter/material.dart';
import '../../domain/entities/syllabus.dart';

/// シラバス情報セクション
class SyllabusSection extends StatelessWidget {
  const SyllabusSection({super.key, required this.syllabus});

  final Syllabus syllabus;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: ExpansionTile(
        leading: const Icon(Icons.description),
        title: const Text('シラバス'),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (syllabus.overview != null) ...[
                  _buildSection('概要', syllabus.overview!),
                  const SizedBox(height: 16),
                ],
                if (syllabus.objectives != null) ...[
                  _buildSection('到達目標', syllabus.objectives!),
                  const SizedBox(height: 16),
                ],
                if (syllabus.lessonPlan.isNotEmpty) ...[
                  _buildSection('授業計画', _formatLessonPlan(syllabus.lessonPlan)),
                  const SizedBox(height: 16),
                ],
                if (syllabus.evaluationMethod != null) ...[
                  _buildSection('評価方法', syllabus.evaluationMethod!),
                  const SizedBox(height: 16),
                ],
                if (syllabus.textbook != null) ...[
                  _buildSection('教科書', syllabus.textbook!),
                  const SizedBox(height: 16),
                ],
                if (syllabus.references != null) ...[
                  _buildSection('参考書', syllabus.references!),
                  const SizedBox(height: 16),
                ],
                if (syllabus.notes != null) ...[
                  _buildSection('備考', syllabus.notes!),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(content),
        ),
      ],
    );
  }

  String _formatLessonPlan(List<LessonPlan> plans) {
    return plans.map((plan) => '第${plan.week}回: ${plan.title}').join('\n');
  }
}
