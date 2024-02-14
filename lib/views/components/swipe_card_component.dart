import 'package:flutter/material.dart';
import '../../models/swipe_card.dart';

class SwipeCardComponent extends StatelessWidget {
  final SwipeCard swipeCard;

  const SwipeCardComponent({Key? key, required this.swipeCard}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(swipeCard.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Navn: ${swipeCard.name}",
                  style: const TextStyle(fontSize: 30, color: Colors.white),
                ),
                Text(
                  "Alder: ${swipeCard.age}",
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
                Text(
                  "Beskrivelse: ${swipeCard.description}",
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
