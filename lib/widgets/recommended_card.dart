import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maos/shared/methods.dart';
import 'package:maos/shared/theme.dart';
import 'package:maos/models/news_model.dart';

class Recommend extends StatelessWidget {
  final NewsModel model;
  final VoidCallback? action;
  const Recommend({super.key, required this.model, this.action});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        height: 190,
        width: 180,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 6),
              height: 125,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: greyBlur20),
                image: DecorationImage(
                  image: model.imageUrl == null
                      ? const AssetImage('assets/images/news.jpg')
                      : NetworkImage(
                          model.imageUrl.toString(),
                        ) as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              model.title.toString(),
              style: semiboldTS.copyWith(height: 1.44),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.start,
            ),
            const Spacer(),
            Row(
              children: [
                Text(
                  capitalizeFirstLetter(model.sourceId.toString()),
                  style: mediumTS.copyWith(fontSize: 10),
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
                  DateFormat('d MMMM y').format(
                    DateTime.parse(model.pubDate.toString()),
                  ),
                  style: mediumTS.copyWith(fontSize: 10, color: greyBlur60),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// Skeleton Loading
class RecommendLoading extends StatelessWidget {
  const RecommendLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...List.generate(
          5,
          (_) => Container(
            margin: const EdgeInsets.only(right: 10),
            width: 170,
            child: Column(
              children: [
                CardLoading(
                  height: 125,
                  margin: const EdgeInsets.only(bottom: 6),
                  borderRadius: BorderRadius.circular(10),
                ),
                CardLoading(
                  height: 12,
                  margin: const EdgeInsets.only(bottom: 6),
                  borderRadius: BorderRadius.circular(8),
                ),
                CardLoading(
                  height: 12,
                  margin: const EdgeInsets.only(bottom: 10),
                  borderRadius: BorderRadius.circular(10),
                ),
                Row(
                  children: [
                    CardLoading(
                      height: 12,
                      width: 50,
                      margin: const EdgeInsets.only(right: 12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    CardLoading(
                      height: 12,
                      width: 70,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
