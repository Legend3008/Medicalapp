import 'package:flutter/material.dart';
import '../models/prescription.dart';

class PrescriptionCard extends StatelessWidget {
  final Prescription prescription;
  final VoidCallback onTap;
  final VoidCallback onReminderSet;
  final VoidCallback onRefillRequest;

  const PrescriptionCard({
    super.key,
    required this.prescription,
    required this.onTap,
    required this.onReminderSet,
    required this.onRefillRequest,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(prescription.name),
        subtitle: Text(prescription.medication),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.alarm),
              onPressed: onReminderSet,
            ),
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: onRefillRequest,
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
} 