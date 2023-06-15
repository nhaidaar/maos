import 'package:flutter/material.dart';
import 'package:maos/theme.dart';

class SavedCard extends StatelessWidget {
  final String title, imgUrl, category, publisher, date;
  final VoidCallback? action;
  const SavedCard({
    super.key,
    required this.title,
    required this.imgUrl,
    required this.category,
    required this.publisher,
    required this.date,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(right: 16),
            height: 180,
            width: 180,
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
            padding: const EdgeInsets.all(10),
            height: 180,
            width: 180,
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
            padding: const EdgeInsets.all(10),
            // margin: const EdgeInsets.all(12),
            height: 180,
            width: 180,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: FittedBox(
                    child: Text(
                      category,
                      style: semi.copyWith(fontSize: 9),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 72),
                  child: Text(
                    title,
                    style: semi.copyWith(color: Colors.white, fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  child: Row(
                    children: [
                      Text(
                        'by $publisher',
                        style:
                            medium.copyWith(fontSize: 8, color: Colors.white),
                      ),
                      const Spacer(),
                      Text(
                        date,
                        style:
                            medium.copyWith(fontSize: 8, color: Colors.white),
                      )
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
