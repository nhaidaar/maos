import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import '../themes.dart';

PreferredSizeWidget customAppBar(
  BuildContext context, {
  List<Widget>? actions,
}) {
  return AppBar(
    toolbarHeight: 72,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    elevation: 0,
    leadingWidth: 68,
    leading: GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        height: 48,
        width: 48,
        margin: const EdgeInsets.only(left: 18),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Theme.of(context).appColors.neutral10),
        ),
        child: Icon(IconsaxPlusLinear.arrow_left, size: 24),
      ),
    ),
    actions: actions,
  );
}
