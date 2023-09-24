import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maos/pages/home/search.dart';
import 'package:page_transition/page_transition.dart';

import '../../blocs/news/news_bloc.dart';
import '../../shared/values.dart';
import '../../shared/theme.dart';
import 'widgets/timeline_category_button.dart';
import 'widgets/timeline_hottopic_card.dart';
import '../news/news.dart';
import 'widgets/show_toppicks.dart';

class Timeline extends StatefulWidget {
  const Timeline({super.key});

  @override
  State<Timeline> createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  final user = FirebaseAuth.instance.currentUser;
  String selectedCategory = 'top';
  String _getGreeting() {
    var now = DateTime.now();
    var hour = now.hour;

    if (hour >= 5 && hour < 12) {
      return 'Good Morning,';
    } else if (hour >= 12 && hour < 17) {
      return 'Good Afternoon,';
    } else if (hour >= 17 && hour < 20) {
      return 'Good Evening,';
    } else {
      return 'Good Night,';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          // Top Appbar
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    border: Border.all(color: greyBlur20),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: user?.photoURL != null
                          ? NetworkImage(user!.photoURL.toString())
                              as ImageProvider
                          : const AssetImage('assets/images/profile.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 4,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _getGreeting(),
                          style: mediumTS.copyWith(color: greyBlur60),
                        ),
                        const SizedBox(
                          height: 4,
                        ),

                        // Check is user set display name or not
                        user?.displayName != null
                            ? Text(
                                '${user?.displayName} 👋🏻',
                                style: semiboldTS.copyWith(fontSize: 18),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              )

                            // Check is user login or not
                            : user?.email != null
                                ? Text(
                                    '${user?.email} 👋🏻',
                                    style: semiboldTS.copyWith(fontSize: 18),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  )
                                : Text(
                                    'Guest User 👋🏻',
                                    style: semiboldTS.copyWith(fontSize: 18),
                                  ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Searchbar
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                PageTransition(
                  child: const SearchPage(),
                  type: PageTransitionType.bottomToTop,
                  childCurrent: widget,
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: AbsorbPointer(
                child: TextFormField(
                  enabled: false,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Image.asset(
                        'assets/icons/search.png',
                        scale: 2,
                      ),
                    ),
                    hintText: 'Indonesian politics today',
                    hintStyle:
                        mediumTS.copyWith(color: greyBlur40, fontSize: 14),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(28),
                      borderSide: BorderSide(color: greyBlur20),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Hot Topics
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Hot topics 🔥',
                  style: semiboldTS.copyWith(fontSize: 18),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 16),
                height: 320,
                child: BlocProvider(
                  create: (context) => NewsBloc()..add(NewsHot()),
                  child: BlocBuilder<NewsBloc, NewsState>(
                    builder: (context, state) {
                      if (state is NewsSuccess) {
                        return ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            const SizedBox(
                              width: 16,
                            ),
                            ...state.data.map((news) {
                              return HotTopicCard(
                                model: news,
                                action: () {
                                  Navigator.of(context).push(
                                    PageTransition(
                                      child: NewsPage(
                                        model: news,
                                        predicate: 'Top 10 Hot Topics 🔥',
                                      ),
                                      type: PageTransitionType.rightToLeft,
                                      childCurrent: widget,
                                    ),
                                  );
                                },
                              );
                            }).toList()
                          ],
                        );
                      }
                      return const HotTopicLoading();
                    },
                  ),
                ),
              )
            ],
          ),

          // Top Picks
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 4, bottom: 12),
            child: Text(
              'Top picks for you',
              style: semiboldTS.copyWith(fontSize: 18),
            ),
          ),
          // Category
          SizedBox(
            height: 35,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: newsCategory.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.only(
                    // Add some width in left of first widget
                    left: index == 0 ? 16 : 0,
                  ),
                  child: Category(
                    // First category is named 'All'
                    title: index == 0 ? 'All' : newsCategory[index],
                    isSelected: selectedCategory == newsCategory[index],
                    action: () {
                      setState(() {
                        selectedCategory = newsCategory[index];
                      });
                    },
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          ShowTopPicks(
            key: ObjectKey(selectedCategory),
            category: selectedCategory,
          )
        ],
      ),
    );
  }
}
