import 'package:flutter/material.dart';
import '../../domain/entities/attendance_state.dart';

/// 出席バナーウィジェット
class AttendanceBanner extends StatefulWidget {
  const AttendanceBanner({
    super.key,
    required this.attendanceData,
    required this.onAttendanceSubmit,
  });

  final AttendanceState attendanceData;
  final Future<void> Function(String? password) onAttendanceSubmit;

  @override
  State<AttendanceBanner> createState() => _AttendanceBannerState();
}

class _AttendanceBannerState extends State<AttendanceBanner> {
  final _passwordController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.attendanceData.status == AttendanceStatus.none) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        color: Colors.grey.shade100,
        child: const Row(
          children: [
            Icon(Icons.schedule, color: Colors.grey),
            SizedBox(width: 8),
            Text('出席受付時間外です', style: TextStyle(color: Colors.grey)),
          ],
        ),
      );
    }

    if (widget.attendanceData.status == AttendanceStatus.success) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        color: Colors.blue.shade50,
        child: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.blue),
            SizedBox(width: 8),
            Text(
              '出席済み',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
            ),
          ],
        ),
      );
    }

    if (widget.attendanceData.status == AttendanceStatus.fail) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        color: Colors.red.shade50,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.error, color: Colors.red),
                SizedBox(width: 8),
                Text(
                  '出席登録に失敗しました',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            if (widget.attendanceData.errorMessage != null) ...[
              const SizedBox(height: 8),
              Text(
                widget.attendanceData.errorMessage!,
                style: TextStyle(color: Colors.red.shade700),
              ),
            ],
          ],
        ),
      );
    }

    // AttendanceStatus.open
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      color: Colors.green.shade50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.access_time, color: Colors.green),
              SizedBox(width: 8),
              Text(
                '出席受付中',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    hintText: 'パスワード（必要に応じて）',
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                  obscureText: true,
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: _isSubmitting ? null : _submitAttendance,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                child: _isSubmitting
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('出席'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _submitAttendance() async {
    if (_isSubmitting) return;

    setState(() {
      _isSubmitting = true;
    });

    try {
      final password = _passwordController.text.trim().isEmpty
          ? null
          : _passwordController.text.trim();

      await widget.onAttendanceSubmit(password);

      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('出席を登録しました')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('エラーが発生しました: $e')));
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }
}
