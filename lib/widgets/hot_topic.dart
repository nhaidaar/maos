import 'package:flutter/material.dart';
import 'package:maos/theme.dart';

class HotTopic extends StatelessWidget {
  final String title,
      category,
      publisher,
      minRead,
      date,
      imgUrl,
      publisherLogoUrl;
  final VoidCallback? action;
  const HotTopic({
    super.key,
    required this.imgUrl,
    this.action,
    required this.title,
    required this.publisher,
    this.minRead = '5',
    required this.date,
    required this.category,
    required this.publisherLogoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(right: 16),
            width: 320,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                fit: BoxFit.fitHeight,
                image: AssetImage(
                  imgUrl,
                ),
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
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: FittedBox(
                    child: Text(
                      category,
                      style: semi.copyWith(fontSize: 11),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 172),
                  child: Text(
                    title,
                    style: semi.copyWith(color: Colors.white),
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
                            image: AssetImage(publisherLogoUrl),
                          ),
                        ),
                      ),
                      Text(
                        'by $publisher',
                        style:
                            medium.copyWith(fontSize: 10, color: Colors.white),
                      ),
                      const Spacer(),
                      minRead == '1'
                          ? Text(
                              '1 min read',
                              style: medium.copyWith(
                                  fontSize: 10, color: Colors.white),
                            )
                          : Text(
                              '$minRead mins read',
                              style: medium.copyWith(
                                  fontSize: 10, color: Colors.white),
                            ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        height: 5,
                        width: 5,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: greyWhiteColor),
                      ),
                      Text(
                        date,
                        style:
                            medium.copyWith(fontSize: 10, color: Colors.white),
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
