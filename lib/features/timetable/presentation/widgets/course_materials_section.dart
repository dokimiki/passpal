import 'package:flutter/material.dart' hide MaterialType;
import 'package:url_launcher/url_launcher.dart';
import '../../domain/entities/course_material.dart';

/// 授業資料セクション
class CourseMaterialsSection extends StatelessWidget {
  const CourseMaterialsSection({super.key, required this.materials});

  final List<CourseMaterial> materials;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: ExpansionTile(
        leading: const Icon(Icons.folder),
        title: Text('授業資料 (${materials.length})'),
        children: [
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: materials.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final material = materials[index];
              return ListTile(
                leading: _getFileIcon(material.type),
                title: Text(material.title),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (material.description != null)
                      Text(material.description!),
                    if (material.updatedAt != null)
                      Text(
                        '更新日: ${_formatDate(material.updatedAt!)}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    if (material.fileSize != null)
                      Text(
                        'サイズ: ${_formatFileSize(material.fileSize!)}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                  ],
                ),
                trailing: material.downloadUrl != null
                    ? IconButton(
                        icon: const Icon(Icons.download),
                        onPressed: () => _downloadFile(material),
                      )
                    : null,
                onTap: material.downloadUrl != null
                    ? () => _downloadFile(material)
                    : null,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _getFileIcon(MaterialType type) {
    switch (type) {
      case MaterialType.document:
        return const Icon(Icons.description, color: Colors.blue);
      case MaterialType.video:
        return const Icon(Icons.video_file, color: Colors.red);
      case MaterialType.audio:
        return const Icon(Icons.audio_file, color: Colors.green);
      case MaterialType.link:
        return const Icon(Icons.link, color: Colors.purple);
      case MaterialType.quiz:
        return const Icon(Icons.quiz, color: Colors.orange);
      case MaterialType.assignment:
        return const Icon(Icons.assignment, color: Colors.indigo);
    }
  }

  String _formatDate(DateTime date) {
    return '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '${bytes}B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)}KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)}MB';
  }

  Future<void> _downloadFile(CourseMaterial material) async {
    if (material.downloadUrl == null) return;

    try {
      final uri = Uri.parse(material.downloadUrl!);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      }
    } catch (e) {
      // エラーハンドリングはここで行う
      // 実際のアプリでは適切なエラー表示を行う
    }
  }
}
