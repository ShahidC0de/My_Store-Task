import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task/features/home/presentation/widgets/tapbar_items.dart';
import 'package:task/core/theme/pallete.dart';

class Home2 extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => Home2());
  const Home2({super.key});

  @override
  State<Home2> createState() => _Home2State();
}

class _Home2State extends State<Home2> {
  int _currentPage = 0;

  void _onTabTapped(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  Widget returnCorrespondingScreen(int currentIndex) {
    return UIConstants.bottomTapBarScreens[currentIndex];
  }

  String _returnPageTitle(int currentIndex) {
    return UIConstants.screensTitle[currentIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(5)),
        child: CupertinoTabBar(
          border: Border(),
          height: 70,
          currentIndex: _currentPage,
          backgroundColor: Colors.black,
          onTap: _onTabTapped, // Update the current index on tap
          items: [
            BottomNavigationBarItem(
              icon: _tapBarItem(
                imagePath: 'assets/tapbar_icons/products.png',
                title: 'Products',
                isSelected: _currentPage == 0,
              ),
            ),
            BottomNavigationBarItem(
              icon: _tapBarItem(
                imagePath: 'assets/tapbar_icons/categories.png',
                title: 'Categories',
                isSelected: _currentPage == 1,
              ),
            ),
            BottomNavigationBarItem(
              icon: _tapBarItem(
                imagePath: 'assets/tapbar_icons/favorite.png',
                title: 'Favorites',
                isSelected: _currentPage == 2,
              ),
            ),
            BottomNavigationBarItem(
              icon: _tapBarItem(
                imagePath: 'assets/tapbar_icons/person.png',
                title: 'Settings',
                isSelected: _currentPage == 3,
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          _returnPageTitle(_currentPage),
          style: Pallete.titleText,
        ),
        centerTitle: true,
      ),
      body: IndexedStack(
        index: _currentPage,
        children: UIConstants.bottomTapBarScreens,
      ),
    );
  }

  Widget _tapBarItem({
    required String imagePath,
    required String title,
    required bool isSelected,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          imagePath,
          scale: 2,
          color: isSelected ? Colors.blue : Colors.white,
        ),
        Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.blue : Colors.white,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: isSelected ? 14 : 12,
          ),
        ),
      ],
    );
  }
}
