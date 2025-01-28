import 'package:flutter/material.dart';
import '../models/prescription.dart';

class AddPrescriptionSheet extends StatefulWidget {
  const AddPrescriptionSheet({super.key});

  @override
  State<AddPrescriptionSheet> createState() => _AddPrescriptionSheetState();
}

class _AddPrescriptionSheetState extends State<AddPrescriptionSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _medicationController = TextEditingController();
  final _dosageController = TextEditingController();
  final _instructionsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Please enter a name' : null,
            ),
            TextFormField(
              controller: _medicationController,
              decoration: const InputDecoration(labelText: 'Medication'),
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Please enter medication' : null,
            ),
            TextFormField(
              controller: _dosageController,
              decoration: const InputDecoration(labelText: 'Dosage'),
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Please enter dosage' : null,
            ),
            TextFormField(
              controller: _instructionsController,
              decoration: const InputDecoration(labelText: 'Instructions'),
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Please enter instructions' : null,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  final prescription = Prescription(
                    id: DateTime.now().toString(),
                    name: _nameController.text,
                    medication: _medicationController.text,
                    dosage: _dosageController.text,
                    instructions: _instructionsController.text,
                    date: DateTime.now(),
                    isActive: true,
                    refillsRemaining: 3,
                  );
                  Navigator.pop(context, prescription);
                }
              },
              child: const Text('Add Prescription'),
            ),
          ],
        ),
      ),
    );
  }
} 