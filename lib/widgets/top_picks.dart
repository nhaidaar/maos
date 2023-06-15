import 'package:flutter/material.dart';
import 'package:maos/theme.dart';

class TopPicks extends StatelessWidget {
  final String title, publisher, minRead, date, imgUrl;
  final VoidCallback? action;
  const TopPicks(
      {super.key,
      required this.title,
      required this.publisher,
      this.minRead = '5',
      required this.date,
      required this.imgUrl,
      this.action});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 10),
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
            Flexible(
              child: Column(
                children: [
                  Text(
                    title,
                    style: semi.copyWith(fontSize: 14),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Text(
                        publisher,
                        style: medium.copyWith(fontSize: 11),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        height: 5,
                        width: 5,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: greyWhiteColor),
                      ),
                      Text(
                        '$minRead mins read',
                        style: medium.copyWith(fontSize: 11, color: greyBlur60),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        height: 5,
                        width: 5,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: greyWhiteColor),
                      ),
                      Text(
                        date,
                        style: medium.copyWith(fontSize: 11, color: greyBlur60),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
