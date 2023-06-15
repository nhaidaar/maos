import 'package:flutter/material.dart';
import 'package:maos/theme.dart';

class Category extends StatelessWidget {
  final String title;
  final Color color;
  final VoidCallback? action;
  const Category(
      {super.key, required this.title, this.color = Colors.white, this.action});

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
              color: color == Colors.white ? greyBlur20 : Colors.black,
            ),
            color: color,
            borderRadius: BorderRadius.circular(1000)),
        child: FittedBox(
          child: Text(
            title,
            style: medium.copyWith(
                fontSize: 12,
                color: color == Colors.white ? Colors.black : Colors.white),
          ),
        ),
      ),
    );
  }
}
