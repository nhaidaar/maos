import 'package:flutter/material.dart';
import 'package:maos/theme.dart';

class ProfileMenu extends StatelessWidget {
  final String title, iconUrl;
  final VoidCallback? action;
  const ProfileMenu({
    super.key,
    required this.title,
    required this.iconUrl,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        padding: const EdgeInsets.only(bottom: 40),
        child: Row(
          children: [
            Image.asset(
              iconUrl,
              width: 24,
            ),
            const SizedBox(
              width: 18,
            ),
            Text(
              title,
              style: semiboldTS.copyWith(fontSize: 16),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
