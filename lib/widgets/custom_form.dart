import 'package:flutter/material.dart';

import '../shared/theme.dart';

class CustomFormField extends StatelessWidget {
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? hintText;
  const CustomFormField(
      {super.key,
      this.keyboardType,
      this.controller,
      this.hintText,
      this.focusNode});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: const EdgeInsets.all(20),
        hintStyle: mediumTS.copyWith(color: greyBlur40, fontSize: 14),
        border: defaultInputBorder,
        enabledBorder: defaultInputBorder,
      ),
    );
  }
}
