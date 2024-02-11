import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../application/services/profile_service.dart';
import '../application/services/user_service.dart';
import '../state/profile_state.dart';
import 'login.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late final UserService userService;
  late final ProfileService profileService;

  @override
  void initState() {
    userService = UserService(context);
    profileService = ProfileService(context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void logout() {
    userService.logout();
    profileService.logout();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const Login(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.orange,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Consumer<ProfileState>(
                      builder: (context, profile, child) {
                        return CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage(profile.profile?.image ??
                              "images/CodeAmorLogo.jpg"),
                        );
                      },
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Center(
                    child: Consumer<ProfileState>(
                      builder: (context, profile, child) {
                        return Text(profile.profile?.name ?? "",
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ));
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
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
                      logout();
                    }),
              ],
            )));
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
