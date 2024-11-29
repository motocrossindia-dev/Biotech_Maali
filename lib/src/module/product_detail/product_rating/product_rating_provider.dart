import 'package:biotech_maali/import.dart';

class ProductRatingProvider extends ChangeNotifier{

   int _rating = 0;
   int get rating => _rating;

  String _recommend = 'Yes';
  String get recommend => _recommend;

  setRating(int index){
    _rating = index + 1;
    notifyListeners();
  }

  setRecommend(String value){
    _recommend = value;
    notifyListeners();
  }
}