import 'package:flutter/material.dart';
import 'package:meals/screens/categoris.dart';
import 'package:meals/screens/meals.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedIndex = 0;

  void _selectTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var activePageTitle = 'Categories';
    Widget bodyContent = CategoriesScreen();
    if (_selectedIndex == 1) {
      bodyContent = const MealsScreen(meals: []);
      activePageTitle = 'Favourites';
    }
    return Scaffold(
      appBar: AppBar(title: Text(activePageTitle)),
      body: bodyContent,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _selectTab,

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: "Categories",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.stars_sharp),
            label: "Favourites",
          ),
        ],
      ),
    );
  }
}
