import 'package:flutter/material.dart';
import '../models/doctor.dart';

class DoctorProfileScreen extends StatelessWidget {
  final Doctor doctor;

  const DoctorProfileScreen({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(doctor.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(doctor.imageUrl),
            ),
            const SizedBox(height: 16),
            Text('Specialty: ${doctor.specialty}'),
            Text('Hospital: ${doctor.hospital}'),
            Text('Experience: ${doctor.experience} years'),
            Text('Rating: ${doctor.rating}'),
          ],
        ),
      ),
    );
  }
} 