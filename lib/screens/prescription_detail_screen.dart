import 'package:flutter/material.dart';
import '../models/prescription.dart';

class PrescriptionDetailScreen extends StatelessWidget {
  final Prescription prescription;

  const PrescriptionDetailScreen({
    super.key,
    required this.prescription,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prescription Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Medication: ${prescription.medication}'),
            Text('Dosage: ${prescription.dosage}'),
            Text('Instructions: ${prescription.instructions}'),
            Text('Refills Remaining: ${prescription.refillsRemaining}'),
          ],
        ),
      ),
    );
  }
} 