import 'dart:developer';
import 'package:biotech_maali/import.dart';
import 'package:biotech_maali/src/module/account/wallet/wallet_screen.dart';
import 'package:biotech_maali/src/module/explore/explore_repository.dart';
import 'package:biotech_maali/src/module/home/model/category_model.dart';
import 'package:biotech_maali/src/module/home/model/product_model.dart';
import 'package:biotech_maali/src/module/subcategory_list/model/subcategory_model.dart';

class ExploreProvider extends ChangeNotifier {
  ExploreProvider() {
    fetchMainCategories();
  }

  ExploreRepository exploreRepository = ExploreRepository();

  bool _isLoading = false;
  String? _error;
  int _selectedCategoryIndex = 0;
  int? _selectedCategoryId;

  int get selectedCategoryIndex => _selectedCategoryIndex;
  bool get isLoading => _isLoading;
  String? get error => _error;
  int? get selectedCategoryId => _selectedCategoryId;

  List<Subcategory> _subcategories = [];
  List<MainCategoryModel> _mainCategories = [];
  List<ProductModel> _products = [];

  List<Subcategory> get subcategories => _subcategories;
  List<MainCategoryModel> get maincategories => _mainCategories;
  List<ProductModel> get products => _products;

  void setSelectedCategory(int index, int categoryId) {
    _selectedCategoryIndex = index;
    _selectedCategoryId = categoryId;
    fetchSubcategory(categoryId);
    notifyListeners();
  }

  Future<void> fetchSubcategory(int categoryId) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final response = await exploreRepository.getSubcategories(categoryId);

      if (response == null) {
        return;
      }

      _subcategories = response.data.subCategories;
      notifyListeners();
    } catch (e) {
      log("error: ${e.toString()}");
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchMainCategories() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final categoryResponse = await exploreRepository.getMainCategories();
      _mainCategories = categoryResponse.data.categories;

      // Set initial category and fetch its subcategories
      if (_mainCategories.isNotEmpty) {
        _selectedCategoryId = _mainCategories[0].id;
        await fetchSubcategory(_selectedCategoryId!);
      }

      log("Main Categories: ${_mainCategories.toString()}");
    } catch (e) {
      _error = e.toString();
      log("Error fetching categories: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<List<ProductModel>> fetchSubcategoryProducts(
      String subcategoryName, int subcategoryId, BuildContext context) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      List<ProductModel>? response =
          await exploreRepository.getSubcategoryProducts(subcategoryId);

      _isLoading = false;
      notifyListeners();

      if (response != null) {
        _products = response;
        // Only navigate if the context is still mounted
        if (context.mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const WalletScreen(),
            ),
          );
        }
        return _products;
      }

      return [];
    } catch (e) {
      log("error: ${e.toString()}");
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return [];
    }
  }
}
