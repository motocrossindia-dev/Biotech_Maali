import 'dart:developer';
import 'package:biotech_maali/import.dart';
import 'package:biotech_maali/src/widgets/add_to_wishlist.dart';
import 'package:flutter/foundation.dart';
import 'package:biotech_maali/src/module/wishlist/model/wishlist_model.dart';
import 'package:biotech_maali/src/module/wishlist/whishlist_repository.dart';
import 'package:fluttertoast/fluttertoast.dart';

class WishlistProvider extends ChangeNotifier {
  final WishlistRepository _wishlistRepository = WishlistRepository();
  List<WishlistModel> _products = [];
  bool _isLoading = false;
  String? _error;

  WishlistProvider() {
    fetchWishlist();
  }

  List<WishlistModel> get products => _products;

  bool get isLoading => _isLoading;
  String? get error => _error;
  final Set<int> _loadingProductIds = {};
  Set<int> get loadingProductIds => _loadingProductIds;
  bool isProductLoading(int productId) =>
      _loadingProductIds.contains(productId);
  Future<void> fetchWishlist() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final WishlistResponse response = await _wishlistRepository.getWishlist();
      _products = response
          .wishlists; // Changed from response.products to response.wishlists
      notifyListeners();
    } catch (e) {
      log("error: ${e.toString()}");
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addToWishlist(int productId) async {
    try {
      bool result = await _wishlistRepository.addToWishlist(productId);
      if (result) {
        Fluttertoast.showToast(msg: "Product added to whishlist successfully");
      }
      // await fetchWishlist(); // Refresh the list
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> removeFromWishlist(int productId) async {
    try {
      bool result = await _wishlistRepository.removeFromWishlist(productId);
      if (result) {
        Fluttertoast.showToast(msg: "Item deleted from the wishlist");
      }
      await fetchWishlist(); // Refresh the list
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> addOrRemoveWhishlistMainProduct(
      int productId, BuildContext context) async {
    // Add productId to loading set
    _loadingProductIds.add(productId);
    notifyListeners();

    try {
      bool result =
          await _wishlistRepository.addOrRemoveWishListMainProduct(productId);
      if (result) {
        context.read<HomeProvider>().fetchWishlistProductId();
        showWishlistMessage(context, true);
        // Fluttertoast.showToast(msg: "Item added to the wishlist");
      } else {
        
        context.read<HomeProvider>().fetchWishlistProductId();
        showWishlistMessage(context, false);
      }
      await fetchWishlist();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    } finally {
      // Remove productId from loading set
      _loadingProductIds.remove(productId);
      notifyListeners();
    }
  }
}
