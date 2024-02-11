import 'package:flutter/material.dart';

class CardProvider extends ChangeNotifier{
  bool _isDragging = false;
  Offset _position = Offset.zero;

  bool get isDragging => _isDragging;
  Offset get position => _position;


  void startPosition(DragStartDetails details) {
    _isDragging = true;

    notifyListeners();
  }

  void updatePosition(DragUpdateDetails details) {
    _position += details.delta;

    notifyListeners();
  }

  void endPosition() {
    _isDragging = false;
    resetPosition();
  }

  void resetPosition() {
    _position = Offset.zero;

    notifyListeners();
  }
}