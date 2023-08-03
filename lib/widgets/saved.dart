import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maos/shared/methods.dart';
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
              border: Border.all(color: greyBlur20),
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: imgUrl != 'null'
                    ? NetworkImage(
                        imgUrl,
                      ) as ImageProvider
                    : const AssetImage('assets/images/news.jpg'),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: const LinearGradient(
                begin: Alignment.center,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: greyBlur20),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: FittedBox(
                    child: Text(
                      capitalizeFirstLetter(category),
                      style: semiboldTS.copyWith(fontSize: 9),
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  title,
                  style: semiboldTS.copyWith(color: Colors.white, fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      'by ${capitalizeFirstLetter(publisher)}',
                      style:
                          mediumTS.copyWith(fontSize: 8, color: Colors.white),
                    ),
                    const Spacer(),
                    Text(
                      DateFormat('d MMMM y').format(DateTime.parse(date)),
                      style:
                          mediumTS.copyWith(fontSize: 8, color: Colors.white),
                    )
                  ],
                ),
              ],
            ),
          ),
          // Expanded(
          //   child: Container(
          //     padding: const EdgeInsets.all(10),
          //     height: 200,
          //     width: 200,
          //     child: Column(
          //       children: [
          //         Align(
          //           alignment: Alignment.topLeft,
          //           child: Container(
          //             padding: const EdgeInsets.symmetric(
          //                 vertical: 6, horizontal: 12),
          //             decoration: BoxDecoration(
          //               border: Border.all(color: greyBlur20),
          //               color: Colors.white,
          //               borderRadius: BorderRadius.circular(100),
          //             ),
          //             child: FittedBox(
          //               child: Text(
          //                 capitalizeFirstLetter(category),
          //                 style: semiboldTS.copyWith(fontSize: 9),
          //               ),
          //             ),
          //           ),
          //         ),
          //         Align(
          //           alignment: Alignment.bottomCenter,
          //           child: Column(
          //             children: [
          //               Text(
          //                 title,
          //                 style: semiboldTS.copyWith(
          //                     color: Colors.white, fontSize: 14),
          //                 overflow: TextOverflow.ellipsis,
          //                 maxLines: 2,
          //               ),
          //               Row(
          //                 children: [
          //                   Text(
          //                     'by ${capitalizeFirstLetter(publisher)}',
          //                     style: mediumTS.copyWith(
          //                         fontSize: 8, color: Colors.white),
          //                   ),
          //                   const Spacer(),
          //                   Text(
          //                     DateFormat('d MMMM y')
          //                         .format(DateTime.parse(date)),
          //                     style: mediumTS.copyWith(
          //                         fontSize: 8, color: Colors.white),
          //                   )
          //                 ],
          //               ),
          //             ],
          //           ),
          //         ),
          //         // Container(
          //         //   margin: const EdgeInsets.only(top: 10),
          //         //   child: Row(
          //         //     children: [
          //         //       Text(
          //         //         'by ${capitalizeFirstLetter(publisher)}',
          //         //         style: mediumTS.copyWith(
          //         //             fontSize: 8, color: Colors.white),
          //         //       ),
          //         //       const Spacer(),
          //         //       Text(
          //         //         DateFormat('d MMMM y').format(DateTime.parse(date)),
          //         //         style: mediumTS.copyWith(
          //         //             fontSize: 8, color: Colors.white),
          //         //       )
          //         //     ],
          //         //   ),
          //         // )
          //       ],
          //     ),
          //     // child: Column(
          //     //   crossAxisAlignment: CrossAxisAlignment.start,
          //     //   children: [
          //     //     Container(
          //     //       padding:
          //     //           const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          //     //       decoration: BoxDecoration(
          //     //         border: Border.all(color: greyBlur20),
          //     //         color: Colors.white,
          //     //         borderRadius: BorderRadius.circular(100),
          //     //       ),
          //     //       child: FittedBox(
          //     //         child: Text(
          //     //           capitalizeFirstLetter(category),
          //     //           style: semiboldTS.copyWith(fontSize: 9),
          //     //         ),
          //     //       ),
          //     //     ),
          //     //     Container(
          //     //       margin: const EdgeInsets.only(top: 78),
          //     //       child: Text(
          //     //         title,
          //     //         style:
          //     //             semiboldTS.copyWith(color: Colors.white, fontSize: 14),
          //     //         overflow: TextOverflow.ellipsis,
          //     //         maxLines: 2,
          //     //       ),
          //     //     ),
          //     //     Container(
          //     //       margin: const EdgeInsets.only(top: 10),
          //     //       child: Row(
          //     //         children: [
          //     //           Text(
          //     //             'by ${capitalizeFirstLetter(publisher)}',
          //     //             style:
          //     //                 mediumTS.copyWith(fontSize: 8, color: Colors.white),
          //     //           ),
          //     //           const Spacer(),
          //     //           Text(
          //     //             DateFormat('d MMMM y').format(DateTime.parse(date)),
          //     //             style:
          //     //                 mediumTS.copyWith(fontSize: 8, color: Colors.white),
          //     //           )
          //     //         ],
          //     //       ),
          //     //     )
          //     //   ],
          //     // ),
          //   ),
          // )
        ],
      ),
    );
  }
}
