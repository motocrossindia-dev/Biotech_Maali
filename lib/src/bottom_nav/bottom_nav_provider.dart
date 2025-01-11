import 'package:flutter/material.dart';

class BottomNavProvider extends ChangeNotifier{
 
  bool? isTokenValid;

  int _currentIndex = 0;
  
  int get currentIndex => _currentIndex;

  void updateIndex(int index){
    _currentIndex = index;
    notifyListeners();
  }



}