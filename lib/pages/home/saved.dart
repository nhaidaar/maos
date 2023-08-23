import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../models/news_model.dart';
import '../../shared/theme.dart';
import 'widgets/saved_card.dart';
import '../news/news.dart';
import 'home.dart';

class Saved extends StatelessWidget {
  const Saved({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    // If user logged in, show the page
    if (user != null) {
      return SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Container(
              margin: const EdgeInsets.all(16),
              child: Text(
                'Saved',
                style: semiboldTS.copyWith(
                  fontSize: 24,
                ),
                textAlign: TextAlign.left,
              ),
            ),

            // List of Saved news
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(user.uid)
                      .collection('news')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<NewsModel> savedNews = [];

                      // Fetch all saved news
                      for (QueryDocumentSnapshot document
                          in snapshot.data!.docs) {
                        Map<String, dynamic> data =
                            document.data() as Map<String, dynamic>;
                        NewsModel news = NewsModel.fromMap(data);
                        savedNews.add(news);
                      }

                      if (savedNews.isEmpty) {
                        return const Center(
                          child: Text(
                            'No saved news. Save news to see them here!',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        );
                      } else {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 200,
                                    crossAxisSpacing: 16,
                                    mainAxisSpacing: 16),
                            itemCount: savedNews.length,
                            itemBuilder: (BuildContext context, index) {
                              return SavedCard(
                                title: savedNews[index].title.toString(),
                                imgUrl: savedNews[index].imageUrl.toString(),
                                category: savedNews[index].category.toString(),
                                publisher: savedNews[index].sourceId.toString(),
                                date: savedNews[index].pubDate.toString(),
                                action: () {
                                  Navigator.of(context).push(
                                    PageTransition(
                                      child: NewsPage(
                                        model: savedNews[index],
                                      ),
                                      type: PageTransitionType.rightToLeft,
                                      childCurrent: this,
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        );
                      }
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: blackColor,
                        ),
                      );
                    }
                  }),
            ),
          ],
        ),
      );
    } else {
      return const LoginRequired();
    }
  }
}
