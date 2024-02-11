import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'CardProvider.dart';

class SwipeCard extends StatefulWidget {
  final String urlImage;

  const SwipeCard({ Key? key, 
    required this.urlImage,}) : super(key: key);
  
  @override
  State<SwipeCard> createState() => _SwipeCardState();
}

class _SwipeCardState extends State<SwipeCard> {
  @override
  Widget build(BuildContext context) => SizedBox.expand(
    child: buildFrontCard(),
  );

  Widget buildFrontCard() => GestureDetector(
    child: Builder(
      builder: (context) {
        final provider = Provider.of<CardProvider>(context);
        final position = provider.position;
        final m = provider.isDragging ? 0 : 400;

        return AnimatedContainer(
            curve: Curves.easeInOut,
            duration: Duration(microseconds: m),
            transform: Matrix4.identity()
              ..translate(position.dx, position.dy),
            child: buildCard(),
        );
      }
    ),
    onPanStart: (details) {
      final provider = Provider.of<CardProvider>(context);
          provider.startPosition(details);
    },
    onPanUpdate: (details) {
      final provider = Provider.of<CardProvider>(context);
      provider.updatePosition(details);
    },
    onPanEnd: (details){
      final provider = Provider.of<CardProvider>(context);
      provider.endPosition();
    }
  );


  Widget buildCard() => ClipRRect(
    borderRadius: BorderRadius.circular(20),
  child: Container(
    decoration: BoxDecoration(
      image:  DecorationImage(
        image: NetworkImage(widget.urlImage),
        fit: BoxFit.cover,
        alignment: const Alignment(-0.3, 0)
        )
      ),
    )
  );

}
 

