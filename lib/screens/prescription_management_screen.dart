import 'package:flutter/material.dart';
import '../models/prescription.dart';
import '../services/prescription_service.dart';
import '../widgets/prescription_card.dart';
import 'prescription_history_screen.dart';
import 'reminder_settings_screen.dart';
import 'prescription_detail_screen.dart';
import '../widgets/add_prescription_sheet.dart';

class PrescriptionManagementScreen extends StatefulWidget {
  const PrescriptionManagementScreen({super.key});

  @override
  State<PrescriptionManagementScreen> createState() => 
      _PrescriptionManagementScreenState();
}

class _PrescriptionManagementScreenState 
    extends State<PrescriptionManagementScreen> {
  final PrescriptionService _prescriptionService = PrescriptionService();
  late Future<List<Prescription>> _prescriptions;
  final _searchController = TextEditingController();
  bool _showActive = true;

  @override
  void initState() {
    super.initState();
    _prescriptions = _prescriptionService.getPrescriptions();
  }

  Widget _buildSearchAndFilter() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search prescriptions...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            onChanged: (value) {
              setState(() {
                _prescriptions = _prescriptionService.searchPrescriptions(value);
              });
            },
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Show Active Only'),
              Switch(
                value: _showActive,
                onChanged: (value) {
                  setState(() {
                    _showActive = value;
                    _prescriptions = _prescriptionService.getPrescriptions(
                      activeOnly: value,
                    );
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prescriptions'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () => _showReminderSettings(),
          ),
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => _showPrescriptionHistory(),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchAndFilter(),
          Expanded(
            child: FutureBuilder<List<Prescription>>(
              future: _prescriptions,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline, 
                          size: 48, color: Colors.red),
                        const SizedBox(height: 16),
                        Text('Error: ${snapshot.error}'),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _prescriptions = 
                                _prescriptionService.getPrescriptions();
                            });
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                final prescriptions = snapshot.data ?? [];

                if (prescriptions.isEmpty) {
                  return const Center(
                    child: Text('No prescriptions found'),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: prescriptions.length,
                  itemBuilder: (context, index) {
                    return PrescriptionCard(
                      prescription: prescriptions[index],
                      onTap: () => _viewPrescription(prescriptions[index]),
                      onReminderSet: () => 
                        _setReminder(prescriptions[index]),
                      onRefillRequest: () => 
                        _requestRefill(prescriptions[index]),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _addNewPrescription(),
        label: const Text('Add Prescription'),
        icon: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _addNewPrescription() async {
    final result = await showModalBottomSheet<Prescription>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => const AddPrescriptionSheet(),
    );

    if (result != null) {
      setState(() {
        _prescriptions = _prescriptionService.getPrescriptions();
      });
    }
  }

  void _viewPrescription(Prescription prescription) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PrescriptionDetailScreen(
          prescription: prescription,
        ),
      ),
    );
  }

  Future<void> _setReminder(Prescription prescription) async {
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time != null) {
      try {
        await _prescriptionService.setReminder(
          prescription.id,
          time,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Reminder set successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error setting reminder: $e')),
        );
      }
    }
  }

  Future<void> _requestRefill(Prescription prescription) async {
    try {
      await _prescriptionService.requestRefill(prescription.id);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Refill request sent successfully'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error requesting refill: $e')),
      );
    }
  }

  void _showReminderSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ReminderSettingsScreen(),
      ),
    );
  }

  void _showPrescriptionHistory() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PrescriptionHistoryScreen(),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}