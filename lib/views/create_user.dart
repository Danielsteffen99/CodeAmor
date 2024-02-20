import 'package:codeamor/application/services/profile_service.dart';
import 'package:codeamor/application/services/user_service.dart';
import 'package:flutter/material.dart';
import 'Profile.dart';
import 'login.dart';

class CreateUser extends StatefulWidget {
  const CreateUser({super.key});

  @override
  State<CreateUser> createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final ProfileService profileService;
  late final UserService userService;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    profileService = ProfileService(context);
    userService = UserService(context);
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void createUser(String email, String password) async {
    var createUserRes = await userService.createUser(email, password);

    if (!context.mounted) return;

    if (!createUserRes.success) {
      if (createUserRes.error == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Din adgangskode er for svag'),
        ));
      } else if (createUserRes.error == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Der eksisterer allerede en konto med denne email'),
        ));
      }
      return;
    }

    var createProfileRes =
        await profileService.createProfile(createUserRes.result.user?.uid);

    if (!createProfileRes.success) return;
    if (!context.mounted) return;

    // Created account successfully and now redirects the user to the home page
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const Profile(),
      ),
    );
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
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: ElevatedButton(
                onPressed: () =>
                    {createUser(emailController.text, passwordController.text)},
                child: const Text('Opret bruger')),
          )
          ),
          Center(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: ElevatedButton(
                onPressed: () => {backToLogin()},
                child: const Text('Tilbage til login')),
          ))
        ],
      )),
    ));
  }
}
