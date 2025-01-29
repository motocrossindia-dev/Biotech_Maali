import 'dart:developer';

import 'package:biotech_maali/import.dart';
import 'package:biotech_maali/src/module/subcategory_list/model/subcategory_model.dart';
import 'package:biotech_maali/src/module/subcategory_list/sub_category_repository.dart';

class SubCategoryListProvider extends ChangeNotifier {
  final SubCategoryRepository _subCategoryRepository = SubCategoryRepository();
  List<Subcategory> _subcategories = [];
  bool _isLoading = false;
  String? _error;

  SubCategoryListProvider() {
    fetchSubcategory();
  }

  List<Subcategory> get subcategories => _subcategories;

  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchSubcategory() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final response = await _subCategoryRepository.getSubcategories();

      _subcategories = response.data.subCategories;

      // Changed from response.products to response.wishlists
      notifyListeners();
    } catch (e) {
      log("error: ${e.toString()}");
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
