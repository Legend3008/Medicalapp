import 'package:flutter/material.dart';

class AvailabilityCalendar extends StatelessWidget {
  final Function(DateTime) onDateSelected;

  const AvailabilityCalendar({
    super.key,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: CalendarDatePicker(
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 30)),
        onDateChanged: onDateSelected,
      ),
    );
  }
} 