import 'dart:developer';
import 'dart:ui';
import 'package:biotech_maali/src/module/home/home_repository.dart';
import 'package:biotech_maali/src/module/home/model/banner_model.dart';
import 'package:biotech_maali/src/module/home/model/category_model.dart';
import 'package:biotech_maali/src/module/home/model/home_product_model.dart';
import 'package:biotech_maali/src/module/wishlist/whishlist_repository.dart';
import 'package:biotech_maali/src/widgets/add_to_wishlist.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../import.dart';

class HomeProvider extends ChangeNotifier {
  HomeProvider() {
    refreshAll();
  }
  final HomeRepository _repository = HomeRepository();
  final WishlistRepository _wishlistRepository = WishlistRepository();

  bool _isLoading = false;
  String? _error;
  List<HomeProductModel> _allProducts = [];
  List<MainCategoryModel> _mainCategories = [];

  // Getters
  bool get isLoading => _isLoading;
  String? get error => _error;
  List<HomeProductModel> get allProducts => _allProducts;
  List<MainCategoryModel> get maincategories => _mainCategories;
  // List<int> _mainWishlistProductId = [];
  // List<int> get mainWishlistProductId => _mainWishlistProductId;

  // Filtered getters
  List<HomeProductModel> get featuredProducts =>
      _allProducts.where((product) => product.isFeatured).toList();

  List<HomeProductModel> get bestSellerProducts =>
      _allProducts.where((product) => product.isBestSeller).toList();

  List<HomeProductModel> get seasonalProducts =>
      _allProducts.where((product) => product.isSeasonalCollection).toList();

  List<HomeProductModel> get trendingProducts =>
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

  Future addToWishlist(
      int productId, bool isWishlist, BuildContext context) async {
    bool updatedIsWhishlist = false;
    if (isWishlist) {
      updatedIsWhishlist = false;
    } else if (!isWishlist) {
      updatedIsWhishlist = true;
    }
    try {
      bool result =
          await _wishlistRepository.addOrRemoveWishListMainProduct(productId);
      if (result) {
        // Find the product with the matching ID and update its wishlist status

        final productIndex =
            _allProducts.indexWhere((product) => product.id == productId);
        if (productIndex != -1) {
          _allProducts[productIndex].isWishlist =
              updatedIsWhishlist; // Set to true

          notifyListeners(); // Notify listeners about the update
        }
        if (isWishlist) {
          showWishlistMessage(context, false);
        } else if (!isWishlist) {
          showWishlistMessage(context, true);
        }
      }
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> refreshAll() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await Future.wait([
        fetchHomeProducts(),
        fetchMainCategories(),
        fetchBanners(),
      ]);

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  // Fetch banners
  Future<void> fetchBanners() async {
    try {
      _isBannersLoading = true;
      _bannersError = null;
      // notifyListeners();

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
      // notifyListeners();

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
      // notifyListeners();

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

  // Future<void> fetchWishlistProductId() async {
  //   try {
  //     _isLoading = true;
  //     _error = null;
  //     notifyListeners();

  //     List<dynamic> result = await _repository.getWhishlistId();
  //     // Convert the dynamic list to List<int>
  //     _mainWishlistProductId = result.map((e) => e as int).toList();

  //     log("minProductId list : $_mainWishlistProductId");

  //     _isLoading = false;
  //     notifyListeners();
  //   } catch (e) {
  //     log("Error in provider : ${e.toString()}");
  //     _isLoading = false;
  //     _error = e.toString();
  //     notifyListeners();
  //   }
  // }

  // refreshAll() {
  //   fetchBanners();
  //   fetchHomeProducts();
  //   fetchMainCategories();
  //   fetchWishlistProductId();
  // }
}
