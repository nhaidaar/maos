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
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                fit: BoxFit.fitHeight,
                image: imgUrl != 'null'
                    ? NetworkImage(
                        imgUrl,
                      ) as ImageProvider
                    : const AssetImage('assets/images/news1.jpg'),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              gradient: const LinearGradient(
                begin: Alignment.center,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            height: 200,
            width: 200,
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
                      style: semiboldTS.copyWith(fontSize: 9),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 75),
                  child: Text(
                    title,
                    style:
                        semiboldTS.copyWith(color: Colors.white, fontSize: 14),
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
                            mediumTS.copyWith(fontSize: 8, color: Colors.white),
                      ),
                      const Spacer(),
                      Text(
                        date,
                        style:
                            mediumTS.copyWith(fontSize: 8, color: Colors.white),
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
