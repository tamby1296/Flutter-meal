import 'package:demo4/providers/favorites_provider.dart';
import 'package:demo4/providers/filters_provider.dart';
import 'package:demo4/screens/categories.dart';
import 'package:demo4/screens/filters.dart';
import 'package:demo4/screens/meals.dart';
import 'package:demo4/widgets/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Tabs extends ConsumerStatefulWidget {
  const Tabs({super.key});

  @override
  ConsumerState<Tabs> createState() {
    return _TabsState();
  }
}

class _TabsState extends ConsumerState<Tabs> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.pop(context);

    if (identifier == 'filters') {
      Navigator.of(context).push<Map<FilterEnum, bool>>(
        MaterialPageRoute(builder: (ctx) => Filters()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String activePageName = 'Categories';
    final filteredMeals = ref.watch(filteredMealsProvider);

    Widget content = CategoriesScreen(meals: filteredMeals);

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
