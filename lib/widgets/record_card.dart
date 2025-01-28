import 'package:flutter/material.dart';
import '../models/medical_record.dart';

class RecordCard extends StatelessWidget {
  final MedicalRecord record;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final VoidCallback onShare;

  const RecordCard({
    super.key,
    required this.record,
    required this.onTap,
    required this.onDelete,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(record.title),
        subtitle: Text(record.description),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: onShare,
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: onDelete,
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
} 