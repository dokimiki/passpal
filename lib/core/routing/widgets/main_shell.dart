import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:passpal/core/routing/routes.dart';

class MainShell extends StatefulWidget {
  const MainShell({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  void _onTabTapped(int index) {
    if (index == _currentIndex) return;

    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        context.goNamed(AppRoute.mainHome.name);
        break;
      case 1:
        context.goNamed(AppRoute.mainTimetable.name);
        break;
      case 2:
        context.goNamed(AppRoute.mainAssignments.name);
        break;
      case 3:
        context.goNamed(AppRoute.mainBus.name);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            activeIcon: Icon(Icons.calendar_today),
            label: 'Timetable',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_outlined),
            activeIcon: Icon(Icons.assignment),
            label: 'Assignments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_bus_outlined),
            activeIcon: Icon(Icons.directions_bus),
            label: 'Bus',
          ),
        ],
      ),
    );
  }
}
