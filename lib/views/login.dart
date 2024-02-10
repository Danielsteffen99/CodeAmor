import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF9100),
        title: Text("CodeAmor"),
      ),
      body: Center(
        child: Text("Hej fra Login"),
      ),
    );
  }
}