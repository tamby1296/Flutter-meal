import 'package:demo4/data/dummy_data.dart';
import 'package:demo4/models/meal.dart';
import 'package:demo4/screens/categories.dart';
import 'package:demo4/screens/filters.dart';
import 'package:demo4/screens/meals.dart';
import 'package:demo4/widgets/sidebar.dart';
import 'package:flutter/material.dart';

const kInitialFilters = {
    FilterEnum.glutenFree: false,
    FilterEnum.lactoseFree: false,
    FilterEnum.vegetarian: false,
    FilterEnum.vegan: false,
  };

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
  Map<FilterEnum, bool> _selectedFilters = kInitialFilters;

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
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _setScreen(String identifier) async {
    Navigator.pop(context);

    if (identifier == 'filters') {
      final result = await Navigator.of(context).push<Map<FilterEnum, bool>>(
        MaterialPageRoute(builder: (ctx) => Filters(currentFilters: _selectedFilters,)),
      );

      setState(() {
        _selectedFilters = result ?? kInitialFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String activePageName = 'Categories';
    final meals = availableMeals.where((meal) {
      if(_selectedFilters[FilterEnum.glutenFree]! && !meal.isGlutenFree) return false;
      if(_selectedFilters[FilterEnum.lactoseFree]! && !meal.isLactoseFree) return false;
      if(_selectedFilters[FilterEnum.vegetarian]! && !meal.isVegetarian) return false;
      if(_selectedFilters[FilterEnum.vegan]! && !meal.isVegan) return false;
      return true;
    }).toList();

    Widget content = CategoriesScreen(onFavoriteToggle: _toggleMealFavorite, meals: meals);

    if (_selectedPageIndex == 1) {
      activePageName = 'Favourites';
      content = MealsScreen(
        meals: _favoriteMeals,
        onFavoriteMeal: _toggleMealFavorite,
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(activePageName)),
      drawer: Sidebar(onSelectScreen: _setScreen),
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
