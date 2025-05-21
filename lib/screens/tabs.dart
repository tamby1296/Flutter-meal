import 'package:demo4/models/meal.dart';
import 'package:demo4/screens/categories.dart';
import 'package:demo4/screens/meals.dart';
import 'package:demo4/widgets/sidebar.dart';
import 'package:flutter/material.dart';

class Tabs extends StatefulWidget {
  const Tabs({super.key});

  @override
  State<Tabs> createState() {
    return _TabsState();
  }
}

class _TabsState extends State<Tabs> {
  int _selectedPageIndex = 0;
  final List<Meal> _favoriteMeals = [];

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _toggleMealFavorite(Meal meal) {
    if (_favoriteMeals.contains(meal)) {
      setState(() {
        _favoriteMeals.remove(meal);
      });
      _showInfoMessage('Meal is no longer a favourite');
    } else {
      setState(() {
        _favoriteMeals.add(meal);
      });
      _showInfoMessage('Meal added as favourite');
    }
  }

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message))
    );
  }

  @override
  Widget build(BuildContext context) {
    String activePageName = 'Categories';
    Widget content = CategoriesScreen(onFavoriteToggle: _toggleMealFavorite);

    if (_selectedPageIndex == 1) {
    activePageName = 'Favourites';
      content = MealsScreen(
        meals: _favoriteMeals,
        onFavoriteMeal: _toggleMealFavorite,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageName),
      ),
      drawer: const Sidebar(),
      body: content,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favourites',
          ),
        ],
      ),
    );
  }
}
