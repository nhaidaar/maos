import 'package:flutter/material.dart';
import 'package:maos/theme.dart';

class Publisher extends StatelessWidget {
  final String name, imgUrl;
  final bool isSelected;
  final VoidCallback? action;
  const Publisher(
      {super.key,
      required this.name,
      required this.imgUrl,
      this.action,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        margin: const EdgeInsets.only(right: 18),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 6),
              height: 74,
              width: 74,
              decoration: BoxDecoration(
                border: Border.all(color: greyBlur20),
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(imgUrl),
                ),
              ),
            ),
            Text(
              name,
              style: semiboldTS,
            ),
            const SizedBox(
              height: 4,
            ),
            Container(
              height: 6,
              width: 6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? blackColor : Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
