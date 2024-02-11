import 'package:codeamor/application/services/profile_service.dart';
import 'package:codeamor/application/services/user_service.dart';
import 'package:codeamor/views/create_user.dart';
import 'package:flutter/material.dart';

import 'Profile.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final UserService userService;
  late final ProfileService profileService;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    userService = UserService(context);
    profileService = ProfileService(context);
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void attemptLogin(String email, String password) async {

    var loginRes = await userService.login(email, password);

    if (!loginRes.success) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Forkerte login oplysninger'),
          )
      );
    }

    if (loginRes.result.user == null) return;
    var loginProfileRes = await profileService.setLoggedInProfile(loginRes.result.user?.uid);

    if (!loginProfileRes.success) return;

    // Redirects the user to the main page
    if (!context.mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => Profile(),
      ),
    );
  }

  void goToCreateUser() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const CreateUser(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/CodeAmorLogo.jpg"),
            alignment: Alignment.topCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Center the column vertically
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Adgangskode',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: ElevatedButton(
                    onPressed: () => attemptLogin(emailController.text, passwordController.text),
                    child: const Text('Login'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                    children: [
                      const Text(
                        "Har du ingen bruger?",
                        textAlign: TextAlign.center, // Center the text horizontally
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () => goToCreateUser(),
                        child: const Text('Opret bruger'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }