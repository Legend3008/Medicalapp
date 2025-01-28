import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/doctor_appointment_screen.dart';
import 'screens/bed_booking_screen.dart';

void main() {
  runApp(const HealthcareApp());
}

class HealthcareApp extends StatelessWidget {
  const HealthcareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Healthcare App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: const HomeScreen(),
      routes: {
        '/appointments': (context) => const DoctorAppointmentScreen(),
        '/bed-booking': (context) => const HospitalBedBookingScreen(),
      },
    );
  }
}