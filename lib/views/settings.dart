import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Colors.orange,
      ),
      body: Container(
        color: Colors.orange[100],
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('General'),
              onTap: () {
                // Handle general settings
              },
            ),
            ListTile(
              leading: Icon(Icons.privacy_tip),
              title: Text('Privacy'),
              onTap: () {
                // Handle privacy settings
              },
            ),
            ListTile(
              leading: Icon(Icons.data_usage),
              title: Text('My Data'),
              onTap: () {
                // Handle data settings
              },
            ),
            ListTile(
              leading: Icon(Icons.description),
              title: Text('License'),
              onTap: () {
                // Handle license settings
              },
            ),
            ListTile(
              leading: Icon(Icons.lightbulb_outline),
              title: Text('Light/Dark Mode'),
              onTap: () {
                // Handle light/dark mode settings
              },
            ),
          ],
        ),
      ),
    );
  }
}