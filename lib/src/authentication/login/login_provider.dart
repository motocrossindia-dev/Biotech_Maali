import 'dart:developer';

import 'package:biotech_maali/import.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginProvider extends ChangeNotifier {
  LoginRepository loginRepository = LoginRepository();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _referralCode = TextEditingController();
  final TextEditingController _emailId = TextEditingController();

  TextEditingController get name => _name;
  TextEditingController get referralCode => _referralCode;
  TextEditingController get emailId => _emailId;

  Future<void> accountRegister(BuildContext context, String mobileNumber) async {
    try {
      final result = await loginRepository.accountRegister(
          mobileNumber, name.text, referralCode.text);
      // _isLoading = false;
      if (result) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) =>  BottomNavWidget(),
          ),
          (route) => false,
        );
      } else {
        Fluttertoast.showToast(msg: "Something went wrong");
        return;
      }
    } catch (e) {
      log("Error : $e");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration failed: $e')),
      );
    }
  }
}
