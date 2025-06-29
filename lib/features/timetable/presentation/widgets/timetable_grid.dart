import 'package:flutter/material.dart';
import 'package:passpal/core/theme/tokens/spacing.dart';
import 'package:passpal/features/timetable/domain/entities/timetable_slot.dart';
import 'package:passpal/features/timetable/presentation/pages/course_detail_page.dart';

class TimetableGrid extends StatelessWidget {
  const TimetableGrid({super.key, required this.slots});

  final List<TimetableSlot> slots;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(SpaceTokens.sm),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5, // Monday to Friday
        childAspectRatio: 0.75,
        crossAxisSpacing: SpaceTokens.sm,
        mainAxisSpacing: SpaceTokens.sm,
      ),
      itemCount: 35, // 5 days * 7 periods
      itemBuilder: (context, index) {
        final day = index % 5;
        final period = index ~/ 5 + 1;
        final weekday = Weekday.values[day];

        final slot = _findSlot(weekday, period);

        return _CourseCard(slot: slot);
      },
    );
  }

  TimetableSlot? _findSlot(Weekday weekday, int period) {
    try {
      return slots.firstWhere(
        (s) => s.weekday == weekday && s.period.number == period,
      );
    } catch (_) {
      return null;
    }
  }
}

class _CourseCard extends StatelessWidget {
  final TimetableSlot? slot;

  const _CourseCard({this.slot});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasCourse = slot != null && slot!.course != null;

    return InkWell(
      onTap: hasCourse
          ? () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => CourseDetailPage(slot: slot!),
              ),
            )
          : null,
      borderRadius: BorderRadius.circular(12),
      child: Card(
        elevation: hasCourse ? 2 : 0,
        color: hasCourse
            ? theme.colorScheme.primaryContainer
            : theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        child: Padding(
          padding: const EdgeInsets.all(SpaceTokens.sm),
          child: hasCourse
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${slot!.period.number} Period',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      slot!.course!.title,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: SpaceTokens.xs),
                    Text(
                      slot!.room ?? 'N/A',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onPrimaryContainer.withValues(
                          alpha: 0.8,
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                )
              : Center(
                  child: Icon(
                    Icons.add_circle_outline,
                    color: theme.colorScheme.onSurfaceVariant.withValues(
                      alpha: 0.5,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
