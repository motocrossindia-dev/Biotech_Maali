import 'package:biotech_maali/src/module/location_popup/location_pincode_provider.dart';
import 'package:biotech_maali/src/payment_and_order/change_address/model/address_model.dart';

import 'package:shimmer/shimmer.dart';

import '../../../import.dart';

class LocationPincodePopup extends StatefulWidget {
  final List<AddressModel> savedAddresses;

  const LocationPincodePopup({
    super.key,
    this.savedAddresses = const [],
  });

  @override
  State<LocationPincodePopup> createState() => _LocationPincodePopupState();
}

class _LocationPincodePopupState extends State<LocationPincodePopup> {
  // final TextEditingController _landmarkController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final popupProvider = context.read<LocationPincodeProvider>();
    popupProvider.getCurrentLocation(context);
    popupProvider.checkUserLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Consumer<LocationPincodeProvider>(
            builder: (context, provider, child) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Close button

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  SvgPicture.asset("assets/svg/location_popup_image.svg"),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'For a seamless shopping experience!',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Conditional Login Button
                  if (!provider.isLogin)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF89B449),
                        minimumSize: const Size(double.infinity, 45),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MobileNumberScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'LOGIN',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),

                  const SizedBox(height: 20),

                  // Pincode Checking Section
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: provider.pincodeController,
                          decoration: const InputDecoration(
                            labelText: 'Change Pincode',
                            hintText: 'Check Delivery Info',
                          ),
                          keyboardType: TextInputType.number,
                          maxLength: 6,
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setString(
                              "user_pincode", provider.pincodeController.text);
                          await context
                              .read<HomeProvider>()
                              .getLocationPincode();
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(2), // Square shape
                            side: BorderSide(
                                color: cBottomNav,
                                width: 1), // Border color & width
                          ),
                          backgroundColor:
                              Colors.white, // Button background color
                          foregroundColor: cBottomNav, // Text color
                        ),
                        child: const Text('Submit'),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Current Location Button
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      provider.getCurrentLocation(context);
                    },
                    child: const Text('Use Current Location'),
                  ),

                  const SizedBox(height: 20),

                  // Saved Addresses Section
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

Widget buildShimmerEffect() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ],
        ),
        Container(
          height: 150,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          height: 20,
          width: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 20),
        Container(
          height: 45,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(height: 20),
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(height: 20),
        Container(
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          height: 45,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ],
    ),
  );
}



// class LocationPickerScreen extends StatefulWidget {
//   const LocationPickerScreen({super.key});

//   @override
//   _LocationPickerScreenState createState() => _LocationPickerScreenState();
// }

// class _LocationPickerScreenState extends State<LocationPickerScreen> {
//   GoogleMapController? _mapController;
//   LatLng? _selectedLocation;
//   bool _isLoading = false;
//   String _addressDetails = '';

//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation();
//   }

//   Future<void> _getCurrentLocation() async {
//     setState(() => _isLoading = true);

//     try {
//       LocationPermission permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Location permissions are denied')),
//         );
//         return;
//       }

//       Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );

//       LatLng currentLocation = LatLng(position.latitude, position.longitude);
//       setState(() {
//         _selectedLocation = currentLocation;
//         _isLoading = false;
//       });

//       _mapController?.animateCamera(
//         CameraUpdate.newCameraPosition(
//           CameraPosition(target: currentLocation, zoom: 18),
//         ),
//       );

//       await _fetchAddressFromCoordinates(currentLocation);
//     } catch (e) {
//       setState(() => _isLoading = false);
//       debugPrint('Error getting location: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Could not fetch current location')),
//       );
//     }
//   }

//   Future<void> _fetchAddressFromCoordinates(LatLng location) async {
//     try {
//       List<Placemark> placemarks = await placemarkFromCoordinates(
//         location.latitude,
//         location.longitude,
//         localeIdentifier: "en_IN",
//       );

//       if (placemarks.isNotEmpty) {
//         Placemark place = placemarks.first;

//         // Extract relevant address details
//         setState(() {
//           _addressDetails =
//               """ ${place.locality ?? ''}, ${place.subLocality ?? ''}, ${place.subAdministrativeArea ?? ''}, ${place.administrativeArea ?? ''}, ${place.country ?? ''}, ${place.postalCode ?? ''}"""
//                   .trim();
//         });
//       }
//     } catch (e) {
//       debugPrint('Error fetching address: $e');
//     }
//   }

//   void _onMapMoved(CameraPosition position) {
//     setState(() => _selectedLocation = position.target);
//   }

//   void _onCameraIdle() {
//     if (_selectedLocation != null) {
//       _fetchAddressFromCoordinates(_selectedLocation!);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Select Location'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.check),
//             onPressed: _selectedLocation != null
//                 ? () {
//                     Navigator.pop(context, {
//                       'location': _selectedLocation,
//                       'address': _addressDetails,
//                     });
//                   }
//                 : null,
//           ),
//         ],
//       ),
//       body: Stack(
//         children: [
//           GoogleMap(
//             initialCameraPosition: CameraPosition(
//               target: _selectedLocation ?? const LatLng(12.9716, 77.5946),
//               zoom: 18,
//             ),
//             onMapCreated: (GoogleMapController controller) {
//               _mapController = controller;
//             },
//             onCameraMove: _onMapMoved,
//             onCameraIdle: _onCameraIdle,
//             mapType: MapType.normal,
//             myLocationEnabled: true,
//             myLocationButtonEnabled: false,
//             zoomControlsEnabled: true,
//             zoomGesturesEnabled: true,
//           ),
//           const Positioned(
//             top: 0,
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: Icon(
//               Icons.location_pin,
//               color: Colors.red,
//               size: 50,
//             ),
//           ),
//           Positioned(
//             bottom: 16,
//             left: 16,
//             right: 16,
//             child: Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(10),
//                 boxShadow: const [
//                   BoxShadow(
//                     color: Colors.black26,
//                     blurRadius: 10,
//                     offset: Offset(0, 4),
//                   ),
//                 ],
//               ),
//               child: Text(
//                 _addressDetails.isNotEmpty
//                     ? _addressDetails
//                     : 'Moving the map to select location...',
//                 style: const TextStyle(fontSize: 14),
//                 maxLines: 6,
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: 80,
//             right: 16,
//             child: FloatingActionButton(
//               mini: true,
//               backgroundColor: Colors.white,
//               onPressed: _getCurrentLocation,
//               child: _isLoading
//                   ? const CircularProgressIndicator(
//                       strokeWidth: 2,
//                       valueColor: AlwaysStoppedAnimation<Color>(Colors.blue))
//                   : const Icon(Icons.my_location, color: Colors.blue),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
