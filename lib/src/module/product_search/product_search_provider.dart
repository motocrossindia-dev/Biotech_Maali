import 'package:biotech_maali/src/module/product_search/model/product_search_model.dart';
import 'package:biotech_maali/src/module/product_search/product_search_repository.dart';
import 'package:flutter/material.dart';

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
