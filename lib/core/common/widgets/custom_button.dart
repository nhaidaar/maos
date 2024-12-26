import 'package:flutter/material.dart';

import '../fontstyles.dart';
import '../themes.dart';

class CustomButton extends StatelessWidget {
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final Widget? icon;
  final String text;
  final bool disabled;
  final VoidCallback? onTap;
  const CustomButton({
    super.key,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.icon,
    required this.text,
    this.disabled = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: !disabled ? onTap : null,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: !disabled
              ? backgroundColor ?? Theme.of(context).colorScheme.primary
              : Theme.of(context).appColors.neutral20,
          borderRadius: BorderRadius.circular(100),
          border: borderColor != null ? Border.all(color: borderColor!) : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              icon!,
              const SizedBox(width: 8),
            ],
            Text(
              text,
              style: semiboldTS.copyWith(fontSize: 16, color: textColor ?? Theme.of(context).colorScheme.onPrimary),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomLoadingButton extends StatelessWidget {
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  const CustomLoadingButton({
    super.key,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(40),
        border: borderColor != null ? Border.all(color: borderColor!) : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 23,
            width: 23,
            child: CircularProgressIndicator(color: textColor ?? Theme.of(context).colorScheme.onPrimary),
          ),
        ],
      ),
    );
  }
}
