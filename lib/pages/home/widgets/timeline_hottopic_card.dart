import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:maos/models/news_model.dart';
import 'package:maos/shared/methods.dart';
import 'package:maos/shared/theme.dart';
import 'package:intl/intl.dart';

class HotTopicCard extends StatefulWidget {
  final NewsModel model;
  final VoidCallback? action;
  const HotTopicCard({
    super.key,
    required this.model,
    this.action,
  });

  @override
  State<HotTopicCard> createState() => _HotTopicCardState();
}

class _HotTopicCardState extends State<HotTopicCard> {
  bool _assetExists = false;

  // Check is the publisher logo exist in storage
  Future<void> checkAsset() async {
    bool assetExists =
        await doesAssetExist('assets/images/logo_${widget.model.sourceId}.png');

    setState(() {
      _assetExists = assetExists;
    });
  }

  @override
  void initState() {
    checkAsset();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.action,
      child: Padding(
        // Distance for each card
        padding: const EdgeInsets.only(right: 16),
        child: Stack(
          children: [
            // Thumbnail of News
            Container(
              height: 320,
              width: 320,
              decoration: BoxDecoration(
                border: Border.all(color: greyBlur20),
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: widget.model.imageUrl == null
                      ? const AssetImage(
                          'assets/images/news.jpg',
                        )
                      : NetworkImage(widget.model.imageUrl.toString())
                          as ImageProvider,
                ),
              ),
            ),

            // Details of News + Gradient
            Container(
              padding: const EdgeInsets.all(16),
              height: 320,
              width: 320,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.85)],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category of News
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: greyBlur20),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: FittedBox(
                      child: Text(
                        capitalizeFirstLetter(widget.model.category.toString()),
                        style: semiboldTS.copyWith(fontSize: 11),
                      ),
                    ),
                  ),

                  const Spacer(),

                  // Title of News
                  Text(
                    replaceSpecialCharacters(widget.model.title.toString()),
                    style: semiboldTS.copyWith(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),

                  const SizedBox(
                    height: 12,
                  ),

                  Row(
                    children: [
                      // Publisher Logo of News
                      Container(
                        margin: const EdgeInsets.only(right: 8),
                        height: 16,
                        width: 16,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: _assetExists
                                ? AssetImage(
                                    'assets/images/logo_${widget.model.sourceId}.png')
                                : const AssetImage('assets/images/navicon.png'),
                          ),
                        ),
                      ),

                      // Publisher Name of News
                      Text(
                        capitalizeFirstLetter(widget.model.sourceId.toString()),
                        style: mediumTS.copyWith(
                            fontSize: 10, color: Colors.white),
                      ),

                      const Spacer(),

                      // Date published of News
                      Text(
                        DateFormat('d MMMM y').format(
                          DateTime.parse(widget.model.pubDate.toString()),
                        ),
                        style: mediumTS.copyWith(
                            fontSize: 10, color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Skeleton Loading
class HotTopicLoading extends StatelessWidget {
  const HotTopicLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        const SizedBox(
          width: 16,
        ),
        ...List.generate(
          3,
          (_) => CardLoading(
            borderRadius: BorderRadius.circular(10),
            margin: const EdgeInsets.only(right: 16),
            height: 320,
            width: 320,
          ),
        ),
      ],
    );
  }
}
