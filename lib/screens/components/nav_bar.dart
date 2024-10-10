import 'package:flutter/material.dart';
import 'package:webtoon_explorer_app/screens/home_screen.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _currentIndex = 0;

  List<Widget> pages = [
    const HomeScreen(),
    const HomeScreen(), //categories..
    const HomeScreen(), // favourite..
    const HomeScreen(), // settings...
  ];
  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: pages.elementAt(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: const Color(0xffFB700),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: ((value) {
          setState(() {
            _currentIndex = value;
          });
        }),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              size: myHeight * 0.03,
            ),
            label: '',
            activeIcon: Icon(
              Icons.home,
              size: myHeight * 0.03,
              color: const Color(0xffFBC700),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.category_outlined,
              size: myHeight * 0.03,
            ),
            label: '',
            activeIcon: Icon(
              Icons.category_rounded,
              size: myHeight * 0.03,
              color: const Color(0xffFBC700),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite_border_outlined,
              size: myHeight * 0.03,
            ),
            label: '',
            activeIcon: Icon(
              Icons.favorite,
              size: myHeight * 0.03,
              color: const Color(0xffFBC700),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings_outlined,
              size: myHeight * 0.03,
            ),
            label: '',
            activeIcon: Icon(
              Icons.settings,
              size: myHeight * 0.03,
              color: const Color(0xffFBC700),
            ),
          ),
        ],
      ),
    );
  }
}
