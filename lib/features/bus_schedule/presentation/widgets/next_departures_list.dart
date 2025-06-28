import 'package:flutter/material.dart';
import '../../domain/entities/departure.dart';
import '../../domain/value_objects.dart' as domain;
import 'departure_tile.dart';

class NextDeparturesList extends StatelessWidget {
  final List<DepartureDTO>? departures;

  const NextDeparturesList({super.key, this.departures});

  @override
  Widget build(BuildContext context) {
    final mockDepartures = departures ?? _getMockDepartures();

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: mockDepartures.length,
      itemBuilder: (context, index) {
        final departure = mockDepartures[index];
        final isNearest = index == 0;

        return Column(
          children: [
            if (isNearest) ...[
              const Text(
                'Nearest Departure',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
            ],
            DepartureTile(departure: departure, isNearest: isNearest),
            if (index < mockDepartures.length - 1) const SizedBox(height: 12),
          ],
        );
      },
    );
  }

  List<DepartureDTO> _getMockDepartures() {
    return [
      DepartureDTO(
        lineDisplayName: 'Toyota Line',
        departureTime: domain.TimeOfDay(hour: 9, minute: 30),
        arrivalTime: domain.TimeOfDay(hour: 9, minute: 45),
        destinationName: 'Toyota Campus',
        direction: domain.RouteDirection.forward,
        isNearestDeparture: true,
        minutesUntilDeparture: 5,
      ),
      DepartureDTO(
        lineDisplayName: 'Toyota Line',
        departureTime: domain.TimeOfDay(hour: 10, minute: 0),
        arrivalTime: domain.TimeOfDay(hour: 10, minute: 15),
        destinationName: 'Toyota Station',
        direction: domain.RouteDirection.forward,
        isNearestDeparture: false,
        minutesUntilDeparture: 35,
      ),
      DepartureDTO(
        lineDisplayName: 'Toyota Line',
        departureTime: domain.TimeOfDay(hour: 10, minute: 30),
        arrivalTime: domain.TimeOfDay(hour: 10, minute: 45),
        destinationName: 'Toyota Campus',
        direction: domain.RouteDirection.forward,
        isNearestDeparture: false,
        minutesUntilDeparture: 65,
      ),
    ];
  }
}
