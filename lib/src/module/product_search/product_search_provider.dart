import 'package:biotech_maali/import.dart';
import 'package:biotech_maali/src/module/cart/cart_provider.dart';
import 'package:biotech_maali/src/module/product_search/model/product_search_model.dart';
import 'package:biotech_maali/src/module/product_search/product_search_repository.dart';
import 'package:flutter/material.dart';

class ProductSearchProvider extends ChangeNotifier {
  final ProductSearchRepository _repository = ProductSearchRepository();
  List<ProductSearchModel> products = [];
  bool isLoading = false;
  String error = '';


  void updateWishList(bool isWishlist, int productId) {
    final productIndex =
        products.indexWhere((product) => product.id == productId);
    if (productIndex != -1) {
      products[productIndex].isWishlist = !isWishlist;

      notifyListeners();
    }
  }

  Future<void> updateCart(
      bool isCart, int productId, BuildContext context) async {
    final cartProvider = context.read<CartProvider>();
    await cartProvider.fetchCartItems();

    final productIndex =
        products.indexWhere((product) => product.id == productId);
    if (productIndex != -1) {
      products[productIndex].isCart = !isCart;
      notifyListeners();
    }
  }
  Future<void> searchProducts(String query) async {
    try {
      isLoading = true;
      error = '';
      notifyListeners();

      products = await _repository.searchProducts(query);
      
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      error = e.toString();
      notifyListeners();
    }
  }
}
