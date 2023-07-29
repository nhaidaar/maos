import 'package:flutter/material.dart';
import 'package:maos/theme.dart';

class ProfileMenu extends StatelessWidget {
  final String title, iconUrl;
  final int badge;
  final VoidCallback? action;
  const ProfileMenu({
    super.key,
    required this.title,
    required this.iconUrl,
    this.badge = 0,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        width: double.infinity,
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
            badge > 0
                ? Container(
                    width: 24,
                    height: 24,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                    child: Center(
                      child: Text(
                        badge.toString(),
                        style: mediumTS.copyWith(
                            color: Colors.white, fontSize: 12),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
