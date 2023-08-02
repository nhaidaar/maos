import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:maos/blocs/auth/auth_bloc.dart';
import 'package:maos/blocs/news/news_bloc.dart';
import 'package:maos/models/news_model.dart';
import 'package:maos/pages/news.dart';
import 'package:maos/pages/search.dart';
import 'package:maos/shared/methods.dart';
import 'package:maos/theme.dart';
import 'package:maos/widgets/category.dart';
import 'package:maos/widgets/hot_topic.dart';
import 'package:maos/widgets/profilemenu.dart';
import 'package:maos/widgets/publisher.dart';
import 'package:maos/widgets/saved.dart';
// import 'package:maos/widgets/saved.dart';
import 'package:maos/widgets/top_picks.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final GlobalKey<_HomeState> _homeKey = GlobalKey<_HomeState>();

  final List<Widget> _pages = [
    const Home(),
    const Following(),
    const Saved(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is UnAuthenticated) {
          // Navigate to the sign in screen when the user Signs Out
          Navigator.pushNamed(context, '/checker');
        }
      },
      child: Scaffold(
        body: _pages[_currentIndex],
        key: _homeKey,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
          selectedItemColor: Colors.black,
          selectedLabelStyle:
              semiboldTS.copyWith(fontSize: 11, color: Colors.black),
          // unselectedLabelStyle:
          //     mediumTS.copyWith(fontSize: 11, color: Colors.black),
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/home_outlined.png',
                scale: 2,
              ),
              activeIcon: Image.asset(
                'assets/icons/home_filled.png',
                scale: 2,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/following_outlined.png',
                scale: 2,
              ),
              activeIcon: Image.asset(
                'assets/icons/following_filled.png',
                scale: 2,
              ),
              label: 'Following',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/saved_outlined.png',
                scale: 2,
              ),
              activeIcon: Image.asset(
                'assets/icons/saved_filled.png',
                scale: 2,
              ),
              label: 'Saved',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/profile_circle_outlined.png',
                scale: 2,
              ),
              activeIcon: Image.asset(
                'assets/icons/profile_circle_filled.png',
                scale: 2,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
          const SizedBox(
            height: 16,
          ),

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
                Padding(
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
                            )

                          // Check is user login or not
                          : user?.email != null
                              ? Text(
                                  '${user?.email} 👋🏻',
                                  style: semiboldTS.copyWith(fontSize: 18),
                                )
                              : Text(
                                  'Guest User 👋🏻',
                                  style: semiboldTS.copyWith(fontSize: 18),
                                )
                    ],
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/notif');
                  },
                  child: Container(
                    margin: const EdgeInsets.all(4),
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      border: Border.all(color: greyBlur20),
                      shape: BoxShape.circle,
                      image: const DecorationImage(
                        scale: 2.2,
                        image: AssetImage(
                          'assets/icons/notification.png',
                        ),
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        width: 18,
                        height: 18,
                        decoration: const BoxDecoration(
                            color: Colors.black, shape: BoxShape.circle),
                        child: Center(
                          child: Text(
                            '2',
                            style: semiboldTS.copyWith(
                              color: Colors.white,
                              fontSize: 8,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Searchbar
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchPage(),
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
                        borderSide: BorderSide(color: greyBlur20)),
                  ),
                ),
              ),
            ),
          ),

          // Hot Topics
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Text(
                      'Hot topics 🔥',
                      style: semiboldTS.copyWith(fontSize: 18),
                    ),
                    // const Spacer(),
                    // Text(
                    //   'View All',
                    //   style: semiboldTS,
                    // )
                  ],
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
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NewsPage(
                                        model: news,
                                        predicate: 'Top 10 Hot Topics 🔥',
                                      ),
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
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'Top picks for you',
              style: semiboldTS.copyWith(fontSize: 18),
            ),
          ),

          // Category
          Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            height: 35,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                const SizedBox(
                  width: 16,
                ),
                Category(
                  title: 'All',
                  isSelected: selectedCategory == newsCategory[0],
                  action: () {
                    setState(() {
                      selectedCategory = newsCategory[0];
                    });
                  },
                ),
                Category(
                  title: newsCategory[1],
                  isSelected: selectedCategory == newsCategory[1],
                  action: () {
                    setState(() {
                      selectedCategory = newsCategory[1];
                    });
                  },
                ),
                Category(
                  title: newsCategory[2],
                  isSelected: selectedCategory == newsCategory[2],
                  action: () {
                    setState(() {
                      selectedCategory = newsCategory[2];
                    });
                  },
                ),
                Category(
                  title: newsCategory[3],
                  isSelected: selectedCategory == newsCategory[3],
                  action: () {
                    setState(() {
                      selectedCategory = newsCategory[3];
                    });
                  },
                ),
                Category(
                  title: newsCategory[4],
                  isSelected: selectedCategory == newsCategory[4],
                  action: () {
                    setState(() {
                      selectedCategory = newsCategory[4];
                    });
                  },
                ),
                Category(
                  title: newsCategory[5],
                  isSelected: selectedCategory == newsCategory[5],
                  action: () {
                    setState(() {
                      selectedCategory = newsCategory[5];
                    });
                  },
                ),
                Category(
                  title: newsCategory[6],
                  isSelected: selectedCategory == newsCategory[6],
                  action: () {
                    setState(() {
                      selectedCategory = newsCategory[6];
                    });
                  },
                ),
                Category(
                  title: newsCategory[7],
                  isSelected: selectedCategory == newsCategory[7],
                  action: () {
                    setState(() {
                      selectedCategory = newsCategory[7];
                    });
                  },
                ),
                Category(
                  title: newsCategory[8],
                  isSelected: selectedCategory == newsCategory[8],
                  action: () {
                    setState(() {
                      selectedCategory = newsCategory[8];
                    });
                  },
                ),
              ],
            ),
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

    return SafeArea(
      child: user != null
          ? ListView(
              children: [
                Container(
                  margin: const EdgeInsets.all(16),
                  child: Text(
                    'Following',
                    style: semiboldTS.copyWith(fontSize: 24),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      child: Row(
                        children: [
                          Text(
                            'Publisher',
                            style: semiboldTS.copyWith(fontSize: 18),
                          ),
                          // const Spacer(),
                          // GestureDetector(
                          //   onTap: () {
                          //     showCustomSnackbar(context, null);
                          //   },
                          //   child: Text(
                          //     'View All',
                          //     style: semiboldTS,
                          //   ),
                          // )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      height: 96,
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .doc(user.uid)
                            .collection('publishers')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final publishers = snapshot.data!.docs;
                            if (publishers.isEmpty) {
                              return const Center(
                                child: Text(
                                    'You are not following any publishers yet!'),
                              );
                            } else {
                              return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: publishers.length + 1,
                                  itemBuilder: (context, index) {
                                    if (index == 0) {
                                      return const SizedBox(width: 16);
                                    } else {
                                      final publisherData =
                                          publishers[index - 1].data()
                                              as Map<String, dynamic>;
                                      return Publisher(
                                        name: capitalizeFirstLetter(
                                            publisherData['name']),
                                        imgUrl:
                                            'assets/images/logo_${publisherData['name']}.png',
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
                    publisher != null
                        ? ShowPublisherNews(
                            key: ObjectKey(publisher), publisher: publisher!)
                        : BlocProvider(
                            create: (context) =>
                                NewsBloc()..add(const NewsGet('top')),
                            child: BlocBuilder<NewsBloc, NewsState>(
                              builder: (context, state) {
                                if (state is NewsSuccess) {
                                  return Column(
                                      children: state.data.map((news) {
                                    return TopPicksCard(
                                      model: news,
                                      action: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                NewsPage(model: news),
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
              ],
            )
          : const LoginRequired(),
    );
  }
}

class Saved extends StatelessWidget {
  const Saved({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return SafeArea(
      child: user != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                          for (QueryDocumentSnapshot document
                              in snapshot.data!.docs) {
                            Map<String, dynamic> data =
                                document.data() as Map<String, dynamic>;
                            NewsModel news = NewsModel.fromMap(
                                data); // Assuming you have a fromMap method in NewsModel
                            savedNews.add(news);
                          }
                          if (savedNews.isEmpty) {
                            return const Center(
                              child: Text(
                                'No saved news. Save news to see them here!',
                                textAlign: TextAlign.center,
                                style:
                                    TextStyle(fontSize: 16, color: Colors.grey),
                              ),
                            );
                          } else {
                            // return ListView.builder(
                            //   scrollDirection: Axis.vertical,
                            //   itemCount: savedNews.length,
                            //   itemBuilder: (context, index) {
                            //     NewsModel news = savedNews[index];
                            //     return TopPicksCard(
                            //       model: news,
                            //       action: () {
                            //         Navigator.push(
                            //           context,
                            //           MaterialPageRoute(
                            //             builder: (context) =>
                            //                 NewsPage(model: news),
                            //           ),
                            //         );
                            //       },
                            //     );
                            //   },
                            // );
                            return Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 16),
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
                                    imgUrl:
                                        savedNews[index].imageUrl.toString(),
                                    category:
                                        savedNews[index].category.toString(),
                                    publisher:
                                        savedNews[index].sourceId.toString(),
                                    date: savedNews[index].pubDate.toString(),
                                    action: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              NewsPage(model: savedNews[index]),
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
            )
          : const LoginRequired(),
    );
  }
}

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return SafeArea(
      child: user != null
          ? ListView(
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      border: Border.all(color: greyBlur20),
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            border: Border.all(color: greyBlur20),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: user.photoURL != null
                                  ? NetworkImage(user.photoURL.toString())
                                      as ImageProvider
                                  : const AssetImage(
                                      'assets/images/profile.jpg'),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            '${user.email}',
                            style: semiboldTS.copyWith(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Text(
                          'Joined ${user.metadata.creationTime != null ? DateFormat('MMMM y').format(user.metadata.creationTime!) : 'unknown'}',
                          style: mediumTS.copyWith(
                            color: greyColor,
                          ),
                        ),
                        const SizedBox(
                          height: 22,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 24),
                          child: Column(
                            children: [
                              ProfileMenu(
                                title: 'Edit Profile',
                                iconUrl: 'assets/icons/user_edit.png',
                                action: () {
                                  Navigator.pushNamed(context, '/uploadpp');
                                },
                              ),
                              ProfileMenu(
                                title: 'My Rewards',
                                iconUrl: 'assets/icons/user_rewards.png',
                                badge: 2,
                                action: () {},
                              ),
                              ProfileMenu(
                                title: 'Help Center',
                                iconUrl: 'assets/icons/user_help.png',
                                action: () {},
                              ),
                              ProfileMenu(
                                title: 'Log Out',
                                iconUrl: 'assets/icons/user_logout.png',
                                action: () {
                                  context.read<AuthBloc>().add(AuthSignOut());
                                },
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'Last Login : ${user.metadata.lastSignInTime}',
                          style: mediumTS.copyWith(
                            color: greyBlur60,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
          : const LoginRequired(),
    );
  }
}

class ShowTopPicks extends StatelessWidget {
  final String category;
  const ShowTopPicks({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsBloc()..add(NewsGet(category)),
      child: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is NewsSuccess) {
            return Column(
              children: state.data.map((news) {
                return TopPicksCard(
                  model: news,
                  action: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewsPage(model: news),
                      ),
                    );
                  },
                );
              }).toList(),
            );
          }
          return const TopPicksLoading();
        },
      ),
    );
  }
}

class ShowPublisherNews extends StatelessWidget {
  final String publisher;
  const ShowPublisherNews({super.key, required this.publisher});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsBloc()..add(NewsPublisher(publisher)),
      child: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is NewsSuccess) {
            return Column(
              children: state.data.map((news) {
                return TopPicksCard(
                  model: news,
                  action: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewsPage(model: news),
                      ),
                    );
                  },
                );
              }).toList(),
            );
          }
          return const TopPicksLoading();
        },
      ),
    );
  }
}

class LoginRequired extends StatelessWidget {
  const LoginRequired({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/onboarding1.png',
            width: 260,
          ),
          Text(
            'Be Part of Us and Unlock\nAll The Features!',
            style: semiboldTS.copyWith(
              fontSize: 24,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            'Please login to your account to continue\naccessing this feature.',
            style: mediumTS.copyWith(color: greyBlur60, height: 1.8),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 24,
          ),
          GestureDetector(
            onTap: () {
              BlocProvider.of<AuthBloc>(context).add(AuthSignOut());
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 41),
              padding: const EdgeInsets.symmetric(vertical: 18),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: Text(
                  'Login',
                  style: semiboldTS.copyWith(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
