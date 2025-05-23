import 'package:demo4/providers/favorites_provider.dart';
import 'package:demo4/providers/meals_provider.dart';
import 'package:demo4/screens/categories.dart';
import 'package:demo4/screens/filters.dart';
import 'package:demo4/screens/meals.dart';
import 'package:demo4/widgets/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const kInitialFilters = {
    FilterEnum.glutenFree: false,
    FilterEnum.lactoseFree: false,
    FilterEnum.vegetarian: false,
    FilterEnum.vegan: false,
  };

class Tabs extends ConsumerStatefulWidget {
  const Tabs({super.key});

  @override
  ConsumerState<Tabs> createState() {
    return _TabsState();
  }
}

class _TabsState extends ConsumerState<Tabs> {
  int _selectedPageIndex = 0;
  Map<FilterEnum, bool> _selectedFilters = kInitialFilters;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
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
    final meals = ref.watch(MealsProvider);
    final availableMeals = meals.where((meal) {
      if(_selectedFilters[FilterEnum.glutenFree]! && !meal.isGlutenFree) return false;
      if(_selectedFilters[FilterEnum.lactoseFree]! && !meal.isLactoseFree) return false;
      if(_selectedFilters[FilterEnum.vegetarian]! && !meal.isVegetarian) return false;
      if(_selectedFilters[FilterEnum.vegan]! && !meal.isVegan) return false;
      return true;
    }).toList();

    Widget content = CategoriesScreen(meals: availableMeals);

    if (_selectedPageIndex == 1) {
    final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePageName = 'Favourites';
      content = MealsScreen(
        meals: favoriteMeals
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
