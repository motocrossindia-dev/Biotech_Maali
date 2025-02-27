import 'package:biotech_maali/src/module/product_detail/product_details/model/order_response_model.dart';
import 'package:biotech_maali/src/module/wishlist/whishlist_provider.dart';
import 'package:biotech_maali/src/widgets/add_to_wishlist.dart';
import 'package:biotech_maali/src/module/product_detail/product_details/model/product_details_model.dart';
import 'package:biotech_maali/src/module/product_detail/product_details/product_details_repository.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../import.dart';

class ProductDetailsProvider extends ChangeNotifier {
  final ProductDetailsRepository productDetailsRepository;

  ProductDetailsProvider({
    ProductDetailsRepository? repository,
  }) : productDetailsRepository = repository ?? ProductDetailsRepository();

  bool _isLoading = false;
  String? _error;
  int _carouselIndex = 0;
  int _quantity = 1;
  bool _isWishlist = false;
  bool _isLoadingWishList = false;

  OrderResponseModel? _orderResponse;

  OrderResponseModel? get orderResponse => _orderResponse;

  ProductDetailModel? _productDetails;
  List<String> _carouselProductImageList = [];

  // Selected IDs
  int? _selectedSizeId;
  int? _selectedPlanterSizeId;
  int? _selectedPlanterId;
  int? _selectedColorId;

  // New property for selected tab
  int _selectedTab = 0;

  // Getters
  bool get isLoading => _isLoading;
  String? get error => _error;
  int get carouselIndex => _carouselIndex;
  int get quantity => _quantity;
  bool get isWishlist => _isWishlist;
  bool get isLoadingWishList => _isLoadingWishList;
  ProductDetailModel? get productDetails => _productDetails;
  List<String> get carouselProductImageList => _carouselProductImageList;

  int? get selectedSizeId => _selectedSizeId;
  int? get selectedPlanterSizeId => _selectedPlanterSizeId;
  int? get selectedPlanterId => _selectedPlanterId;
  int? get selectedColorId => _selectedColorId;

  // Getter for selected tab
  int get selectedTab => _selectedTab;

  // Method to set selected tab
  void setSelectedTab(int index) {
    _selectedTab = index;
    notifyListeners();
  }

  Future<void> fetchProductDetails(int productId) async {
    _isLoading = true;
    _error = null;

    try {
      final details =
          await productDetailsRepository.fetchProductDetails(productId);
      _productDetails = details;
      _updateCarouselImages();

      // Set default selections
      _selectedSizeId = details.data.product.sizeId;
      _selectedPlanterSizeId = details.data.product.planterSizeId;
      _selectedPlanterId = details.data.product.planterId;
      _selectedColorId = details.data.product.colorId;

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateSize(int sizeId, int productId) async {
    if (_selectedSizeId == sizeId) return;

    await _filterProduct(
      productId: productId,
      sizeId: sizeId,
      // Keep default values for other parameters
      // planterSizeId: _selectedPlanterSizeId,
      // planterId: _selectedPlanterId,
      // colorId: _selectedColorId,
    );
  }

  Future<void> updatePlanterSize(int planterSizeId, int productId) async {
    if (_selectedPlanterSizeId == planterSizeId) return;

    await _filterProduct(
      productId: productId,
      sizeId: _selectedSizeId,
      planterSizeId: planterSizeId,
      // // Keep default values for other parameters
      // planterId: _selectedPlanterId,
      // colorId: _selectedColorId,
    );
  }

  Future<void> updatePlanter(int planterId, int productId) async {
    if (_selectedPlanterId == planterId) return;

    await _filterProduct(
      productId: productId,
      sizeId: _selectedSizeId,
      planterSizeId: _selectedPlanterSizeId,
      planterId: planterId,
      // // Keep default values for other parameters
      // colorId: _selectedColorId,
    );
  }

  Future<void> updateColor(int colorId, int productId) async {
    if (_selectedColorId == colorId) return;

    await _filterProduct(
      productId: productId,
      sizeId: _selectedSizeId,
      planterSizeId: _selectedPlanterSizeId,
      planterId: _selectedPlanterId,
      colorId: colorId,
    );
  }

  Future<void> _filterProduct({
    required int productId,
    int? sizeId,
    int? planterSizeId,
    int? planterId,
    int? colorId,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final filteredDetails = await productDetailsRepository.filterProduct(
        productId: productId,
        sizeId: sizeId,
        planterSizeId: planterSizeId,
        planterId: planterId,
        colorId: colorId,
      );

      // Update selected IDs
      if (sizeId != null) _selectedSizeId = sizeId;
      if (planterSizeId != null) _selectedPlanterSizeId = planterSizeId;
      if (planterId != null) _selectedPlanterId = planterId;
      if (colorId != null) _selectedColorId = colorId;

      // Preserve ratings and reviews from original product details
      if (_productDetails != null) {
        final ProductDetailModel mergedDetails = ProductDetailModel(
          message: filteredDetails.message,
          data: ProductData(
            productWeights: filteredDetails.data.productWeights,
            productType: filteredDetails.data.productType,
            product: filteredDetails.data.product,
            productSizes: filteredDetails.data.productSizes,
            productPlanterSizes: filteredDetails.data.productPlanterSizes,
            productPlanters: filteredDetails.data.productPlanters,
            productColors: filteredDetails.data.productColors,
            productRating: _productDetails!.data.productRating,
            productReviews: _productDetails!.data.productReviews,
          ),
        );

        _productDetails = mergedDetails;
        _selectedSizeId = mergedDetails.data.product.sizeId;
        _selectedPlanterSizeId = mergedDetails.data.product.planterSizeId;
        _selectedPlanterId = mergedDetails.data.product.planterId;
        _selectedColorId = mergedDetails.data.product.colorId;
      } else {
        _productDetails = filteredDetails;
      }

      _updateCarouselImages();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addOrRemoveWhishlistCompinationProduct(
      int productId, BuildContext context) async {
    _isLoadingWishList = true;
    notifyListeners();

    try {
      bool result = await productDetailsRepository
          .addOrRemoveWhishlistCompinationProduct(productId);
      if (result) {
        _isWishlist = true;

        showWishlistMessage(context, true);
        notifyListeners();
      } else {
        _isWishlist = false;
        showWishlistMessage(context, false);
        notifyListeners();
      }
      await context.read<WishlistProvider>().fetchWishlist();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    } finally {
      // Remove productId from loading set
      _isLoadingWishList = false;

      notifyListeners();
    }
  }

  Future<void> placeOrder(int productId, BuildContext context) async {
    try {
      _isLoading = true;
      _error = '';
      notifyListeners();

      _orderResponse =
          await productDetailsRepository.buySingleProduct(productId, quantity);

      _isLoading = false;
      Fluttertoast.showToast(msg: "Order initiated successfully");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>  OrderSummaryScreen(
            orderData: _orderResponse!.data,
            isSingleProduct: true,
          ),
        ),
      );

    
    } on ProfileNotUpdatedException {
      _error = 'Please update your profile first';
      Fluttertoast.showToast(msg: _error!);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const EditProfileScreen()),
      );
    } on AddressNotUpdatedException {
      _error = 'Please add delivery address';
      Fluttertoast.showToast(msg: _error!);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AddEditAddressScreen(
            isAddAddress: true,
          ),
        ),
      );
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearError() {
    _error = '';
    notifyListeners();
  }

  void _updateCarouselImages() {
    if (_productDetails != null) {
      _carouselProductImageList = _productDetails!.data.product.images
          .map((image) => image.image)
          .toList();
    }
  }

  void increaseQuantity(int newQuantity) {
    _quantity += newQuantity;
    notifyListeners();
  }

  void decreaseQuantity(int newQuantity) {
    if (_quantity > 1) {
      _quantity -= newQuantity;
      notifyListeners();
    }
  }

  void onCarouselIndexChange(int current) {
    _carouselIndex = current;
    notifyListeners();
  }
}
