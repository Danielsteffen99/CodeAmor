import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.orange,
      ),
      body: Container(
        color: Colors.orange[100],
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('General'),
              onTap: () {
              },
            ),
            ListTile(
              leading: const Icon(Icons.privacy_tip),
              title: const Text('Privacy'),
              onTap: () {
              },
            ),
            ListTile(
              leading: const Icon(Icons.data_usage),
              title: const Text('My Data'),
              onTap: () {
              },
            ),
            ListTile(
              leading: const Icon(Icons.description),
              title: const Text('License'),
              onTap: () {
              },
            ),
            ListTile(
              leading: const Icon(Icons.lightbulb_outline),
              title: const Text('Light/Dark Mode'),
              onTap: () {
              },
            ),
          ],
        ),
      ),
    );
  }
}