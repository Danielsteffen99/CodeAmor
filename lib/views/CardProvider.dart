import 'package:flutter/material.dart';

enum CardStatus { like, dislike, }

class CardProvider extends ChangeNotifier{
  List<String> _urlImages = [];
  bool _isDragging = false;
  double _angle = 0;
  Offset _position = Offset.zero;
  Size _screenSize = Size.zero;

  List<String> get urlImages => _urlImages;
  bool get isDragging => _isDragging;
  Offset get position => _position;
  double get angle => _angle;

  CardProvider(){
    resetUsers();
  }

  void setScreenSize (Size screenSize) => _screenSize = screenSize;

  void startPosition(DragStartDetails details) {
    _isDragging = true;

    notifyListeners();
  }

  void updatePosition(DragUpdateDetails details) {
    _position += details.delta;

    final x = _position.dx;
    _angle = 45 * x / _screenSize.width;

    notifyListeners();
  }

  void endPosition() {
    _isDragging = false;
    _position = Offset.zero;

    final status = getStatus();

    resetPosition();
  }

  void resetPosition() {
    _isDragging = false;
    _position = Offset.zero;
    _angle = 0;

    notifyListeners();
  }

CardStatus? getStatus(){
    final x = _position.dx;

    final d = 100;

    if (x >= d) {
      return CardStatus.like;
    }

}

  void resetUsers() {
    _urlImages = <String>[
      'Insert Url'
          'Insert Url'
          'Insert Url'
          'Insert Url'
          'Insert Url'
    ].reversed.toList();

    notifyListeners();
  }
}