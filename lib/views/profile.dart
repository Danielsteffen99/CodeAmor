import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/profile_state.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: Consumer<ProfileState>(
        builder: (context, profile, child) {
          return ProfileView(
            name: profile.profile?.name ?? "",
            profileImage: profile.profile?.image ?? "images/CodeAmorLogo.jpg",
          );
        },
      ),
    );
  }
}

class ProfileView extends StatelessWidget {
  final String name;
  final String profileImage;

  const ProfileView({
    super.key,
    required this.name,
    required this.profileImage,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage(profileImage),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Center(
            child: Text(
              name,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        Button(
            icon: Icons.person,
            label: 'Edit Profile',
            onPressed: () {
              print('Profile');
            }),
        Button(
            icon: Icons.favorite,
            label: 'Swipe',
            onPressed: () {
              print('Swipe');
            }),
        Button(
            icon: Icons.mail,
            label: 'Matches',
            onPressed: () {
              print('Matches');
            }),
        Button(
            icon: Icons.settings,
            label: 'Settings',
            onPressed: () {
              print('Settings');
            }),
        Button(
            icon: Icons.logout,
            label: 'Logout',
            onPressed: () {
              print('Logout');
            }),
      ],
    ));
  }
}

class Button extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const Button({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
      child: GestureDetector(
        onTap: onPressed,
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
            SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
