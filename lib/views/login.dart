import 'package:codeamor/main.dart';
import 'package:codeamor/views/create_user.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../state/ProfileState.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void attemptLogin(String email, String password) async {
    try {
      var auth = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );

      // Ensures the context is mounted
      if (!context.mounted) return;

      // Sets the user in the global state
      Provider.of<ProfileState>(context, listen: false).setUser(auth.user!.uid);

      // Redirects the user to the main page
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const MyHomePage(title: "CodeAmor"),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'invalid-credential' || e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Forkerte login oplysninger'),
          )
        );
      } else {
        print(e);
      }
    }
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
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              Center(
                child: Padding(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: ElevatedButton(
                      onPressed: () => {
                        attemptLogin(emailController.text, passwordController.text)
                      },
                      child: const Text('Login')),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                    children: [
                      const Text.rich(
                        TextSpan(
                          text: "Har du ingen bruger?"
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        child: ElevatedButton(
                          onPressed: () => {
                            goToCreateUser()
                          },
                          child: const Text('Opret bruger')
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ),
      )
    );
  }
}