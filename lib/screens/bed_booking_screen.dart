import 'package:flutter/material.dart';

class BedBookingScreen extends StatefulWidget {
  const BedBookingScreen({super.key});

  @override
  State<BedBookingScreen> createState() => _BedBookingScreenState();
}

class _BedBookingScreenState extends State<BedBookingScreen> {
  final _dateController = TextEditingController();
  String _selectedWard = 'General';
  int _numberOfDays = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Hospital Bed'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          DropdownButtonFormField<String>(
            value: _selectedWard,
            decoration: const InputDecoration(labelText: 'Select Ward'),
            items: ['General', 'Private', 'ICU', 'Emergency']
                .map((ward) => DropdownMenuItem(
                      value: ward,
                      child: Text(ward),
                    ))
                .toList(),
            onChanged: (value) => setState(() => _selectedWard = value!),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _dateController,
            decoration: const InputDecoration(
              labelText: 'Admission Date',
              suffixIcon: Icon(Icons.calendar_today),
            ),
            readOnly: true,
            onTap: () => _selectDate(context),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Number of Days:'),
              Expanded(
                child: Slider(
                  value: _numberOfDays.toDouble(),
                  min: 1,
                  max: 30,
                  divisions: 29,
                  label: _numberOfDays.toString(),
                  onChanged: (value) => setState(() => _numberOfDays = value.round()),
                ),
              ),
              Text(_numberOfDays.toString()),
            ],
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: _bookBed,
            child: const Text('Book Bed'),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
    );
    if (date != null) {
      setState(() {
        _dateController.text = date.toString().split(' ')[0];
      });
    }
  }

  void _bookBed() {
    // Implement bed booking logic
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Bed booked successfully')),
    );
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }
}