import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../storage/providers.dart';
import '../storage/entities/timetable.dart';
import '../storage/entities/assignment_log.dart';

/// Example widget demonstrating IsarService usage with Riverpod.
///
/// This shows how to:
/// 1. Initialize the database
/// 2. Use Riverpod providers to access Isar
/// 3. Perform CRUD operations
/// 4. Display data in a widget
class IsarExampleWidget extends ConsumerStatefulWidget {
  const IsarExampleWidget({super.key});

  @override
  ConsumerState<IsarExampleWidget> createState() => _IsarExampleWidgetState();
}

class _IsarExampleWidgetState extends ConsumerState<IsarExampleWidget> {
  @override
  void initState() {
    super.initState();
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    try {
      final isarService = ref.read(isarServiceProvider);
      await isarService.open();
      print('Database initialized successfully');
    } catch (e) {
      print('Failed to initialize database: $e');
    }
  }

  Future<void> _addSampleData() async {
    try {
      final isar = ref.read(isarProvider);

      await isar.writeTxn(() async {
        // Add sample timetable entries
        await isar.timetables.putAll([
          Timetable(
            campusId: 'toyota',
            weekday: 1, // Monday
            period: 1,
            courseName: 'プログラミング基礎',
            instructor: '田中教授',
          ),
          Timetable(
            campusId: 'toyota',
            weekday: 1, // Monday
            period: 2,
            courseName: '数学',
            instructor: '佐藤教授',
          ),
          Timetable(
            campusId: 'nagoya',
            weekday: 2, // Tuesday
            period: 1,
            courseName: '英語',
            instructor: 'Smith教授',
          ),
        ]);

        // Add sample assignment logs
        await isar.assignmentLogs.putAll([
          AssignmentLog(
            assignmentId: 'assignment-001',
            action: AssignmentAction.added,
            dueAt: DateTime.now().add(const Duration(days: 7)),
          ),
          AssignmentLog(
            assignmentId: 'assignment-002',
            action: AssignmentAction.added,
            dueAt: DateTime.now().add(const Duration(days: 3)),
          ),
        ]);
      });

      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('サンプルデータを追加しました')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('エラー: $e')));
      }
    }
  }

  Future<void> _clearDatabase() async {
    try {
      final isarService = ref.read(isarServiceProvider);
      await isarService.clear();

      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('データベースをクリアしました')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('エラー: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Isar Database Example')),
      body: Column(
        children: [
          // Control buttons
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _addSampleData,
                  child: const Text('サンプルデータ追加'),
                ),
                ElevatedButton(
                  onPressed: _clearDatabase,
                  child: const Text('データクリア'),
                ),
              ],
            ),
          ),

          // Database stats
          Consumer(
            builder: (context, ref, child) {
              final statsAsync = ref.watch(databaseStatsProvider);

              return statsAsync.when(
                data: (stats) => Card(
                  margin: const EdgeInsets.all(16.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'データベース統計',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Text('時間割エントリ数: ${stats['timetable_count']}'),
                        Text('課題ログ数: ${stats['assignment_log_count']}'),
                        Text('データベース名: ${stats['database_name']}'),
                      ],
                    ),
                  ),
                ),
                loading: () => const Card(
                  margin: EdgeInsets.all(16.0),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('統計を読み込み中...'),
                  ),
                ),
                error: (error, stack) => Card(
                  margin: const EdgeInsets.all(16.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text('エラー: $error'),
                  ),
                ),
              );
            },
          ),

          // Data display
          Expanded(
            child: Consumer(
              builder: (context, ref, child) {
                try {
                  final isar = ref.read(isarProvider);

                  return DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        const TabBar(
                          tabs: [
                            Tab(text: '時間割'),
                            Tab(text: '課題ログ'),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              _TimetableList(isar: isar),
                              _AssignmentLogList(isar: isar),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                } catch (e) {
                  return Center(child: Text('データベースが初期化されていません: $e'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _TimetableList extends StatelessWidget {
  final dynamic isar;

  const _TimetableList({required this.isar});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Timetable>>(
      future: isar.timetables.where().findAll(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('エラー: ${snapshot.error}'));
        }

        final timetables = snapshot.data ?? [];

        if (timetables.isEmpty) {
          return const Center(child: Text('時間割データがありません'));
        }

        return ListView.builder(
          itemCount: timetables.length,
          itemBuilder: (context, index) {
            final timetable = timetables[index];
            return ListTile(
              title: Text(timetable.courseName),
              subtitle: Text('${timetable.instructor} - ${timetable.campusId}'),
              trailing: Text('${timetable.weekday}限目 ${timetable.period}コマ'),
            );
          },
        );
      },
    );
  }
}

class _AssignmentLogList extends StatelessWidget {
  final dynamic isar;

  const _AssignmentLogList({required this.isar});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<AssignmentLog>>(
      future: isar.assignmentLogs.where().findAll(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('エラー: ${snapshot.error}'));
        }

        final logs = snapshot.data ?? [];

        if (logs.isEmpty) {
          return const Center(child: Text('課題ログがありません'));
        }

        return ListView.builder(
          itemCount: logs.length,
          itemBuilder: (context, index) {
            final log = logs[index];
            return ListTile(
              title: Text('課題 ${log.assignmentId}'),
              subtitle: Text(
                log.action == AssignmentAction.added ? '追加' : '削除',
              ),
              trailing: log.dueAt != null
                  ? Text('期限: ${log.dueAt!.month}/${log.dueAt!.day}')
                  : const Text('期限なし'),
            );
          },
        );
      },
    );
  }
}
