import '../models/doctor.dart';

class DoctorService {
  Future<List<Doctor>> getDoctors() async {
    // Simulated API call
    await Future.delayed(const Duration(seconds: 1));
    return _mockDoctors;
  }

  Future<List<Doctor>> searchDoctors(String query) async {
    return _mockDoctors
        .where((doc) =>
            doc.name.toLowerCase().contains(query.toLowerCase()) ||
            doc.specialty.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  Future<List<Doctor>> filterDoctorsBySpecialty(String specialty) async {
    if (specialty == 'All') return _mockDoctors;
    return _mockDoctors
        .where((doc) => doc.specialty == specialty)
        .toList();
  }

  Future<Doctor> getDoctorById(String id) async {
    await Future.delayed(const Duration(seconds: 1));
    return _mockDoctors.firstWhere((doc) => doc.id == id);
  }
}

final _mockDoctors = [
  Doctor(
    id: '1',
    name: 'Dr. John Smith',
    specialty: 'Cardiology',
    imageUrl: 'https://example.com/doctor1.jpg',
    rating: 4.5,
    hospital: 'Central Hospital',
    experience: 10,
  ),
  Doctor(
    id: '2',
    name: 'Dr. Sarah Wilson',
    specialty: 'Neurology',
    imageUrl: 'https://example.com/doctor2.jpg',
    rating: 4.8,
    hospital: 'City Medical Center',
    experience: 15,
  ),
]; 