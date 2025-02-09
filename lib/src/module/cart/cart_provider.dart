import 'package:biotech_maali/import.dart';
import 'package:biotech_maali/src/module/cart/model/cart_item_model.dart';
import 'package:biotech_maali/src/module/product_detail/product_details/product_details_repository.dart';
import 'package:biotech_maali/src/widgets/add_to_cart.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'cart_repository.dart';

class CartProvider extends ChangeNotifier {
  final CartRepository _repository = CartRepository();
  List<CartItemModel> _cartItems = [];
  bool _isLoading = false;
  final Map<int, bool> _quantityLoadingStates = {};
  final Map<int, bool> _deleteLoadingStates = {};
  String _error = '';
  bool _isPlacingOrder = false;

  bool get isPlacingOrder => _isPlacingOrder;
  List<CartItemModel> get cartItems => _cartItems;
  bool get isLoading => _isLoading;

  String get error => _error;

  bool isQuantityLoading(int cartId) => _quantityLoadingStates[cartId] ?? false;
  bool isDeleteLoading(int cartId) => _deleteLoadingStates[cartId] ?? false;

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
      _quantityLoadingStates[cartId] = true;
      notifyListeners();

      final success =
          await _repository.updateCartItemQuantity(cartId, quantity);

      if (success) {
        final itemIndex = _cartItems.indexWhere((item) => item.id == cartId);
        if (itemIndex != -1) {
          _cartItems[itemIndex] =
              _cartItems[itemIndex].copyWith(quantity: quantity);
          notifyListeners();
        }
      } else {
        await fetchCartItems();
        Fluttertoast.showToast(
          msg: "Failed to update quantity",
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }

      return success;
    } catch (e) {
      _error = e.toString();
      await fetchCartItems();
      return false;
    } finally {
      _quantityLoadingStates[cartId] = false;
      notifyListeners();
    }
  }

  Future<bool> deleteCartItem(int cartId) async {
    try {
      _deleteLoadingStates[cartId] = true;
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
      _deleteLoadingStates[cartId] = false;
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

  Future<bool> addToCartMainProduct(int productId, BuildContext context) async {
    try {
      _isLoading = true;
      notifyListeners();

      final success = await _repository.addToCartForMainProduct(productId);

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

  Future<void> placeOrder(BuildContext context) async {
    try {
      _isPlacingOrder = true;
      notifyListeners();

      final orderResponse = await _repository.placeOrderFromCart();

      _isPlacingOrder = false;
      Fluttertoast.showToast(msg: "Order initiated successfully");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OrderSummaryScreen(
            isSingleProduct: false,
            orderData: orderResponse.data,
          ),
        ),
      );
    } on ProfileNotUpdatedException {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const EditProfileScreen(),
        ),
      );
      Fluttertoast.showToast(
        msg: "Please complete your profile first",
        backgroundColor: Colors.red,
      );
    } on AddressNotUpdatedException {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AddEditAddressScreen(
            isAddAddress: true,
          ),
        ),
      );
      Fluttertoast.showToast(
        msg: "Please add delivery address",
        backgroundColor: Colors.red,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        backgroundColor: Colors.red,
      );
    } finally {
      _isPlacingOrder = false;
      notifyListeners();
    }
  }
}
