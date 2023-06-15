import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maos/theme.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 72,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            height: 48,
            width: 48,
            margin: const EdgeInsets.only(left: 8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: greyBlur20),
            ),
            child: Center(
              child: Image.asset(
                'assets/icons/news_back.png',
                width: 24,
              ),
            ),
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 18),
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: greyBlur20),
              image: const DecorationImage(
                image: AssetImage('assets/icons/news_action.png'),
                scale: 2,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Religion',
                      style: semi.copyWith(fontSize: 12),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      height: 5,
                      width: 5,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: greyWhiteColor),
                    ),
                    Text(
                      'Top 5 Hot Topic 🔥',
                      style: semi.copyWith(fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  'Malang City Residents Ready to Welcome Eid in 2023',
                  style: semi.copyWith(fontSize: 24),
                  maxLines: 3,
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Container(
                      height: 22,
                      width: 22,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/logo_cnn.png'),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      'CNN Indonesia',
                      style: semi.copyWith(fontSize: 13),
                    ),
                    const Spacer(),
                    Text(
                      '7 mins read',
                      style: medium.copyWith(fontSize: 12),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      height: 5,
                      width: 5,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: greyWhiteColor),
                    ),
                    Text(
                      '7 mins read',
                      style: medium.copyWith(fontSize: 12),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
