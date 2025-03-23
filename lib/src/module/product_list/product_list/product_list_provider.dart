import 'dart:developer';
import 'package:biotech_maali/import.dart';
import 'package:biotech_maali/src/module/cart/cart_provider.dart';
import 'package:biotech_maali/src/module/product_list/product_list/model/product_list_model.dart';
import 'package:biotech_maali/src/module/product_list/product_list/product_list_repository.dart';

class ProductListProdvider extends ChangeNotifier {
  ProductListRepository productListRepository = ProductListRepository();

  List<Product> _allProducts = [];
  List<Product> _originalProducts = []; // Keep original list for reverting to default
  bool _isLoading = false;
  String _currentSortOption = 'Default';

  List<Product> get allProducts => _allProducts;
  bool get isLoading => _isLoading;
  String get currentSortOption => _currentSortOption;

  setFilteredProducts(List<Product> products) async {
    _originalProducts = List.from(products); // Store original order
    _allProducts = products;
    notifyListeners();
  }

  void updateWishList(bool isWishlist, int productId) {
    final productIndex =
        _allProducts.indexWhere((product) => product.id == productId);
    if (productIndex != -1) {
      _allProducts[productIndex].isWishlist = !isWishlist;

      // Also update in original list
      final originalIndex = 
          _originalProducts.indexWhere((product) => product.id == productId);
      if (originalIndex != -1) {
        _originalProducts[originalIndex].isWishlist = !isWishlist;
      }

      notifyListeners();
    }
  }

  Future<void> updateCart(
      bool isCart, int productId, BuildContext context) async {
    final cartProvider = context.read<CartProvider>();
    await cartProvider.fetchCartItems();

    final productIndex =
        _allProducts.indexWhere((product) => product.id == productId);
    if (productIndex != -1) {
      _allProducts[productIndex].isCart = !isCart;
      
      // Also update in original list
      final originalIndex = 
          _originalProducts.indexWhere((product) => product.id == productId);
      if (originalIndex != -1) {
        _originalProducts[originalIndex].isCart = !isCart;
      }
      
      notifyListeners();
    }
  }

  Future<void> getCategoryProductList({String? categoryId}) async {
    _isLoading = true;
    try {
      final result =
          await productListRepository.getCotegoryProductList(categoryId!);
      _allProducts = result.products;
      _originalProducts = List.from(result.products); // Store original order
      notifyListeners();
      _isLoading = false;
    } catch (e) {
      log("error : ${e.toString()}");
      _isLoading = false;
    }
  }

  Future<void> getSubCategoryProductList({String? subCategoryId}) async {
    _isLoading = true;
    try {
      final result =
          await productListRepository.getSubCotegoryProductList(subCategoryId!);
      _allProducts = result.products;
      _originalProducts = List.from(result.products); // Store original order
      notifyListeners();
      _isLoading = false;
    } catch (e) {
      log("error : ${e.toString()}");
      _isLoading = false;
    }
  }

  // New method to sort products
  void sortProducts(String sortOption) {
    _currentSortOption = sortOption;
    
    // Create a new list to avoid modifying the original directly during sorting
    List<Product> sortedProducts = List.from(_allProducts);
    
    switch (sortOption) {
      case 'Default':
        // Return to original order
        sortedProducts = List.from(_originalProducts);
        break;
      
      case 'Price High To Low':
        sortedProducts.sort((a, b) => b.sellingPrice.compareTo(a.sellingPrice));
        break;
      
      case 'Price Low To High':
        sortedProducts.sort((a, b) => a.sellingPrice.compareTo(b.sellingPrice));
        break;
      
      case 'Alphabetically A-Z':
        sortedProducts.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
        break;
      
      case 'Alphabetically Z-A':
        sortedProducts.sort((a, b) => b.name.toLowerCase().compareTo(a.name.toLowerCase()));
        break;
    }
    
    _allProducts = sortedProducts;
    notifyListeners();
  }
}