import 'package:biotech_maali/import.dart';
import 'package:biotech_maali/src/module/cart/cart_provider.dart';
import 'package:biotech_maali/src/module/product_search/model/product_search_model.dart';
import 'package:biotech_maali/src/module/product_search/product_search_repository.dart';

class ProductSearchProvider extends ChangeNotifier {
  final ProductSearchRepository _repository = ProductSearchRepository();
  List<ProductSearchModel> products = [];
  bool isLoading = false;
  String error = '';
  String? nextPage;
  bool isLoadingMore = false;
  String lastSearchQuery = '';

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
      lastSearchQuery = query; // Store the search query
      notifyListeners();

      final response = await _repository.searchProducts(query);
      products = response.products;
      nextPage = response.nextPage;

      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      error = e.toString();
      notifyListeners();
    }
  }

  Future<void> loadMore() async {
    if (nextPage == null || isLoadingMore) return;

    try {
      isLoadingMore = true;
      // notifyListeners();

      final response =
          await _repository.loadMoreProducts(nextPage!, lastSearchQuery);
      products.addAll(response.products);
      nextPage = response.nextPage;

      isLoadingMore = false;
      notifyListeners();
    } catch (e) {
      isLoadingMore = false;
      error = e.toString();
      notifyListeners();
    }
  }
}
