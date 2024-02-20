import 'package:codeamor/views/components/swipe_card_component.dart';
import 'package:flutter/material.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';
import '../application/services/swipe_service.dart';
import '../models/swipe_card.dart';


class Swipe extends StatefulWidget {
  const Swipe({super.key});

  @override
  State<Swipe> createState() => _SwipeState();
}

class _SwipeState extends State<Swipe> {
  late SwipeService swipeService;
  List<SwipeItem> _swipeItems = <SwipeItem>[];
  MatchEngine? _matchEngine;

  @override
  void initState() {
    swipeService = SwipeService();
    // TODO Refactor this to load cards from the get potential profiles from the profile service
    for (int i = 0; i < 50; i++) {
      var swipeCard = swipeService.getDummySwipeCard();
      _swipeItems.add(SwipeItem(content: swipeCard));
    }

    _matchEngine = MatchEngine(swipeItems: _swipeItems);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: Stack(children: [
        Container(
          height: MediaQuery.of(context).size.height - kToolbarHeight,
          child: SwipeCards(
            matchEngine: _matchEngine!,
            itemBuilder: (BuildContext context, int index) {
              return SwipeCardComponent(swipeCard: _swipeItems[index].content);
            },
            onStackFinished: () {
              // TODO This runs when there are no more cards in the stack.
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Stack Finished"),
                duration: Duration(milliseconds: 500),
              ));
            },
            itemChanged: (SwipeItem item, int index) {
              // Runs each time you like, nope or superlikes
              print("item: ${item.content.name}, index: $index");
              print(item.content.imageUrl);
              // TODO Load more data
              if (_swipeItems.length - index == 10) {
                for (int i = 0; i < 50; i++) {
                  var swipeCard = swipeService.getDummySwipeCard();
                  _swipeItems.add(SwipeItem(content: swipeCard));
                }
              }
            },
            leftSwipeAllowed: true,
            rightSwipeAllowed: true,
            upSwipeAllowed: true,
            fillSpace: true,
            likeTag: Container(
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(30.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.green, width: 4.0)
              ),
              child: const Text(
                  'Like',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 42.0,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            nopeTag: Container(
              // TODO This is the nope tag, make it prettier
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(30.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.red, width: 4.0)
              ),
              child: const Text(
                'NOPE',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 42.0,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            superLikeTag: Container(
              // TODO This is the super like tag, make it prettier
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(30.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.lightBlue, width: 4.0)
              ),
              child: const Text(
                'Super Like',
                style: TextStyle(
                  color: Colors.lightBlue,
                  fontSize: 42.0,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  // TODO This is the nope button, make it prettier
                  onPressed: () {
                    _matchEngine!.currentItem?.nope();
                  },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Set button color here
                ),
                child: const Text(
                  "Nope",
                  style: TextStyle( fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              ElevatedButton(
                // TODO This is the super like button, make it prettier
                  onPressed: () {
                    _matchEngine!.currentItem?.superLike();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue, // Set button color here
                  ),
                  child: const Text(
                      "Super Like",
                      style: TextStyle( fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold
                      ),
                  )
              ),
              ElevatedButton(
                // TODO This is the like button, make it prettier
                  onPressed: () {
                    _matchEngine!.currentItem?.like();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Set button color here
                  ),
                  child: const Text(
                    "Like",
                    style: TextStyle( fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold
                    ),
                  )
              )],
          ),
        )
      ])
    );
  }
}