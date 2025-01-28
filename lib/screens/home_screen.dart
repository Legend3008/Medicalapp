import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medical App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => Navigator.pushNamed(context, '/profile'),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        children: [
          _buildFeatureCard(
            context,
            'Find Doctors',
            Icons.medical_services,
            Colors.blue,
            () => Navigator.pushNamed(context, '/doctors'),
          ),
          _buildFeatureCard(
            context,
            'Appointments',
            Icons.calendar_today,
            Colors.green,
            () => Navigator.pushNamed(context, '/appointments'),
          ),
          _buildFeatureCard(
            context,
            'Medical Records',
            Icons.folder_open,
            Colors.orange,
            () => Navigator.pushNamed(context, '/medical_records'),
          ),
          _buildFeatureCard(
            context,
            'Prescriptions',
            Icons.receipt_long,
            Colors.purple,
            () => Navigator.pushNamed(context, '/prescriptions'),
          ),
          _buildFeatureCard(
            context,
            'Book Bed',
            Icons.bed,
            Colors.red,
            () => Navigator.pushNamed(context, '/bed_booking'),
          ),
          _buildFeatureCard(
            context,
            'Lab Tests',
            Icons.science,
            Colors.teal,
            () => Navigator.pushNamed(context, '/lab_tests'),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 32, color: color),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}