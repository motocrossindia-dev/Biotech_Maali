import 'dart:developer';
import 'package:biotech_maali/src/module/home/home_repository.dart';
import 'package:biotech_maali/src/module/home/model/banner_model.dart';
import 'package:biotech_maali/src/module/home/model/category_model.dart';
import 'package:biotech_maali/src/module/home/model/product_model.dart';

import '../../../import.dart';

class HomeProvider extends ChangeNotifier {
  HomeProvider() {
    fetchHomeProducts();
    fetchMainCategories();
    fetchBanners();
    fetchWishlistProductId();
  }
  final HomeRepository _repository = HomeRepository();

  bool _isLoading = false;
  String? _error;
  List<ProductModel> _allProducts = [];
  List<MainCategoryModel> _mainCategories = [];

  // Getters
  bool get isLoading => _isLoading;
  String? get error => _error;
  List<ProductModel> get allProducts => _allProducts;
  List<MainCategoryModel> get maincategories => _mainCategories;
  List<int> _mainWishlistProductId = [];
  List<int> get mainWishlistProductId => _mainWishlistProductId;

  // Filtered getters
  List<ProductModel> get featuredProducts =>
      _allProducts.where((product) => product.isFeatured).toList();

  List<ProductModel> get bestSellerProducts =>
      _allProducts.where((product) => product.isBestSeller).toList();

  List<ProductModel> get seasonalProducts =>
      _allProducts.where((product) => product.isSeasonalCollection).toList();

  List<ProductModel> get trendingProducts =>
      _allProducts.where((product) => product.isTrending).toList();

  bool _isBannersLoading = false;

  // Separate error states
  String? _bannersError;
  String? _productsError;

  List<BannerModel> _banners = [];

  // Carousel related code (keeping existing functionality)
  bool get isBannersLoading => _isBannersLoading;

  String? get bannersError => _bannersError;
  String? get productsError => _productsError;
  List<BannerModel> get banners => _banners;
  int _caroucelIndex = 0;
  int get caroucelIndex => _caroucelIndex;

  List<String> get visibleHomeBanners {
    const baseUrl = BaseUrl.baseUrlForImages; // Add your base URL here
    return _banners
        .where((banner) =>
            banner.isVisible &&
            (banner.type == 'Home' || banner.type == 'Hero'))
        .map((banner) => '$baseUrl${banner.mobileBanner}')
        .toList();
  }

  void onCaroucelIndexChange(int current) {
    _caroucelIndex = current;
    notifyListeners();
  }

  // Fetch banners
  Future<void> fetchBanners() async {
    try {
      _isBannersLoading = true;
      _bannersError = null;
      notifyListeners();

      _banners = await _repository.getBanners();
      _bannersError = null;
    } catch (e) {
      _bannersError = e.toString();
      log('Banner fetch error: $e');
    } finally {
      _isBannersLoading = false;
      notifyListeners();
    }
  }

  // Fetch products
  Future<void> fetchHomeProducts() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      _allProducts = await _repository.getHomeProducts();

      for (var element in _allProducts) {
        log(element.image.toString());
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> fetchMainCategories() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final categoryResponse = await _repository.getMainCategories();
      _mainCategories = categoryResponse.data.categories;
      log("Main Categories: ${_mainCategories.toString()}");

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
      log("Error fetching categories: $e");
    }
  }

  Future<void> fetchWishlistProductId() async {
    


    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      List<dynamic> result = await _repository.getWhishlistId();
      // Convert the dynamic list to List<int>
      _mainWishlistProductId = result.map((e) => e as int).toList();

      log("minProductId list : $_mainWishlistProductId");

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      log("Error in provider : ${e.toString()}");
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  refreshAll() {
    fetchBanners();
    fetchHomeProducts();
    fetchMainCategories();
    fetchWishlistProductId();
  }
}
