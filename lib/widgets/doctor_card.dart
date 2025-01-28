import 'package:flutter/material.dart';
import '../models/doctor.dart';

class DoctorCard extends StatelessWidget {
  final Doctor doctor;
  final VoidCallback onTap;

  const DoctorCard({
    super.key,
    required this.doctor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(doctor.imageUrl),
        ),
        title: Text(doctor.name),
        subtitle: Text(doctor.specialty),
        trailing: Text('${doctor.rating} ★'),
        onTap: onTap,
      ),
    );
  }
} 