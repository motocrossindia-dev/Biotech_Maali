import '../../../import.dart';

class FiltersProvider extends ChangeNotifier {
  String selectedCategory = "Type of Plants";

  RangeValues _currentRangeValues = const RangeValues(0, 9999);
  RangeValues get currentRangeValues => _currentRangeValues;

  //TYPE OF PLNTS
  final List<Map<String, dynamic>> plantFilters = [
    {
      "id": "air-plant",
      "name": "Air Plant",
      "count": 15,
      "isSelected": true,
    },
    {
      "id": "flowering-plants",
      "name": "Flowering Plants",
      "count": 15,
      "isSelected": false,
    },
    {
      "id": "focal-plants",
      "name": "Focal Plants",
      "count": 5,
      "isSelected": false,
    },
    {
      "id": "ground-covers",
      "name": "Ground Covers",
      "count": 43,
      "isSelected": false,
    },
    {
      "id": "hedge-plants",
      "name": "Hedge Plants",
      "count": 23,
      "isSelected": false,
    },
    {
      "id": "screen-plants",
      "name": "Screen Plants",
      "count": 3,
      "isSelected": false,
    },
    {
      "id": "shrub-plants",
      "name": "Shrub Plants",
      "count": 42,
      "isSelected": false,
    }
  ];

  //IDEAL PLANT LOCATION
  final List<Map<String, dynamic>> plantLocationFilters = [
    {
      "id": "office-desk",
      "label": "Office Desk Plants",
      "count": 15,
      "isChecked": false
    },
    {
      "id": "office-premises",
      "label": "Office Premises Plants",
      "count": 15,
      "isChecked": false
    },
    {
      "id": "living-room",
      "label": "Plants For Living Room Tables",
      "count": 5,
      "isChecked": false
    },
    {
      "id": "balcony",
      "label": "Plants For Balconies",
      "count": 43,
      "isChecked": false
    },
    {"id": "window", "label": "Window plants", "count": 23, "isChecked": false},
  ];

  final List<Map<String, dynamic>> indoorOutdoor = [
    {"id": "indoor001", "label": "Indoor", "count": 30, "isSelected": false},
    {"id": "outdoor001", "label": "Outdoor", "count": 15, "isSelected": false},
  ];

  final List<Map<String, dynamic>> potSize = [
    {"id": "indoor001", "label": "Small", "count": 30, "isSelected": false},
    {"id": "outdoor001", "label": "Medium", "count": 15, "isSelected": false},
    {"id": "outdoor001", "label": "Large", "count": 15, "isSelected": false},
  ];

  setSelectedCategory(String category) {
    selectedCategory = category;
    notifyListeners();
  }

  setTypeOfPlants(bool value, int index) {
    plantFilters[index]["isSelected"] = value;
    notifyListeners();
  }

  setCurrentRangeValues(RangeValues values) {
    _currentRangeValues = values;
    notifyListeners();
  }

  setIdealPlantLocation(bool value, int index) {
    plantLocationFilters[index]["isChecked"] = value;
    notifyListeners();
  }

  setIndoorOutdoor(bool value, int index) {
    indoorOutdoor[index]["isSelected"] = value;
    notifyListeners();
  }

   setPotSize(bool value, int index) {
    potSize[index]["isSelected"] = value;
    notifyListeners();
  }

   void resetAllFilters() {
    // Reset plant filters
    for (var filter in plantFilters) {
      filter['isSelected'] = false;
    }

    // Reset plant location filters
    for (var filter in plantLocationFilters) {
      filter['isChecked'] = false;
    }

    // Reset indoor/outdoor filters
    for (var filter in indoorOutdoor) {
      filter['isSelected'] = false;
    }

    // Reset pot size filters
    for (var filter in potSize) {
      filter['isSelected'] = false;
    }

    // Notify listeners to rebuild the UI
    notifyListeners();
  }
}
