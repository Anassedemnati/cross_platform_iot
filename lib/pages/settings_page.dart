import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: const Padding(
        padding:  EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Settings',
              style:  TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
             SizedBox(height: 8),
            Text('Change your settings here'),
             SizedBox(height: 8),
            Text('Coming soon...'),
             SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
