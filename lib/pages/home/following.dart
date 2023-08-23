import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../../blocs/news/news_bloc.dart';
import '../../shared/methods.dart';
import '../../shared/theme.dart';
import 'widgets/following_publisher_card.dart';
import '../../widgets/toppicks_card.dart';
import '../news/news.dart';
import 'home.dart';
import 'widgets/show_bypublisher.dart';

class Following extends StatefulWidget {
  const Following({super.key});

  @override
  State<Following> createState() => _FollowingState();
}

class _FollowingState extends State<Following> {
  String? publisher;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    // If user logged in, show the page
    if (user != null) {
      return SafeArea(
        child: ListView(
          children: [
            // Title
            Container(
              margin: const EdgeInsets.all(16),
              child: Text(
                'Following',
                style: semiboldTS.copyWith(fontSize: 24),
              ),
            ),

            // List of Publisher
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Row(
                children: [
                  Text(
                    'Publisher',
                    style: semiboldTS.copyWith(fontSize: 18),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              height: 110,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(user.uid)
                    .collection('publishers')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    // Fetch all followed publishers
                    final publishers = snapshot.data!.docs;

                    if (publishers.isEmpty) {
                      return const Center(
                        child:
                            Text('You are not following any publishers yet!'),
                      );
                    } else {
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: publishers.length + 1,
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return const SizedBox(width: 16);
                            } else {
                              final publisherData = publishers[index - 1].data()
                                  as Map<String, dynamic>;
                              return Publisher(
                                name: capitalizeFirstLetter(
                                    publisherData['name']),
                                imgUrl:
                                    'assets/images/logo_${publisherData['name']}.png',
                                isSelected: publisher == publisherData['name'],
                                action: () {
                                  setState(() {
                                    publisher = publisherData['name'];
                                  });
                                },
                              );
                            }
                          });
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: blackColor,
                      ),
                    );
                  }
                },
              ),
            ),

            const SizedBox(
              height: 8,
            ),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  publisher == null
                      ? Text(
                          'Recent Articles',
                          style: semiboldTS.copyWith(fontSize: 18),
                        )
                      : Text(
                          '${capitalizeFirstLetter(publisher!)}\'s News',
                          style: semiboldTS.copyWith(fontSize: 18),
                        ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),

            // If publisher is selected, show news by publisher
            // If no publisher selected, show recent articles
            publisher != null
                ? ShowPublisherNews(
                    key: ObjectKey(publisher),
                    publisher: publisher!,
                  )
                : BlocProvider(
                    create: (context) => NewsBloc()..add(const NewsGet('top')),
                    child: BlocBuilder<NewsBloc, NewsState>(
                      builder: (context, state) {
                        if (state is NewsSuccess) {
                          return Column(
                              children: state.data.map((news) {
                            return TopPicksCard(
                              model: news,
                              action: () {
                                Navigator.of(context).push(
                                  PageTransition(
                                    child: NewsPage(model: news),
                                    type: PageTransitionType.rightToLeft,
                                    childCurrent: widget,
                                  ),
                                );
                              },
                            );
                          }).toList());
                        }
                        return const TopPicksLoading();
                      },
                    ),
                  ),
          ],
        ),
      );
    } else {
      return const LoginRequired();
    }
  }
}
