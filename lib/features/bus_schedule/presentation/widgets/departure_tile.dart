import 'package:flutter/material.dart';
import '../../domain/entities/departure.dart';

class DepartureTile extends StatelessWidget {
  final DepartureDTO departure;
  final bool isNearest;

  const DepartureTile({
    super.key,
    required this.departure,
    this.isNearest = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: isNearest ? 8 : 2,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: isNearest
              ? Border.all(color: theme.colorScheme.primary, width: 2)
              : null,
        ),
        child: Row(
          children: [
            // Time column
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    departure.departureTime.formatted,
                    style: TextStyle(
                      fontSize: isNearest ? 24 : 18,
                      fontWeight: FontWeight.bold,
                      color: isNearest ? theme.colorScheme.primary : null,
                    ),
                  ),
                  if (departure.minutesUntilDeparture != null)
                    Text(
                      '${departure.minutesUntilDeparture} min',
                      style: TextStyle(
                        fontSize: 12,
                        color: theme.colorScheme.secondary,
                      ),
                    ),
                ],
              ),
            ),

            // Route info column
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    departure.lineDisplayName,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    departure.destinationName,
                    style: TextStyle(
                      fontSize: 12,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                  if (departure.isVia ?? false)
                    Text(
                      'via ${departure.platformInfo ?? ""}',
                      style: TextStyle(
                        fontSize: 10,
                        color: theme.colorScheme.secondary,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                ],
              ),
            ),

            // Arrival time column
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'Arrives',
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                  Text(
                    departure.arrivalTime.formatted,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
