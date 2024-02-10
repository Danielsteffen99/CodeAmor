import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'views/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the firebase user
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    // Define a widget
    Widget widget;

    // Assign widget based on availability of currentUser
    if (firebaseUser != null) {
      widget = const MyHomePage(title: "CodeAmor");
    } else {
      widget = const Login();
    }

    return MaterialApp(
      title: 'CodeAmor',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orangeAccent),
        useMaterial3: true,
      ),
      home: widget,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void logout() async {
    await FirebaseAuth.instance.signOut();
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
          child: ElevatedButton(
            onPressed: () => {
              logout()
            },
            child: const Text('Log ud')
          ),
        ),
      ),
    );
  }
}
