import 'package:codeamor/main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login.dart';

class CreateUser extends StatefulWidget {
  const CreateUser({super.key});

  @override
  State<CreateUser> createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
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

  void createUser(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const MyHomePage(title: "CodeAmor"),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Din adgangskode er for svag'),
            )
        );
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Der eksisterer allerede en konto med denne email'),
            )
        );
      }
    } catch (e) {
      print(e);
    }
  }

  void backToLogin() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const Login(),
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
                            createUser(emailController.text, passwordController.text)
                          },
                          child: const Text('Opret bruger')),
                      )
                  ),
                  Center(
                      child: Padding(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        child: ElevatedButton(
                            onPressed: () => {
                              backToLogin()
                            },
                            child: const Text('Tilbage til login')),
                      )
                  )
                ],
              )
          ),
        )
    );
  }
}