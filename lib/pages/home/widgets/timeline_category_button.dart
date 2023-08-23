import 'package:flutter/material.dart';
import 'package:maos/shared/methods.dart';
import 'package:maos/shared/theme.dart';

class Category extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback action;
  const Category({
    super.key,
    required this.title,
    required this.action,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        height: 35,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.black : greyBlur20,
          ),
          color: isSelected ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(1000),
        ),
        child: FittedBox(
          child: Text(
            capitalizeFirstLetter(title),
            style: mediumTS.copyWith(
              fontSize: 12,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
