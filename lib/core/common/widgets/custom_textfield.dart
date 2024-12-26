import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import '../fontstyles.dart';
import '../themes.dart';

class CustomForm extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final IconData? prefixIcon;
  final Color? prefixIconColor;
  final bool isPassword;
  final bool isEnabled;
  final int maxLines;
  final double borderradius;
  final String? hint;
  final Function(String)? onChanged;
  const CustomForm({
    super.key,
    required this.label,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.prefixIcon,
    this.prefixIconColor,
    this.isPassword = false,
    this.isEnabled = true,
    this.maxLines = 1,
    this.borderradius = 10,
    this.hint,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: semiboldTS),
        const SizedBox(height: 8),
        CustomTextField(
          controller: controller,
          focusNode: focusNode,
          keyboardType: keyboardType,
          prefixIcon: prefixIcon,
          prefixIconColor: prefixIconColor,
          isPassword: isPassword,
          isEnabled: isEnabled,
          maxLines: maxLines,
          borderradius: borderradius,
          hint: hint,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final IconData? prefixIcon;
  final Color? prefixIconColor;
  final bool isPassword;
  final bool isEnabled;
  final int maxLines;
  final double borderradius;
  final String? hint;
  final Function(String)? onChanged;
  const CustomTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.prefixIcon,
    this.prefixIconColor,
    this.isPassword = false,
    this.isEnabled = true,
    this.maxLines = 1,
    this.borderradius = 10,
    this.hint,
    this.onChanged,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: widget.isEnabled ? 1 : 0.6,
      child: TextFormField(
        onChanged: widget.onChanged,
        focusNode: widget.focusNode,
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        obscureText: widget.isPassword ? isHidden : false,
        style: mediumTS.copyWith(
          fontSize: 14,
          color: widget.isEnabled ? Theme.of(context).appColors.neutral100 : Theme.of(context).appColors.neutral80,
        ),
        maxLines: widget.maxLines,
        decoration: InputDecoration(
          enabled: widget.isEnabled,
          prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon, color: widget.prefixIconColor) : null,
          suffixIcon: widget.isPassword
              ? GestureDetector(
                  onTap: () => setState(() => isHidden = !isHidden),
                  child: !isHidden ? const Icon(IconsaxPlusLinear.eye) : const Icon(IconsaxPlusLinear.eye_slash),
                )
              : null,
          hintText: widget.hint,
          hintStyle: mediumTS.copyWith(fontSize: 14, color: Theme.of(context).appColors.neutral40),
          contentPadding: const EdgeInsets.all(16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderradius),
            borderSide: BorderSide(color: Theme.of(context).appColors.neutral10),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderradius),
            borderSide: BorderSide(color: Theme.of(context).appColors.neutral10),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderradius),
            borderSide: BorderSide(color: Theme.of(context).appColors.neutral40),
          ),
        ),
      ),
    );
  }
}
