import 'package:flutter/material.dart';
import '../widgets/feature_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Healthcare Services'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            FeatureCard(
              title: 'Doctor Appointment',
              icon: Icons.medical_services,
              onTap: () => Navigator.pushNamed(context, '/appointments'),
            ),
            FeatureCard(
              title: 'Hospital Bed Booking',
              icon: Icons.local_hospital,
              onTap: () => Navigator.pushNamed(context, '/bed-booking'),
            ),
            // Add more feature cards here
          ],
        ),
      ),
    );
  }
}