import 'package:biotech_maali/import.dart';

class SettingsProvider extends ChangeNotifier{
  LocalStorageService localStorageService = LocalStorageService();

 bool checkIsTokenValid(){
    if(localStorageService.token == "invalid"){
      return false;
    }else{
      return true;
    }
  }
}