import 'package:flutter/material.dart';

class ReminderSettingsScreen extends StatelessWidget {
  const ReminderSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reminder Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SwitchListTile(
            title: const Text('Daily Reminders'),
            subtitle: const Text('Get notified about your medications'),
            value: true, // TODO: Implement actual settings logic
            onChanged: (value) {},
          ),
          ListTile(
            title: const Text('Reminder Time'),
            trailing: const Text('9:00 AM'), // TODO: Implement time picker
            onTap: () {},
          ),
        ],
      ),
    );
  }
} 