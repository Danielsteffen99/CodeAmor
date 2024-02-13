
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'state/profile_state.dart';
import 'views/Profile.dart';
import 'views/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
        providers: [(
          ChangeNotifierProvider(
            create: (context) => ProfileState())),
        ],
            child: const MyApp()
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var loggedIn =  Provider.of<ProfileState>(context, listen: false).isUserLoggedIn();

    Widget widget;
    if (loggedIn) {
      widget = const Profile();
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