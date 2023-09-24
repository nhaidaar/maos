import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maos/blocs/auth/auth_bloc.dart';
import 'package:maos/pages/auth/login.dart';
import 'package:maos/pages/home/profile.dart';
import 'package:maos/shared/theme.dart';

import 'timeline.dart';
import 'following.dart';
import 'saved.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const Timeline(),
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
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ),
              (route) => false);
        }
      },
      child: Scaffold(
        body: _pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.black,
          selectedLabelStyle: semiboldTS.copyWith(fontSize: 12),
          unselectedLabelStyle: mediumTS.copyWith(fontSize: 12),
          items: const [
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: ImageIcon(
                  AssetImage(
                    'assets/icons/home_outlined.png',
                  ),
                  size: 25,
                ),
              ),
              activeIcon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: ImageIcon(
                  AssetImage(
                    'assets/icons/home_filled.png',
                  ),
                  size: 25,
                ),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: ImageIcon(
                  AssetImage(
                    'assets/icons/following_outlined.png',
                  ),
                  size: 25,
                ),
              ),
              activeIcon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: ImageIcon(
                  AssetImage(
                    'assets/icons/following_filled.png',
                  ),
                  size: 25,
                ),
              ),
              label: 'Following',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: ImageIcon(
                  AssetImage(
                    'assets/icons/saved_outlined.png',
                  ),
                  size: 25,
                ),
              ),
              activeIcon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: ImageIcon(
                  AssetImage(
                    'assets/icons/saved_filled.png',
                  ),
                  size: 25,
                ),
              ),
              label: 'Saved',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: ImageIcon(
                  AssetImage(
                    'assets/icons/profile_circle_outlined.png',
                  ),
                  size: 25,
                ),
              ),
              activeIcon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: ImageIcon(
                  AssetImage(
                    'assets/icons/profile_circle_filled.png',
                  ),
                  size: 25,
                ),
              ),
              label: 'Profile',
            ),
          ],
        ),
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
              context.read<AuthBloc>().add(AuthSignOut());
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
