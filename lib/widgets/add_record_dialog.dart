import 'package:flutter/material.dart';
import '../models/medical_record.dart';

class AddRecordDialog extends StatefulWidget {
  const AddRecordDialog({super.key});

  @override
  State<AddRecordDialog> createState() => _AddRecordDialogState();
}

class _AddRecordDialogState extends State<AddRecordDialog> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _selectedType = 'lab';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Record'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            DropdownButtonFormField<String>(
              value: _selectedType,
              items: const [
                DropdownMenuItem(value: 'lab', child: Text('Lab Report')),
                DropdownMenuItem(value: 'prescription', child: Text('Prescription')),
              ],
              onChanged: (value) => setState(() => _selectedType = value!),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            final record = MedicalRecord(
              id: DateTime.now().toString(),
              title: _titleController.text,
              type: _selectedType,
              filePath: '',
              date: DateTime.now(),
              description: _descriptionController.text,
            );
            Navigator.pop(context, record);
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
} 