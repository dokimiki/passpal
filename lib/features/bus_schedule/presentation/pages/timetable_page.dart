import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/value_objects.dart';
import '../../application/controllers/schedule_controller.dart';
import '../widgets/next_departures_list.dart';
import '../widgets/empty_banner.dart';

class TimetablePage extends ConsumerStatefulWidget {
  final LineId lineId;
  final RouteDirection direction;

  const TimetablePage({
    super.key,
    required this.lineId,
    required this.direction,
  });

  @override
  ConsumerState<TimetablePage> createState() => _TimetablePageState();
}

class _TimetablePageState extends ConsumerState<TimetablePage> {
  @override
  void initState() {
    super.initState();
    // Load initial data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadDepartures();
    });
  }

  void _loadDepartures() {
    // This would trigger the schedule controller to load departures
    // For now, just a placeholder
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.lineId.value} - ${widget.direction.name}'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Column(
        children: [
          // Campus/Line/Direction selector chips
          _buildSelectionChips(),

          const SizedBox(height: 16),

          // Main content
          Expanded(child: _buildContent()),
        ],
      ),
    );
  }

  Widget _buildSelectionChips() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Route Selection',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              FilterChip(
                label: const Text('Toyota Campus'),
                selected: true,
                onSelected: (selected) {
                  // Handle campus selection
                },
              ),
              FilterChip(
                label: Text(widget.lineId.value),
                selected: true,
                onSelected: (selected) {
                  // Handle line selection
                },
              ),
              FilterChip(
                label: Text(widget.direction.name),
                selected: true,
                onSelected: (selected) {
                  // Handle direction selection
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    final state = ref.watch(
      scheduleControllerProvider(widget.lineId, widget.direction),
    );

    if (state.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error != null) {
      return EmptyBanner(message: 'Error', description: state.error!.message);
    }

    if (state.items.isEmpty) {
      return const EmptyBanner(
        message: 'No Service Available',
        description: 'There are no departures scheduled at this time.',
      );
    }

    return const NextDeparturesList();
  }
}
