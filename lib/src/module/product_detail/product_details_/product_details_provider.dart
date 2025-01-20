import 'package:flutter/material.dart';
import 'package:biotech_maali/src/module/product_detail/product_details_/model/product_details_model.dart';
import 'package:biotech_maali/src/module/product_detail/product_details_/product_details_repository.dart';

class ProductDetailsProvider extends ChangeNotifier {
  final ProductDetailsRepository productDetailsRepository;

  ProductDetailsProvider({
    ProductDetailsRepository? repository,
  }) : productDetailsRepository = repository ?? ProductDetailsRepository();

  bool _isLoading = false;
  String? _error;
  int _carouselIndex = 0;
  int _quantity = 1;

  // Product data
  ProductDetailModel? _productDetails;
  List<String> _carouselProductImageList = [];

  // Selected IDs
  int? _selectedSizeId;
  int? _selectedPlanterSizeId;
  int? _selectedPlanterId;
  int? _selectedColorId;

  // Getters
  bool get isLoading => _isLoading;
  String? get error => _error;
  int get carouselIndex => _carouselIndex;
  int get quantity => _quantity;
  ProductDetailModel? get productDetails => _productDetails;
  List<String> get carouselProductImageList => _carouselProductImageList;

  int? get selectedSizeId => _selectedSizeId;
  int? get selectedPlanterSizeId => _selectedPlanterSizeId;
  int? get selectedPlanterId => _selectedPlanterId;
  int? get selectedColorId => _selectedColorId;

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
    await _filterProduct(sizeId: sizeId, productId: productId);
  }

  Future<void> updatePlanterSize(int planterSizeId, int productId) async {
    if (_selectedPlanterSizeId == planterSizeId) return;
    await _filterProduct(planterSizeId: planterSizeId, productId: productId);
  }

  Future<void> updatePlanter(int planterId, int productId) async {
    if (_selectedPlanterId == planterId) return;
    await _filterProduct(planterId: planterId, productId: productId);
  }

  Future<void> updateColor(int colorId, int productId) async {
    if (_selectedColorId == colorId) return;
    await _filterProduct(colorId: colorId, productId: productId);
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
        sizeId: sizeId ?? _selectedSizeId,
        planterSizeId: planterSizeId ?? _selectedPlanterSizeId,
        planterId: planterId ?? _selectedPlanterId,
        colorId: colorId ?? _selectedColorId,
      );

      // Preserve ratings and reviews from original product details
      if (_productDetails != null) {
        final ProductDetailModel mergedDetails = ProductDetailModel(
          message: filteredDetails.message,
          data: ProductData(
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
      } else {
        _productDetails = filteredDetails;
      }

      _updateCarouselImages();

      // Update selected IDs
      if (sizeId != null) _selectedSizeId = sizeId;
      if (planterSizeId != null) _selectedPlanterSizeId = planterSizeId;
      if (planterId != null) _selectedPlanterId = planterId;
      if (colorId != null) _selectedColorId = colorId;

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
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
