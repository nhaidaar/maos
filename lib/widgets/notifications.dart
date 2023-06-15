import 'package:flutter/material.dart';
import 'package:maos/theme.dart';

class CustomNotification extends StatelessWidget {
  final String title, imgUrl, time;
  final VoidCallback? action;
  final bool isUnread;
  const CustomNotification(
      {super.key,
      required this.title,
      required this.imgUrl,
      required this.time,
      this.action,
      this.isUnread = true});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        padding: const EdgeInsets.all(16),
        height: 100,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: isUnread ? Colors.white : Colors.grey.withOpacity(0.1),
          border: BorderDirectional(
            bottom: BorderSide(
              color: Colors.grey.withOpacity(0.2),
            ),
          ),
        ),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 8),
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: AssetImage(imgUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  isUnread
                      ? Text(
                          title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: semi.copyWith(fontSize: 14),
                        )
                      : Text(
                          title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: regular.copyWith(
                            fontSize: 14,
                          ),
                        ),
                  const SizedBox(
                    height: 16,
                  ),
                  isUnread
                      ? Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 8),
                              height: 5,
                              width: 5,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.red),
                            ),
                            Text(
                              time,
                              style: medium.copyWith(
                                  fontSize: 11, color: greyBlur60),
                            ),
                          ],
                        )
                      : Text(
                          time,
                          style:
                              medium.copyWith(fontSize: 11, color: greyBlur60),
                        ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
