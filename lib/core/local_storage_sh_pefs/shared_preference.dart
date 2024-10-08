import 'dart:developer';
import '../../import.dart';

enum _Key {
  firstTime,
  isLoggedIn,
  token,
  lastVisited,
}

class LocalStorageService extends ChangeNotifier {
  SharedPreferences? _sharedPreferences;

  // init should initialize through cunstructor when local storage service call
  LocalStorageService() {
    init();
  }
/* initializing shared preference */
  Future<LocalStorageService> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return this;
  }

  // ***************************************************************************

  /* User Last visited screen state for navigate to that screen if user kill the aplication
  from some particular screens */

  Future<String> getLastVisited() async {
    if (_sharedPreferences == null) {
      await init();
    }
    var res = _sharedPreferences?.getString(_Key.lastVisited.toString());
    log('Last Visited : $res');
    return res ?? '/';
  }

  navigateToNextScreen(BuildContext context, String routeName) async {
    if (_sharedPreferences == null) {
      await init();
    }

    // final String lastVisitedKey = _Key.lastVisited.toString();
    _sharedPreferences?.setString(_Key.lastVisited.toString(),
        routeName.toString()); // Save the last visited screen

    log('Route Name : $routeName');
    log('lastVisited : ${_sharedPreferences?.getString(_Key.lastVisited.toString())}');
    // ignore: use_build_context_synchronously
    Navigator.pushNamed(context, routeName);
  }

  removeLastVisitedScreen() async {
    if (_sharedPreferences == null) {
      await init();
    }
    await _sharedPreferences?.remove(_Key.lastVisited.toString());
    log('lastVisited : ${_sharedPreferences?.getString(_Key.lastVisited.toString())}');
  }

  // ***************************************************************************

  /* users first state for intro store and get function  */

  bool getfirstTime() {
    var res = _sharedPreferences?.getBool(_Key.firstTime.toString());
    log('res : $res');
    return res ?? false;
  }

  setfirstTime(bool state) {
    _sharedPreferences?.setBool(_Key.firstTime.toString(), state);

    log('set isFirst: ${_sharedPreferences?.getBool(_Key.firstTime.toString())}');
  }

// ***************************************************************************
  /* Store and get the login state of user */

  bool get isLoggedIn {
    var res = _sharedPreferences?.getBool(_Key.isLoggedIn.toString());
    return res ?? false;
  }

  setIsLoggedIn(bool state) {
    _sharedPreferences?.setBool(_Key.isLoggedIn.toString(), state);
  }

// ***************************************************************************
/* Check the token status and store, get and remove the token   */

  String get token {
    var res = _sharedPreferences?.getString(_Key.token.toString());
    return res ?? "invalid";
  }

  setToken(String token) {
    _sharedPreferences?.setString(_Key.token.toString(), token);
  }

  removeToken() {
    _sharedPreferences?.remove(_Key.token.toString());

    log('Removed Token: ${_sharedPreferences?.getString(_Key.token.toString())}');
  }

// ***************************************************************************
}
