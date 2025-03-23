import 'dart:developer';
import 'package:biotech_maali/import.dart';
import 'package:biotech_maali/src/module/cart/cart_provider.dart';
import 'package:biotech_maali/src/module/product_list/product_list/model/product_list_model.dart';
import 'package:biotech_maali/src/module/product_list/product_list/product_list_repository.dart';

class ProductListProdvider extends ChangeNotifier {
  ProductListRepository productListRepository = ProductListRepository();

  List<Product> _allProducts = [];

  List<Product> get allProducts => _allProducts;

  setFilteredProducts(List<Product> products) async {
    _allProducts = products;
    notifyListeners();
  }

  void updateWishList(bool isWishlist, int productId) {
    final productIndex =
        _allProducts.indexWhere((product) => product.id == productId);
    if (productIndex != -1) {
      _allProducts[productIndex].isWishlist = !isWishlist;

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
      notifyListeners();
    }
  }

  Future<void> getCategoryProductList({String? categoryId}) async {
    try {
      final result =
          await productListRepository.getCotegoryProductList(categoryId!);
      _allProducts = result.products;
      notifyListeners();
    } catch (e) {
      log("error : ${e.toString()}");
    }
  }

  Future<void> getSubCategoryProductList({String? subCategoryId}) async {
    try {
      final result =
          await productListRepository.getSubCotegoryProductList(subCategoryId!);
      _allProducts = result.products;
      notifyListeners();
    } catch (e) {
      log("error : ${e.toString()}");
    }
  }
}
