import 'package:biotech_maali/import.dart';

class LocalStoreListProvider extends ChangeNotifier {
  int selectedStoreIndex = 0; // Initial selection
  final List<Map<String, String>> stores = List.generate(
    6, // Generate 6 stores
    (index) => {
      'image':
          'assets/png/stores/download.jpeg', // You'll need to add this image to your assets
      'address':
          '41, 2nd Cross Rd, Chennakeshava Nagar, Ayappa Garden, Adugodi, Bengaluru, Karnataka 560027',
    },
  );

  void setSelectedStore(int index) {
    selectedStoreIndex = index;
    notifyListeners();
  }
}
