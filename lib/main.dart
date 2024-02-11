import 'package:codeamor/infrastructure/repositories/Profile_repository.dart';
import 'package:codeamor/views/CardProvider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'state/profile_state.dart';
import 'views/SwipeCard.dart';
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
          Provider(create: (context) => const SwipeCard(urlImage: ""))
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

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => CardProvider(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
      ),
  );


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final ProfileRepository profileRepository = ProfileRepository();

  void logout() async {
    await FirebaseAuth.instance.signOut();

    // Ensures the context is mounted
    if (!context.mounted) return;

    Provider.of<ProfileState>(context, listen: false).removeUser();
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
        child: Column(
          children: [
            Consumer<ProfileState>(
              builder: (context, profile, child) {
                return Text('UID: ${profile.profile?.uid} ${profile.profile?.name}');
              },
            ),
            Center(
              child: ElevatedButton(
                onPressed: () => {
                  logout()
                },
                child: const Text('Log ud')
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScreenSwipe extends StatefulWidget {
  const ScreenSwipe({super.key});

  @override
  ScreenSwipeState createState() => ScreenSwipeState();
}

class ScreenSwipeState extends State<ScreenSwipe> {
  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16),
        child: const SwipeCard(
            urlImage: ''
        ),
      ),
    ),
  );
}
