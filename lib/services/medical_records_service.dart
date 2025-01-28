import '../models/medical_record.dart';

class MedicalRecordsService {
  Future<List<MedicalRecord>> getRecords() async {
    await Future.delayed(const Duration(seconds: 1));
    return _mockRecords;
  }

  Future<void> uploadRecord(dynamic file) async {
    await Future.delayed(const Duration(seconds: 2));
  }

  Future<void> deleteRecord(String recordId) async {
    await Future.delayed(const Duration(seconds: 1));
  }
}

final _mockRecords = [
  MedicalRecord(
    id: '1',
    title: 'Blood Test Report',
    type: 'lab',
    filePath: '/path/to/file1.pdf',
    date: DateTime.now(),
    description: 'Regular blood work results',
  ),
  MedicalRecord(
    id: '2',
    title: 'Prescription',
    type: 'prescription',
    filePath: '/path/to/file2.pdf',
    date: DateTime.now().subtract(const Duration(days: 7)),
    description: 'Medication for fever',
  ),
]; 