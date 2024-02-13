import 'package:flutter/material.dart';

import '../../models/swipeCard.dart';

class SwipeCardComponent extends StatelessWidget {
  final SwipeCard swipeCard;

  const SwipeCardComponent({super.key, required this.swipeCard});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.orange,
      child: Text(
        "Navn: ${swipeCard.name} Fødselsdag: ${swipeCard.age}",
        style: const TextStyle(fontSize: 100),
      ),
    );
  }
}

