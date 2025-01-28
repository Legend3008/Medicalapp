import 'package:flutter/material.dart';
import '../models/medical_record.dart';

class RecordViewerScreen extends StatelessWidget {
  final MedicalRecord record;

  const RecordViewerScreen({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(record.title),
      ),
      body: Center(
        child: Text('Viewing ${record.title}'),
        // TODO: Implement actual file viewing logic
      ),
    );
  }
} 