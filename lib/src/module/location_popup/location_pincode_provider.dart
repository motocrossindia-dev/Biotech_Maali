import 'dart:developer';

import 'package:biotech_maali/import.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationPincodeProvider extends ChangeNotifier {
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  TextEditingController get pincodeController => _pincodeController;
  TextEditingController get addressController => _addressController;

  bool isLoading = false;
  LatLng? selectedLocation;
  GoogleMapController? _mapController;
  bool isLocationEnabled = false;
  bool showAllAddresses = false;
  bool isLogin = false;

  Future<void> checkUserLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLogin = prefs.getBool('isLogin') ?? false;
    notifyListeners();
  }

  Future<void> getCurrentLocation(BuildContext context) async {
    isLoading = true;

    try {
      // Request location permission
      LocationPermission permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permissions are denied')),
        );
        return;
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Set the current location
      LatLng currentLocation = LatLng(position.latitude, position.longitude);

      selectedLocation = currentLocation;
      isLoading = false;

      // Move camera to current location
      _mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: currentLocation,
            zoom: 15,
          ),
        ),
      );

      // Fetch address for current location
      await fetchAddressFromCoordinates(currentLocation, context);
    } catch (e) {
      isLoading = false;

      debugPrint('Error getting location: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not fetch current location')),
      );
    }
  }

  Future<void> fetchAddressFromCoordinates(
      LatLng location, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        location.latitude,
        location.longitude,
        localeIdentifier: "en_IN",
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;

        _addressController.text =
            "${place.locality == null ? "" : "${place.locality},"} ${place.subLocality == null ? "" : "${place.subLocality},"} ${place.subAdministrativeArea == null ? "" : "${place.subAdministrativeArea},"}"
            "${place.administrativeArea}, ${place.country}";
        _pincodeController.text = place.postalCode ?? '';
        log("_addressController.text: ${_addressController.text}");

        prefs.setString("user_current_address", _addressController.text.trim());

        prefs.setString("user_pincode", place.postalCode ?? '');
        prefs.setString("user_locality", place.locality ?? '');
      }
    } catch (e) {
      debugPrint('Error fetching address: $e');
    }
  }
}
