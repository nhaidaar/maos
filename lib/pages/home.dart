import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maos/blocs/news/news_bloc.dart';
import 'package:maos/pages/news.dart';
import 'package:maos/pages/search.dart';
import 'package:maos/shared/methods.dart';
import 'package:maos/theme.dart';
import 'package:maos/widgets/category.dart';
import 'package:maos/widgets/hot_topic.dart';
import 'package:maos/widgets/profilemenu.dart';
import 'package:maos/widgets/publisher.dart';
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
    return Scaffold(
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
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
                    image: const DecorationImage(
                      image: AssetImage('assets/images/profile.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
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
                      Text(
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
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'Top picks for you',
              style: semiboldTS.copyWith(fontSize: 18),
            ),
          ),
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

class Following extends StatelessWidget {
  const Following({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            child: Text(
              'Following',
              style: semiboldTS.copyWith(fontSize: 24),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              children: [
                Text(
                  'Publisher',
                  style: semiboldTS.copyWith(fontSize: 18),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    showCustomSnackbar(context, null);
                  },
                  child: Text(
                    'View All',
                    style: semiboldTS,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            height: 96,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                const SizedBox(
                  width: 16,
                ),
                Publisher(
                  name: 'Publisher Name',
                  imgUrl: 'assets/images/profile.jpg',
                  action: () {
                    showCustomSnackbar(context, null);
                  },
                ),
                Publisher(
                  name: 'Publisher Name',
                  imgUrl: 'assets/images/profile.jpg',
                  action: () {
                    showCustomSnackbar(context, null);
                  },
                ),
                Publisher(
                  name: 'Publisher Name',
                  imgUrl: 'assets/images/profile.jpg',
                  action: () {
                    showCustomSnackbar(context, null);
                  },
                ),
                Publisher(
                  name: 'Publisher Name',
                  imgUrl: 'assets/images/profile.jpg',
                  action: () {
                    showCustomSnackbar(context, null);
                  },
                ),
                Publisher(
                  name: 'Publisher Name',
                  imgUrl: 'assets/images/profile.jpg',
                  action: () {
                    showCustomSnackbar(context, null);
                  },
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'Recent Articles',
              style: semiboldTS.copyWith(fontSize: 18),
            ),
          ),
          BlocProvider(
            create: (context) => NewsBloc()..add(const NewsGet('top')),
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
                  }).toList());
                }
                return const TopPicksLoading();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Saved extends StatelessWidget {
  const Saved({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
          Column(
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
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: const Center(
                  child: Text('This feature is coming soon!'),
                ),
                // child: Wrap(
                //   spacing: 16,
                //   runSpacing: 16,
                //   children: [
                //     SavedCard(
                //       title: 'Kebakaran di Jakarta Timur Hanguskan 16 Kambing',
                //       imgUrl: 'assets/images/news1.jpg',
                //       category: 'Regional',
                //       publisher: 'Tempo',
                //       date: '17 Juni 2023',
                //       action: () {
                //         showCustomSnackbar(context, null);
                //       },
                //     ),
                //     SavedCard(
                //       title:
                //           'Manfaat Habatusauda bagi Kesehatan dan Cara Terbaik Mengonsumsinya',
                //       imgUrl: 'assets/images/news1.jpg',
                //       category: 'Lifestyle',
                //       publisher: 'Kompas',
                //       date: '17 Juni 2023',
                //       action: () {
                //         showCustomSnackbar(context, null);
                //       },
                //     ),
                //     SavedCard(
                //       title: 'Media Argentina Puji Sambutan Spesial Indonesia',
                //       imgUrl: 'assets/images/news1.jpg',
                //       category: 'Sport',
                //       publisher: 'CNN Indonesia',
                //       date: '17 Juni 2023',
                //       action: () {
                //         showCustomSnackbar(context, null);
                //       },
                //     ),
                //     SavedCard(
                //       title:
                //           'Pertamina Ajak Generasi Muda Jadi Agen Perubahan Lingkungan',
                //       imgUrl: 'assets/images/news1.jpg',
                //       category: 'Economy',
                //       publisher: 'CNN Indonesia',
                //       date: '17 Juni 2023',
                //       action: () {
                //         showCustomSnackbar(context, null);
                //       },
                //     ),
                //     SavedCard(
                //       title:
                //           'Elektabilitas Anies Salip Ganjar dan Pepet Prabowo di Survei Terbaru IPO',
                //       imgUrl: 'assets/images/news1.jpg',
                //       category: 'Politics',
                //       publisher: 'Tempo',
                //       date: '17 Juni 2023',
                //       action: () {
                //         showCustomSnackbar(context, null);
                //       },
                //     ),
                //   ],
                // ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
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
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          'assets/images/profile.jpg',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Guest User',
                      style: semiboldTS.copyWith(fontSize: 20),
                    ),
                  ),
                  Text(
                    'Joined July 2022',
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
                            showCustomSnackbar(context, null);
                          },
                        ),
                        ProfileMenu(
                          title: 'My Rewards',
                          iconUrl: 'assets/icons/user_rewards.png',
                          badge: 2,
                          action: () {
                            showCustomSnackbar(context, null);
                          },
                        ),
                        ProfileMenu(
                          title: 'Help Center',
                          iconUrl: 'assets/icons/user_help.png',
                          action: () {
                            showCustomSnackbar(context, null);
                          },
                        ),
                        ProfileMenu(
                          title: 'Log Out',
                          iconUrl: 'assets/icons/user_logout.png',
                          action: () {
                            showCustomSnackbar(context, null);
                          },
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Last Login : Just Now',
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
      ),
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
