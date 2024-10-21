import 'package:biotech_maali/import.dart';

class HomeProvider extends ChangeNotifier{
  int _caroucelIndex = 0;
  int get caroucelIndex => _caroucelIndex;

  onCaroucelIndexChange(int current){
    _caroucelIndex = current;
    notifyListeners();
  }

  final List<String> caroucelImageList = [
    'https://www.direcional.com.br/wp-content/uploads/2023/09/plantas-pendentes-para-apartamento.jpg',
    'https://www.shutterstock.com/image-photo/green-leaves-tropical-plants-bush-260nw-2497781315.jpg',
    'https://www.shutterstock.com/image-vector/tropic-palm-leaf-isolated-monstera-260nw-2511912385.jpg',
    'https://static.vecteezy.com/system/resources/previews/000/414/254/non_2x/vector-green-leafy-plants.jpg',
  ];

}