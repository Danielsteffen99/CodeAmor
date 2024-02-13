import 'package:codeamor/views/components/SwipeCardComponent.dart';
import 'package:flutter/material.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';

import '../models/swipeCard.dart';


class Swipe extends StatefulWidget {
  const Swipe({super.key});

  @override
  State<Swipe> createState() => _SwipeState();
}

class _SwipeState extends State<Swipe> {
  List<SwipeItem> _swipeItems = <SwipeItem>[];
  MatchEngine? _matchEngine;
  // TODO Refactor this to load cards from the get potential profiles from the profile service
  final List<String> _names = [
    "Red",
    "Blue",
    "Green",
    "Yellow",
    "Orange",
    "Grey",
    "Purple",
    "Pink"
  ];
  final List<int> _ages = [
    1,2,3,4,5,6,7,8
  ];

  @override
  void initState() {
    // TODO Refactor this to load cards from the get potential profiles from the profile service
    for (int i = 0; i < _names.length; i++) {
      _swipeItems.add(SwipeItem(
          content: SwipeCard(name: _names[i], age: _ages[i]),
          likeAction: () {
            // TODO Call swipe service for like action
          },
          nopeAction: () {
            // TODO Call swipe service for nope action
          },
          superlikeAction: () {
            // TODO Call swipe service for super like action
          },
          onSlideUpdate: (SlideRegion? region) async {
            // TODO Seems unnecessary for now, keep just for convenience else delete later
            // TODO Maybe we can check here how far we are in the stack and fetch more profiles???
          }));
    }

    // TODO Maybe pass a provider with swipeitems, that can load more
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
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Stack Finished"),
                duration: Duration(milliseconds: 500),
              ));
            },
            itemChanged: (SwipeItem item, int index) {
              // Runs each time you like, nope or superlikes
              print("item: ${item.content.name}, index: $index");
            },
            leftSwipeAllowed: true,
            rightSwipeAllowed: true,
            upSwipeAllowed: true,
            fillSpace: true,
            likeTag: Container(
              // TODO This is the like tag, make it prettier
              margin: const EdgeInsets.all(15.0),
              padding: const EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.green)
              ),
              child: Text('Like'),
            ),
            nopeTag: Container(
              // TODO This is the nope tag, make it prettier
              margin: const EdgeInsets.all(15.0),
              padding: const EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.red)
              ),
              child: Text('Nope'),
            ),
            superLikeTag: Container(
              // TODO This is the super like tag, make it prettier
              margin: const EdgeInsets.all(15.0),
              padding: const EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.orange)
              ),
              child: Text('Super Like'),
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
                  child: Text("Nope")),
              ElevatedButton(
                // TODO This is the super like button, make it prettier
                  onPressed: () {
                    _matchEngine!.currentItem?.superLike();
                  },
                  child: Text("Superlike")),
              ElevatedButton(
                // TODO This is the like button, make it prettier
                  onPressed: () {
                    _matchEngine!.currentItem?.like();
                  },
                  child: Text("Like"))
            ],
          ),
        )
      ])
    );
  }
}