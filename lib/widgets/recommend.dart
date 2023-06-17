import 'package:flutter/material.dart';
import 'package:maos/theme.dart';

class Recommend extends StatelessWidget {
  final String title, imgUrl, minRead, date;
  const Recommend(
      {super.key,
      required this.title,
      required this.imgUrl,
      required this.minRead,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      width: 170,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 6),
            height: 125,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(imgUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            title,
            style: semi.copyWith(
              fontSize: 12,
              height: 1.44,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              minRead == '1'
                  ? Text(
                      '1 min read',
                      style: medium.copyWith(fontSize: 10, color: greyBlur40),
                    )
                  : Text(
                      '$minRead mins read',
                      style: medium.copyWith(fontSize: 10, color: greyBlur40),
                    ),
              const SizedBox(
                width: 6,
              ),
              Container(
                height: 4,
                width: 4,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: greyBlur40),
              ),
              const SizedBox(
                width: 6,
              ),
              Text(
                date,
                style: medium.copyWith(fontSize: 10, color: greyBlur40),
              ),
            ],
          )
        ],
      ),
    );
  }
}
