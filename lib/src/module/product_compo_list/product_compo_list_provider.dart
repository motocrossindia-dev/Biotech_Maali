import 'package:biotech_maali/import.dart';
import 'package:biotech_maali/src/module/product_compo_list/model/product_compo_model.dart';
import 'package:biotech_maali/src/module/product_compo_list/product_compo_repository.dart';

class ProductCompoListProvider extends ChangeNotifier {
  final ProductCompoRepository _repository = ProductCompoRepository();
  bool _isLoading = false;
  String? _error;
  ProductCompoData? _comboData;

  bool get isLoading => _isLoading;
  String? get error => _error;
  ProductCompoData? get comboData => _comboData;
  List<ComboOffer> get comboOffers => _comboData?.comboOffers ?? [];
  List<ComboOffer> get shopTheLook => _comboData?.shopTheLook ?? [];

  Future<void> fetchComboOffers() async {
    try {
      _isLoading = true;
      _error = null;

      final response = await _repository.getComboOffers();
      _comboData = response.data;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
