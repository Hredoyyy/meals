import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/categoris.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';

const kInitFilter = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedIndex = 0;

  final List<Meal> _favouriteMeals = [];
  Map<Filter, bool> _selected = kInitFilter;

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }

  void _toggleFav(Meal meal) {
    final isExisting = _favouriteMeals.contains(meal);
    if (isExisting) {
      setState(() {
        _favouriteMeals.remove(meal);
        _showInfoMessage('Meal removed from favourites');
      });
    } else {
      setState(() {
        _favouriteMeals.add(meal);
        _showInfoMessage('Meal added to favourites');
      });
    }
  }

  void _selectTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _setScreen(String id) async {
    Navigator.of(context).pop();
    if (id == 'filters') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(builder: (ctx) => Filters(currentFilters: _selected)),
      );
      setState(() {
        _selected = result ?? kInitFilter;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals =
        dummyMeals.where((meal) {
          if (_selected[Filter.glutenFree]! && !meal.isGlutenFree) {
            return false;
          }
          if (_selected[Filter.lactoseFree]! && !meal.isLactoseFree) {
            return false;
          }
          if (_selected[Filter.vegetarian]! && !meal.isVegetarian) {
            return false;
          }
          if (_selected[Filter.vegan]! && !meal.isVegan) {
            return false;
          }
          return true;
        }).toList();
    var activePageTitle = 'Categories';
    Widget bodyContent = CategoriesScreen(
      onToggleFavorite: _toggleFav,
      availableMeals: availableMeals,
    );
    if (_selectedIndex == 1) {
      bodyContent = MealsScreen(
        meals: _favouriteMeals,
        onToggleFavorite: _toggleFav,
      );
      activePageTitle = 'Favourites';
    }
    return Scaffold(
      appBar: AppBar(title: Text(activePageTitle)),
      drawer: MainDrawer(onSelectScreen: _setScreen),
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
