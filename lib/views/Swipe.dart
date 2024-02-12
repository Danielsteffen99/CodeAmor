import 'package:codeamor/views/CardProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'SwipeCard.dart';

void main() {
  runApp(const ScreenSwipe());
}

class ScreenSwipe extends StatefulWidget {
  const ScreenSwipe({super.key});

Widget build(BuildContext context) => ChangeNotifierProvider(
  create: (context) => CardProvider(),
  child: const MaterialApp(
    debugShowCheckedModeBanner: false,
  ),
);

  @override
  ScreenSwipeState createState() => ScreenSwipeState();
}

class ScreenSwipeState extends State<ScreenSwipe> {
  @override
  Widget build(BuildContext context) =>
      Scaffold(
        body: SafeArea(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16),
            child: SwipeCards(),
          ),
        ),
      );

  Widget SwipeCards() {
    final provider = Provider.of<CardProvider>(context);
    final urlImages = provider.urlImages;

    return Stack(
      children: urlImages
          .map((urlImage) => SwipeCard(
                urlImage: urlImage,
                isFront: urlImages.last == urlImage,
          )).toList(),
    );
  }
}
