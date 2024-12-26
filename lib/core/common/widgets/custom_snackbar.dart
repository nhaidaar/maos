import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';

import '../fontstyles.dart';
import '../themes.dart';

void showSnackbar(
  BuildContext context, {
  required String message,
  bool isError = false,
}) {
  AnimatedSnackBar(
    duration: const Duration(seconds: 3),
    builder: (context) {
      return Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Theme.of(context).appColors.neutral10),
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: Row(
          children: [
            Flexible(
              child: Text(
                message,
                style: semiboldTS,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 6),
            !isError
                ? const Icon(
                    Icons.check_circle_rounded,
                    color: Color(0xff00A47D),
                  )
                : const Icon(
                    Icons.error_rounded,
                    color: Color(0xffEA4335),
                  ),
          ],
        ),
      );
    },
  ).show(context);
}
