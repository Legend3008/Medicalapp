import 'package:flutter/material.dart';

class HospitalBedBookingScreen extends StatefulWidget {
  const HospitalBedBookingScreen({super.key});

  @override
  State<HospitalBedBookingScreen> createState() => _HospitalBedBookingScreenState();
}

class _HospitalBedBookingScreenState extends State<HospitalBedBookingScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  String? _selectedRoomType;
  DateTime? _admissionDate;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hospital Bed Booking'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Patient Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter patient name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedRoomType,
                decoration: const InputDecoration(
                  labelText: 'Room Type',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'general', child: Text('General Ward')),
                  DropdownMenuItem(value: 'private', child: Text('Private Room')),
                  DropdownMenuItem(value: 'icu', child: Text('ICU')),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedRoomType = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a room type';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 30)),
                  );
                  if (date != null) {
                    setState(() {
                      _admissionDate = date;
                    });
                  }
                },
                child: Text(_admissionDate == null 
                  ? 'Select Admission Date' 
                  : 'Date: ${_admissionDate.toString().split(' ')[0]}'),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Handle bed booking
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Booking bed...')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Book Bed'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}