import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:maos/models/news_model.dart';
import 'package:maos/shared/methods.dart';
import 'package:maos/theme.dart';
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

  Future<void> checkAsset() async {
    bool assetExists = await doesAssetExist(
        'assets/images/logo_${widget.model.sourceId}.png'); // Replace with the actual asset path.

    setState(() {
      _assetExists = assetExists;
    });
  }

  @override
  void initState() {
    super.initState();
    checkAsset();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.action,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(right: 16),
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
          Container(
            padding: const EdgeInsets.all(16),
            width: 320,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              gradient: LinearGradient(
                begin: Alignment.center,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            // margin: const EdgeInsets.all(12),
            width: 320,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                Container(
                  margin: const EdgeInsets.only(top: 172),
                  child: Text(
                    replaceSpecialCharacters(widget.model.title.toString()),
                    style:
                        semiboldTS.copyWith(color: Colors.white, fontSize: 20),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  child: Row(
                    children: [
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
                      Text(
                        'by ${capitalizeFirstLetter(widget.model.sourceId.toString())}',
                        style: mediumTS.copyWith(
                            fontSize: 10, color: Colors.white),
                      ),
                      const Spacer(),
                      // Text(
                      //   '5 mins read',
                      //   style: mediumTS.copyWith(
                      //       fontSize: 10, color: Colors.white),
                      // ),
                      // Container(
                      //   margin: const EdgeInsets.symmetric(horizontal: 6),
                      //   height: 5,
                      //   width: 5,
                      //   decoration: const BoxDecoration(
                      //       shape: BoxShape.circle, color: greyWhiteColor),
                      // ),
                      Text(
                        DateFormat('d MMMM y').format(
                          DateTime.parse(widget.model.pubDate.toString()),
                        ),
                        style: mediumTS.copyWith(
                            fontSize: 10, color: Colors.white),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
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
