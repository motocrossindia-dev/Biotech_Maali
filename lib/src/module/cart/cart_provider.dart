import 'package:biotech_maali/src/module/cart/model/cart_item_model.dart';
import 'package:biotech_maali/src/widgets/add_to_cart.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'cart_repository.dart';

class CartProvider extends ChangeNotifier {
  final CartRepository _repository = CartRepository();
  List<CartItemModel> _cartItems = [];
  bool _isLoading = false;
  String _error = '';

  List<CartItemModel> get cartItems => _cartItems;
  bool get isLoading => _isLoading;
  String get error => _error;

  double get totalAmount {
    return _cartItems.fold(
        0, (sum, item) => sum + (double.parse(item.price) * item.quantity));
  }

  Future<void> fetchCartItems() async {
    try {
      _isLoading = true;
      notifyListeners();

      _cartItems = await _repository.getCartItems();
      _error = '';
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateCartItemQuantity(int cartId, int quantity) async {
    try {
      _isLoading = true;
      notifyListeners();

      final success =
          await _repository.updateCartItemQuantity(cartId, quantity);

      if (success) {
        await fetchCartItems(); // Refresh cart items after successful update
      } else {
        Fluttertoast.showToast(
          msg: "Failed to update quantity",
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }

      return success;
    } catch (e) {
      _error = e.toString();
      Fluttertoast.showToast(
        msg: "Error updating quantity",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> deleteCartItem(int cartId) async {
    try {
      _isLoading = true;
      notifyListeners();

      final success = await _repository.deleteCartItem(cartId);

      if (success) {
        _cartItems.removeWhere((item) => item.id == cartId);
        Fluttertoast.showToast(
          msg: "Item removed from cart",
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
      } else {
        Fluttertoast.showToast(
          msg: "Failed to remove item",
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }

      return success;
    } catch (e) {
      _error = e.toString();
      Fluttertoast.showToast(
        msg: "Error removing item",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> addToCart(
      int productId, int quantity, BuildContext context) async {
    try {
      _isLoading = true;
      notifyListeners();

      final success = await _repository.addToCart(productId, quantity);

      if (success) {
        await fetchCartItems(); // Refresh cart items after successful addition
        showCartMessage(context, true);
      } else {
        showCartMessage(context, false);
      }

      return success;
    } catch (e) {
      _error = e.toString();
      Fluttertoast.showToast(
        msg: "Error adding item to cart",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
