import '../../../import.dart';

class AddEditAddressScreen extends StatefulWidget {
  final bool isAddAddress;
  const AddEditAddressScreen({required this.isAddAddress, super.key});

  @override
  State<AddEditAddressScreen> createState() => _AddEditAddressScreenState();
}

class _AddEditAddressScreenState extends State<AddEditAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _mobileNumberController = TextEditingController();
  final _apartmentController = TextEditingController();
  bool _isHomeAddress = true;

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _mobileNumberController.dispose();
    _apartmentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        shadowColor: Colors.black,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        title: CommonTextWidget(
          title: widget.isAddAddress ? 'Add Address' : 'Edit Address',
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              OrderTrackerTimeline(
                                  currentStatus: OrderStatus.address),
                              sizedBoxHeight10,
                            ],
                          ),
                        ),
                      ),
                      sizedBoxHeight10,
                      Card(
                        color: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                controller: _nameController,
                                decoration: InputDecoration(
                                  hintText: 'Name',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade300),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        const BorderSide(color: Colors.blue),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        const BorderSide(color: Colors.red),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your name';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: _lastNameController,
                                decoration: InputDecoration(
                                  hintText: 'Last Name',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade300),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        const BorderSide(color: Colors.blue),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        const BorderSide(color: Colors.red),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your last name';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: _mobileNumberController,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  hintText: 'Mobile Number',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade300),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        const BorderSide(color: Colors.blue),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        const BorderSide(color: Colors.red),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your mobile number';
                                  }
                                  if (value.length != 10) {
                                    return 'Please enter a valid 10-digit mobile number';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: _apartmentController,
                                decoration: InputDecoration(
                                  hintText: 'Apartment, suite, etc. (optional)',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade300),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        const BorderSide(color: Colors.blue),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: _isHomeAddress,
                                        onChanged: (value) => setState(() =>
                                            _isHomeAddress = value ?? false),
                                      ),
                                      const CommonTextWidget(
                                          title: 'Home (All day Delivery)'),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: !_isHomeAddress,
                                        onChanged: (value) => setState(() =>
                                            _isHomeAddress = !(value ?? true)),
                                      ),
                                      const CommonTextWidget(
                                          title: 'Work (9am - 6pm)'),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      sizedBoxHeight20,
                      sizedBoxHeight20,
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 70,
              color: cWhiteColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 160,
                      height: 48,
                      child: CustomizableBorderColoredButton(
                          title: 'CANCEL', event: () {}),
                    ),
                    SizedBox(
                      width: 160,
                      height: 48,
                      child: CustomizableButton(
                        title: 'ADD ADDRESS',
                        event: () {
                          if (_formKey.currentState!.validate()) {
                            // Additional custom validations if needed
                            if (_nameController.text.isEmpty ||
                                _lastNameController.text.isEmpty ||
                                _mobileNumberController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Please fill in all required fields')),
                              );
                              return;
                            }

                            // Validate mobile number
                            if (_mobileNumberController.text.length != 10) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Please enter a valid 10-digit mobile number')),
                              );
                              return;
                            }

                            // If all validations pass
                            // For example:
                            // saveAddress({
                            //   'name': _nameController.text,
                            //   'lastName': _lastNameController.text,
                            //   'mobileNumber': _mobileNumberController.text,
                            //   'apartment': _apartmentController.text,
                            //   'isHomeAddress': _isHomeAddress,
                            // });

                            // Show success message
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(widget.isAddAddress
                                    ? 'Address Added Successfully'
                                    : 'Address Updated Successfully'),
                              ),
                            );

                            // Optional: Navigate back or to another screen
                            Navigator.of(context).pop();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _resetForm() {
    if (_formKey.currentState != null) {
      _formKey.currentState!.reset();
      _nameController.clear();
      _lastNameController.clear();
      _mobileNumberController.clear();
      _apartmentController.clear();
      setState(() {
        _isHomeAddress = true;
      });
    }
  }
}
