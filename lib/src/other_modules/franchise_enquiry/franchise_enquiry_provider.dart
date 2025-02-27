import 'package:biotech_maali/src/other_modules/franchise_enquiry/franchise_repository.dart';
import 'package:biotech_maali/src/other_modules/franchise_enquiry/model/franchise_model.dart';
import '../../../import.dart';

class FranchiseProvider extends ChangeNotifier {
  final FranchiseRepository _repository = FranchiseRepository();
  
  String _name = '';
  String _contact = '';
  String _email = '';
  String _area = '';
  String _address = '';
  String _message = '';
  bool _isLoading = false;
  String? _error;

  // Getters
  String get name => _name;
  String get contact => _contact;
  String get email => _email;
  String get area => _area;
  String get address => _address;
  String get message => _message;
  bool get isLoading => _isLoading;
  String? get error => _error;

  void setError(String? error) {
    _error = error;
    notifyListeners();
  }

  // Setters with validation
  void setName(String value) {
    _name = value.trim();
    _validateField('name', _name);
    notifyListeners();
  }

  void setContact(String value) {
    _contact = value.trim();
    _validateField('contact', _contact);
    notifyListeners();
  }

  void setEmail(String value) {
    _email = value.trim();
    _validateField('email', _email);
    notifyListeners();
  }

  void setArea(String value) {
    _area = value.trim();
    _validateField('area', _area);
    notifyListeners();
  }

  void setAddress(String value) {
    _address = value.trim();
    _validateField('address', _address);
    notifyListeners();
  }

  void setMessage(String value) {
    _message = value.trim();
    _validateField('message', _message);
    notifyListeners();
  }

  String? _validateField(String fieldName, String value) {
    switch (fieldName) {
      case 'name':
        if (value.isEmpty) {
          return 'Name is required';
        }
        if (value.length < 2) {
          return 'Name must be at least 2 characters';
        }
        break;
      
      case 'contact':
        if (value.isEmpty) {
          return 'Contact number is required';
        }
        if (!RegExp(r'^\d{10}$').hasMatch(value)) {
          return 'Please enter a valid 10-digit contact number';
        }
        break;
      
      case 'email':
        if (value.isEmpty) {
          return 'Email is required';
        }
        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
          return 'Please enter a valid email address';
        }
        break;
      
      case 'area':
        if (value.isEmpty) {
          return 'Area is required';
        }
        if (value.length < 5) {
          return 'Please provide more details about the area';
        }
        break;
      
      case 'address':
        if (value.isEmpty) {
          return 'Address is required';
        }
        if (value.length < 10) {
          return 'Please provide a complete address';
        }
        break;
      
      case 'message':
        if (value.isEmpty) {
          return 'Message is required';
        }
        break;
    }
    return null;
  }

  bool _validateForm() {
    final List<String> errors = [];

    void addError(String? error) {
      if (error != null) errors.add(error);
    }

    addError(_validateField('name', _name));
    addError(_validateField('contact', _contact));
    addError(_validateField('email', _email));
    addError(_validateField('area', _area));
    addError(_validateField('address', _address));
    addError(_validateField('message', _message));

    if (errors.isNotEmpty) {
      _error = errors.join('\n');
      notifyListeners();
      return false;
    }

    _error = null;
    return true;
  }

  Future<void> submitForm() async {
    if (!_validateForm()) return;

    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final franchise = FranchiseModel(
        name: _name,
        mobile: _contact,
        email: _email,
        area: _area,
        address: _address,
        message: _message,
      );

      // final result = 
      await _repository.submitFranchiseInquiry(franchise);
      
      // Reset form after successful submission
      _resetForm();
    } catch (e) {
      _error = _getErrorMessage(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  String _getErrorMessage(dynamic error) {
    if (error is Exception) {
      return error.toString().replaceAll('Exception: ', '');
    }
    return 'An unexpected error occurred. Please try again.';
  }

  void _resetForm() {
    _name = '';
    _contact = '';
    _email = '';
    _area = '';
    _address = '';
    _message = '';
    _error = null;
    notifyListeners();
  }
}