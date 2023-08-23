import 'package:flutter/material.dart';
import 'package:maos/shared/theme.dart';

class ProfileMenu extends StatelessWidget {
  final String title, iconUrl;
  final Color? color;
  final bool? isRouted;
  final VoidCallback? action;
  const ProfileMenu({
    super.key,
    required this.title,
    required this.iconUrl,
    this.action,
    this.color = Colors.black,
    this.isRouted = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            ImageIcon(
              AssetImage(iconUrl),
              size: 24,
              color: color,
            ),
            const SizedBox(
              width: 18,
            ),
            Text(
              title,
              style: semiboldTS.copyWith(
                fontSize: 16,
                color: color,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: const Spacer(),
            ),
            if (isRouted == true)
              const Icon(
                Icons.navigate_next,
                size: 25,
              ),
          ],
        ),
      ),
    );
  }
}
