import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maos/models/news_model.dart';
import 'package:maos/shared/methods.dart';
import 'package:maos/shared/theme.dart';

class TopPicksCard extends StatelessWidget {
  final NewsModel model;
  final VoidCallback? action;
  const TopPicksCard({
    super.key,
    required this.model,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        height: 70,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                border: Border.all(color: greyBlur20),
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: model.imageUrl == null
                      ? const AssetImage('assets/images/news.jpg')
                      : NetworkImage(model.imageUrl.toString())
                          as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    replaceSpecialCharacters(model.title.toString()),
                    style: semiboldTS.copyWith(fontSize: 14),
                    textAlign: TextAlign.justify,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        'Published by ',
                        style:
                            mediumTS.copyWith(fontSize: 11, color: greyBlur60),
                      ),
                      Text(
                        capitalizeFirstLetter(model.sourceId.toString()),
                        style: mediumTS.copyWith(fontSize: 11),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        height: 5,
                        width: 5,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: greyWhiteColor),
                      ),
                      Text(
                        DateFormat('d MMMM y').format(
                          DateTime.parse(model.pubDate.toString()),
                        ),
                        style:
                            mediumTS.copyWith(fontSize: 11, color: greyBlur60),
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

// Skeleton Loading
class TopPicksLoading extends StatelessWidget {
  const TopPicksLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...List.generate(
          5,
          (_) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                CardLoading(
                  height: 70,
                  width: 70,
                  margin: const EdgeInsets.only(right: 10),
                  borderRadius: BorderRadius.circular(8),
                ),
                Expanded(
                  child: Column(
                    children: [
                      CardLoading(
                        margin: const EdgeInsets.only(bottom: 8),
                        height: 12,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      CardLoading(
                        margin: const EdgeInsets.only(bottom: 16),
                        height: 12,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      Row(
                        children: [
                          CardLoading(
                            margin: const EdgeInsets.only(right: 12),
                            height: 12,
                            width: 140,
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
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
