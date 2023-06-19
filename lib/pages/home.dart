import 'package:flutter/material.dart';
import 'package:maos/theme.dart';
import 'package:maos/widgets/category.dart';
import 'package:maos/widgets/hot_topic.dart';
import 'package:maos/widgets/profilemenu.dart';
import 'package:maos/widgets/publisher.dart';
import 'package:maos/widgets/saved.dart';
import 'package:maos/widgets/top_picks.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.black,
        selectedLabelStyle: semi.copyWith(fontSize: 11, color: Colors.black),
        // unselectedLabelStyle:
        //     medium.copyWith(fontSize: 11, color: Colors.black),
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

class Home extends StatelessWidget {
  const Home({super.key});

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
                    border: Border.all(color: greyBlur40),
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
                        'Good Morning,',
                        style: medium.copyWith(color: greyBlur60),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        'Emir Abiyyu 👋🏻',
                        style: semi.copyWith(fontSize: 18),
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
                            style: semi.copyWith(
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
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: TextFormField(
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Image.asset(
                    'assets/icons/search.png',
                    scale: 2,
                  ),
                ),
                hintText: 'Indonesian politics today',
                hintStyle: medium.copyWith(color: greyBlur40, fontSize: 14),
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(28),
                    borderSide: BorderSide(color: greyBlur20)),
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
                      'Hot topic 🔥',
                      style: semi.copyWith(fontSize: 18),
                    ),
                    const Spacer(),
                    Text(
                      'View All',
                      style: semi.copyWith(fontSize: 12),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 16),
                height: 320,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    const SizedBox(
                      width: 16,
                    ),
                    HotTopic(
                      imgUrl: 'assets/images/news1.jpg',
                      title:
                          'Pertamina Ajak Generasi Muda Jadi Agen Perubahan Lingkungan',
                      publisher: 'CNN Indonesia',
                      publisherLogoUrl: 'assets/images/logo_cnn.png',
                      date: '17 Juni 2023',
                      category: 'Economy',
                      minRead: '4',
                      action: () {
                        Navigator.pushNamed(context, '/news');
                      },
                    ),
                    HotTopic(
                      imgUrl: 'assets/images/news3.jpg',
                      title:
                          'Manfaat Habatusauda bagi Kesehatan dan Cara Terbaik Mengonsumsinya',
                      publisher: 'Kompas',
                      publisherLogoUrl: 'assets/images/logo_kompas.png',
                      date: '17 Juni 2023',
                      category: 'Lifestyle',
                      minRead: '7',
                      action: () {
                        Navigator.pushNamed(context, '/news');
                      },
                    ),
                    HotTopic(
                      imgUrl: 'assets/images/news5.jpg',
                      title: 'Kebakaran di Jakarta Timur Hanguskan 16 Kambing',
                      publisher: 'Tempo',
                      publisherLogoUrl: 'assets/images/logo_tempo.png',
                      date: '17 Juni 2023',
                      category: 'Regional',
                      minRead: '2',
                      action: () {
                        Navigator.pushNamed(context, '/news');
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'Top picks for you',
              style: semi.copyWith(fontSize: 18),
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
                  color: Colors.black,
                  action: () {},
                ),
                Category(
                  title: 'Politics',
                  action: () {},
                ),
                Category(
                  title: 'Lifestyle',
                  action: () {},
                ),
                Category(
                  title: 'Economy',
                  action: () {},
                ),
                Category(
                  title: 'Sport',
                  action: () {},
                ),
                Category(
                  title: 'Regional',
                  action: () {},
                ),
              ],
            ),
          ),
          const TopAll(),
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
              style: semi.copyWith(fontSize: 24),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              children: [
                Text(
                  'Publisher',
                  style: semi.copyWith(fontSize: 18),
                ),
                const Spacer(),
                Text(
                  'View All',
                  style: semi.copyWith(fontSize: 12),
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
                  name: 'CNN Indonesia',
                  imgUrl: 'assets/images/logo_cnn.png',
                  action: () {},
                ),
                Publisher(
                  name: 'Kompas',
                  imgUrl: 'assets/images/logo_kompas.png',
                  action: () {},
                ),
                Publisher(
                  name: 'Tempo.co',
                  imgUrl: 'assets/images/logo_tempo.png',
                  action: () {},
                ),
                Publisher(
                  name: 'Lorem',
                  imgUrl: 'assets/images/profile.jpg',
                  action: () {},
                ),
                Publisher(
                  name: 'Ipsum',
                  imgUrl: 'assets/images/profile.jpg',
                  action: () {},
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'Recent Articles',
              style: semi.copyWith(fontSize: 18),
            ),
          ),
          Column(
            children: [
              TopPicks(
                title: 'Media Argentina Puji Sambutan Spesial Indonesia',
                publisher: 'CNN Indonesia',
                date: '05 Juni 2023',
                imgUrl: 'assets/images/news2.jpg',
                action: () {
                  Navigator.pushNamed(context, '/news');
                },
              ),
              TopPicks(
                title:
                    'Air Sungai Bengawan Solo Tercemar Limbah Industri Minuman Beralkohol, Berbau Dan Berwarna Hitam',
                publisher: 'Kompas',
                date: '08 Juni 2023',
                imgUrl: 'assets/images/news4.jpg',
                action: () {
                  Navigator.pushNamed(context, '/news');
                },
              ),
              TopPicks(
                title:
                    'Elektabilitas Anies Salip Ganjar dan Pepet Prabowo di Survei Terbaru IPO',
                publisher: 'Tempo',
                date: '08 Juni 2023',
                imgUrl: 'assets/images/news6.jpg',
                action: () {
                  Navigator.pushNamed(context, '/news');
                },
              ),
              TopPicks(
                title:
                    'Pertamina Ajak Generasi Muda Jadi Agen Perubahan Lingkungan',
                publisher: 'CNN Indonesia',
                date: '05 Juni 2023',
                imgUrl: 'assets/images/news1.jpg',
                action: () {
                  Navigator.pushNamed(context, '/news');
                },
              ),
              TopPicks(
                title:
                    'Manfaat Habatusauda bagi Kesehatan dan Cara Terbaik Mengonsumsinya',
                publisher: 'Kompas',
                date: '08 Juni 2023',
                imgUrl: 'assets/images/news3.jpg',
                action: () {
                  Navigator.pushNamed(context, '/news');
                },
              ),
              TopPicks(
                title: 'Kebakaran di Jakarta Timur Hanguskan 16 Kambing',
                publisher: 'Tempo',
                date: '08 Juni 2023',
                imgUrl: 'assets/images/news5.jpg',
                action: () {
                  Navigator.pushNamed(context, '/news');
                },
              ),
              TopPicks(
                title: 'Media Argentina Puji Sambutan Spesial Indonesia',
                publisher: 'CNN Indonesia',
                date: '05 Juni 2023',
                imgUrl: 'assets/images/news2.jpg',
                action: () {
                  Navigator.pushNamed(context, '/news');
                },
              ),
            ],
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            child: Text(
              'Saved',
              style: semi.copyWith(
                fontSize: 24,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 16, top: 4),
            child: Wrap(
              runSpacing: 16,
              children: [
                SavedCard(
                  title: 'Kebakaran di Jakarta Timur Hanguskan 16 Kambing',
                  imgUrl: 'assets/images/news5.jpg',
                  category: 'Regional',
                  publisher: 'Tempo',
                  date: '17 Juni 2023',
                  action: () {
                    Navigator.pushNamed(context, '/news');
                  },
                ),
                SavedCard(
                  title:
                      'Manfaat Habatusauda bagi Kesehatan dan Cara Terbaik Mengonsumsinya',
                  imgUrl: 'assets/images/news3.jpg',
                  category: 'Lifestyle',
                  publisher: 'Kompas',
                  date: '17 Juni 2023',
                  action: () {
                    Navigator.pushNamed(context, '/news');
                  },
                ),
                SavedCard(
                  title: 'Media Argentina Puji Sambutan Spesial Indonesia',
                  imgUrl: 'assets/images/news2.jpg',
                  category: 'Sport',
                  publisher: 'CNN Indonesia',
                  date: '17 Juni 2023',
                  action: () {
                    Navigator.pushNamed(context, '/news');
                  },
                ),
                SavedCard(
                  title:
                      'Pertamina Ajak Generasi Muda Jadi Agen Perubahan Lingkungan',
                  imgUrl: 'assets/images/news1.jpg',
                  category: 'Economy',
                  publisher: 'CNN Indonesia',
                  date: '17 Juni 2023',
                  action: () {
                    Navigator.pushNamed(context, '/news');
                  },
                ),
                SavedCard(
                  title:
                      'Elektabilitas Anies Salip Ganjar dan Pepet Prabowo di Survei Terbaru IPO',
                  imgUrl: 'assets/images/news6.jpg',
                  category: 'Politics',
                  publisher: 'Tempo',
                  date: '17 Juni 2023',
                  action: () {
                    Navigator.pushNamed(context, '/news');
                  },
                ),
              ],
            ),
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
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
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
                      'Emir Abiyyu',
                      style: semi,
                    ),
                  ),
                  Text(
                    'Joined July 2022',
                    style: medium.copyWith(
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
                          action: () {},
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
                          action: () {},
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Last Login : Just Now',
                    style: medium.copyWith(
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

class TopAll extends StatelessWidget {
  const TopAll({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TopPicks(
          title: 'Media Argentina Puji Sambutan Spesial Indonesia',
          publisher: 'CNN Indonesia',
          date: '17 Juni 2023',
          imgUrl: 'assets/images/news2.jpg',
          action: () {
            Navigator.pushNamed(context, '/news');
          },
        ),
        TopPicks(
          title:
              'Manfaat Habatusauda bagi Kesehatan dan Cara Terbaik Mengonsumsinya',
          publisher: 'Kompas',
          date: '17 Juni 2023',
          imgUrl: 'assets/images/news3.jpg',
          action: () {
            Navigator.pushNamed(context, '/news');
          },
        ),
        TopPicks(
          title:
              'Air Sungai Bengawan Solo Tercemar Limbah Industri Minuman Beralkohol, Berbau Dan Berwarna Hitam',
          publisher: 'Kompas',
          date: '17 Juni 2023',
          imgUrl: 'assets/images/news4.jpg',
          action: () {
            Navigator.pushNamed(context, '/news');
          },
        ),
      ],
    );
  }
}
