import 'package:codeamor/views/edit_profile.dart';
import 'package:codeamor/views/matches.dart';

import 'package:codeamor/views/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../application/services/profile_service.dart';
import '../application/services/user_service.dart';
import '../state/profile_state.dart';
import 'login.dart';
import 'swipe.dart';

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
                    child: Row(children: [
                      Consumer<ProfileState>(
                        builder: (context, profile, child) {
                          return CircleAvatar(
                            radius: 50,
                            backgroundImage:  NetworkImage(
                                profile.profile.image.isNotEmpty ? profile.profile.image : "https://firebasestorage.googleapis.com/v0/b/codea-6d3fa.appspot.com/o/profile_images%2Fprofile_picture.png?alt=media&token=01cb7f1b-3316-4a03-b721-aaa404788d7d"
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Consumer<ProfileState>(
                        builder: (context, profile, child) {
                          return Text(profile.profile.name ?? "",
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ));
                        },
                      )
                    ])
                ),
                const SizedBox(height: 20),
                Button(
                    icon: Icons.person,
                    label: 'Edit Profile',
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const EditProfile(),
                        ),
                      );
                    }),
                Button(
                    icon: Icons.favorite,
                    label: 'Swipe',
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const Swipe(),
                        ),
                      );
                    }),
                Button(
                    icon: Icons.mail,
                    label: 'Matches',
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const Matches(),
                        ),
                      );
                    }),
                Button(
                    icon: Icons.settings,
                    label: 'Settings',
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SettingsScreen(),
                        ),
                      );
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
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
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
