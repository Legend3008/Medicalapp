import 'package:flutter/material.dart';
import '../models/prescription.dart';

class PrescriptionService {
  Future<List<Prescription>> getPrescriptions({bool activeOnly = true}) async {
    await Future.delayed(const Duration(seconds: 1));
    return _mockPrescriptions.where((p) => !activeOnly || p.isActive).toList();
  }

  Future<List<Prescription>> searchPrescriptions(String query) async {
    return _mockPrescriptions
        .where((p) => p.name.toLowerCase().contains(query.toLowerCase()) ||
            p.medication.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  Future<void> setReminder(String prescriptionId, TimeOfDay time) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<void> requestRefill(String prescriptionId) async {
    await Future.delayed(const Duration(seconds: 1));
  }
}

final _mockPrescriptions = [
  Prescription(
    id: '1',
    name: 'Daily Medication',
    medication: 'Aspirin',
    dosage: '100mg',
    instructions: 'Take once daily',
    date: DateTime.now(),
    isActive: true,
    refillsRemaining: 3,
  ),
  Prescription(
    id: '2',
    name: 'Weekly Medication',
    medication: 'Vitamin D',
    dosage: '1000 IU',
    instructions: 'Take once weekly',
    date: DateTime.now(),
    isActive: true,
    refillsRemaining: 5,
  ),
]; 