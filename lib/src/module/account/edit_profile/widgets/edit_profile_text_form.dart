import 'package:flutter/material.dart';

import '../../../../../config/pallet.dart';

class EditProfileTextForm extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final TextInputType? keyboardType;

  const EditProfileTextForm(
      {required this.controller,
      required this.hintText,
      required this.labelText,
      this.keyboardType,
      super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(
        labelStyle: TextStyle(color: cBorderGrey),
        labelText: labelText,
        hintText: hintText,
        
        enabledBorder: UnderlineInputBorder(
          borderSide:
              BorderSide(color: cTextFormFieldGrey), // Color when not focused
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: cButtonGreen), // Color when focused
        ),
      ),
    );
  }
}
