import 'package:flutter/material.dart';

class LabTestsScreen extends StatelessWidget {
  const LabTestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab Tests'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildTestCard(
            'Complete Blood Count',
            'Basic blood test that measures different blood components',
            '₹500',
          ),
          _buildTestCard(
            'Blood Sugar Test',
            'Measures glucose levels in blood',
            '₹300',
          ),
          _buildTestCard(
            'Thyroid Profile',
            'Comprehensive thyroid function test',
            '₹800',
          ),
          _buildTestCard(
            'Lipid Profile',
            'Measures cholesterol and triglycerides',
            '₹600',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _bookTest(context),
        label: const Text('Book Test'),
        icon: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildTestCard(String title, String description, String price) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        title: Text(title),
        subtitle: Text(description),
        trailing: Text(
          price,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  void _bookTest(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Test booking feature coming soon!')),
    );
  }
} 