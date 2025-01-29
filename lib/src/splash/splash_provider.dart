import 'dart:developer';

import 'package:biotech_maali/src/bottom_nav/bottom_nav_widget.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:biotech_maali/src/splash/token_repository.dart';

class SplashProvider extends ChangeNotifier {
  SplashProvider({required BuildContext context}) {}
  bool isLoading = true; // To show the loading spinner initially
  String navigationTarget = ""; // "home", "login", or "error"

  final TokenRepository _tokenRepository = TokenRepository();

  Future<void> checkTokenAndNavigate(BuildContext context) async {
    bool isInternetOn = await _checkInternetConnection(context);
    if (!isInternetOn) {
      return;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      await Future.delayed(const Duration(seconds: 3)); // Add 3-second delay

      String? accessToken = prefs.getString("accessToken");
      String? refreshToken = prefs.getString("refreshToken");

      if (accessToken == null || refreshToken == null) {
        navigationTarget = "login";
      } else {
        bool isAccessTokenValid =
            await _tokenRepository.verifyToken(accessToken);

        if (isAccessTokenValid) {
          navigationTarget = "home";
        } else {
          String? newAccessToken =
              await _tokenRepository.refreshToken(refreshToken);

          if (newAccessToken != null) {
            await prefs.setString("accessToken", newAccessToken);
            navigationTarget = "home";
          } else {
            navigationTarget = "login";
          }
        }
      }
    } catch (e) {
      log("Error during token check: $e");
      navigationTarget = "error";
    } finally {
      isLoading = false;
      notifyListeners(); // Notify listeners after state update
    }
  }

  navigateToHomeScreen(BuildContext context) async {
    bool isInternetOn = await _checkInternetConnection(context);
    if (!isInternetOn) {
      return;
    }
    await Future.delayed(const Duration(seconds: 3));
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const BottomNavWidget(),
      ),
    );
  }

  Future<bool> _checkInternetConnection(BuildContext context) async {
    List<ConnectivityResult> connectivityResults =
        await Connectivity().checkConnectivity();

    if (connectivityResults.isEmpty ||
        connectivityResults.first == ConnectivityResult.none) {
      // No internet connection, show a dialog or message
      _showNoInternetDialog(context);
      return false;
    }
    return true;
  }

  // Show dialog when there is no internet
  void _showNoInternetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("No Internet Connection"),
          content: const Text(
              "Please check your internet connection and try again."),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
