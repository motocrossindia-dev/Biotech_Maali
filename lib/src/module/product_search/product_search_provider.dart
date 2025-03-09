import 'package:flutter/material.dart';
import 'model/product_search_model.dart';
import 'product_search_repository.dart';

class ProductSearchProvider extends ChangeNotifier {
  final ProductSearchRepository _repository = ProductSearchRepository();
  List<ProductSearchModel> products = [];
  bool isLoading = false;
  String error = '';

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
