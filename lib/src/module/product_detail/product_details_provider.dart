import '../../../import.dart';

class ProductDetailsProvider extends ChangeNotifier{
 int _caroucelIndex = 0;
  int get caroucelIndex => _caroucelIndex;

  final List<String> caroucelProductImageList = [
    'https://i.pinimg.com/564x/4c/55/44/4c554429e984ea6279434269bb75e7eb.jpg',
    'https://i.pinimg.com/564x/80/a8/7e/80a87e9bac68c33bb1a8b5a4cb83669b.jpg',
    'https://i.pinimg.com/564x/ac/70/c6/ac70c657774a880ab60959698788022c.jpg',
    'https://i.pinimg.com/736x/ff/58/0b/ff580bf10de0a8e2144f2b777eafae5d.jpg',
    'https://i.pinimg.com/564x/d0/1c/0a/d01c0a825237fdede6e41c6f7f2f5553.jpg'
  ];

  onCaroucelIndexChange(int current){
    _caroucelIndex = current;
    notifyListeners();
  }

  
}