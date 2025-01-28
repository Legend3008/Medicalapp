import 'package:flutter/material.dart';
import '../models/prescription.dart';
import '../services/prescription_service.dart';

class PrescriptionHistoryScreen extends StatelessWidget {
  const PrescriptionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prescription History'),
      ),
      body: FutureBuilder<List<Prescription>>(
        future: PrescriptionService().getPrescriptions(activeOnly: false),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          
          final prescriptions = snapshot.data ?? [];
          return ListView.builder(
            itemCount: prescriptions.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(prescriptions[index].name),
              subtitle: Text(prescriptions[index].date.toString()),
            ),
          );
        },
      ),
    );
  }
} 