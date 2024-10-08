import '../../import.dart';

class MobileNumberProvider extends ChangeNotifier{

  final TextEditingController _mobileNumber = TextEditingController();
  TextEditingController get mobileNumber => _mobileNumber;
  
}