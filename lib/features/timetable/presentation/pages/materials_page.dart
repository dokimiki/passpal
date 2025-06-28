import 'package:flutter/material.dart' hide MaterialType;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/course_material.dart';

/// 授業資料ページ
class MaterialsPage extends ConsumerWidget {
  const MaterialsPage({
    super.key,
    required this.courseTitle,
    required this.materials,
  });

  final String courseTitle;
  final List<CourseMaterial> materials;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text('$courseTitle - 資料')),
      body: materials.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.folder_open, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('資料はありません', style: TextStyle(color: Colors.grey)),
                ],
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.folder),
                                const SizedBox(width: 8),
                                Text(
                                  '授業資料 (${materials.length})',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: materials.length,
                              separatorBuilder: (context, index) =>
                                  const Divider(height: 1),
                              itemBuilder: (context, index) {
                                final material = materials[index];
                                return _buildMaterialTile(context, material);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildMaterialTile(BuildContext context, CourseMaterial material) {
    return ListTile(
      leading: _getFileIcon(material.type),
      title: Text(material.title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (material.description != null) Text(material.description!),
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
    // TODO: 実装が必要 - ファイルダウンロード処理
    // url_launcher または file_saver パッケージを使用
  }
}
