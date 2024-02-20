import 'package:codeamor/views/components/swipe_card_component.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';
import '../application/services/swipe_service.dart';
import '../models/swipe_card.dart';
import '../state/profile_state.dart';


class Swipe extends StatefulWidget {
  const Swipe({super.key});

  @override
  State<Swipe> createState() => _SwipeState();
}

class _SwipeState extends State<Swipe> {
  late SwipeService swipeService;
  final List<SwipeItem> _swipeItems = <SwipeItem>[];
  late MatchEngine _matchEngine;

  @override
  void initState() {
    swipeService = SwipeService();
    _matchEngine = MatchEngine(swipeItems: _swipeItems);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  SwipeItem createSwipeItem(SwipeCard sc) {
    return SwipeItem(
      content: sc,
      likeAction: () => {
        swipeService.likeProfile(Provider.of<ProfileState>(context, listen: false).getProfile().uid, sc.uid)
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: swipeService.getProfilesToSwipe(Provider.of<ProfileState>(context, listen: false).getProfile().uid),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data != null) {
              for (var sc in snapshot.data!) {
                _swipeItems.add(SwipeItem(content: sc));
              }
            }
            return Scaffold(
                backgroundColor: Colors.orange,
                body: Stack(children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height - kToolbarHeight,
                    child: SwipeCards(
                      matchEngine: _matchEngine,
                      itemBuilder: (BuildContext context, int index) {
                        return SwipeCardComponent(swipeCard: _swipeItems[index].content);
                      },
                      onStackFinished: () {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Der er ikke flere profiler at finde. Kom igen et andet tidspunkt!"),
                          duration: Duration(milliseconds: 2000),
                        ));
                      },
                      itemChanged: (SwipeItem item, int index) {
                        // Runs each time you like, nope or superlikes
                        // TODO Load more data
                        if (_swipeItems.length - index == 10) {

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
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            // TODO Create nice loading spinner here
            return Text("Loading");
          } else {
            return Text("Failed");
          }
        }
      );
    }
  }

