import 'dart:developer';

import 'package:biotech_maali/src/module/home/home_repository.dart';
import 'package:biotech_maali/src/module/home/model/banner_model.dart';
import 'package:biotech_maali/src/module/home/model/product_model.dart';

import '../../../import.dart';

class HomeProvider extends ChangeNotifier {
  HomeProvider() {
    fetchHomeProducts();
    fetchBanners();
  }
  final HomeRepository _repository = HomeRepository();
  bool _isLoading = false;
  String? _error;
  List<ProductModel> _allProducts = [];

  // Getters
  bool get isLoading => _isLoading;
  String? get error => _error;
  List<ProductModel> get allProducts => _allProducts;

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
    const baseUrl =
        'http://www.dev.back.biotechmaali.com:8000'; // Add your base URL here
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
}
