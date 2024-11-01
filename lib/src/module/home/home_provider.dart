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
    'https://i.pinimg.com/736x/ec/47/81/ec47814c24e7dd628231367b5f347b30.jpg',
    'https://i.pinimg.com/enabled/564x/40/c3/1b/40c31b1817456aa5141ea53732159de1.jpg',
    'https://i.pinimg.com/enabled/564x/31/53/18/3153186bbfa85df6dcfc6c7d23f93fde.jpg',
  ];

}