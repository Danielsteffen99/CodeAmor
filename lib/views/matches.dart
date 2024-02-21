import 'package:flutter/material.dart';
import '../../models/swipe_card.dart';

class Matches extends StatelessWidget {
  const Matches({super.key});

  void match(String likerUid) async {
    var matches = await matchRepository.getMatches(likerUid);
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orangeAccent,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            "Matches",
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20.0),
          Expanded(
            child: GridView.count(
              crossAxisCount: 4,
              children: match.map((swipeCard) => Match(swipeCard: swipeCard)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class Match extends StatelessWidget {
  final SwipeCard swipeCard;

  const Match({Key? key, required this.swipeCard}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      width: 80.0,
      height: 80.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        image: DecorationImage(
          image: NetworkImage(swipeCard.imageUrl),
          fit: BoxFit.cover,
        ),
        border: Border.all(
          color: Colors.orangeAccent,
          width: 2.0,
        ),
      ),
    );
  }
}



