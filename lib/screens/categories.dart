import 'package:demo4/data/dummy_data.dart';
import 'package:demo4/models/category.dart';
import 'package:demo4/models/meal.dart';
import 'package:demo4/screens/meals.dart';
import 'package:demo4/widgets/category_grid_item.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  final void Function(Meal) onFavoriteToggle;

  const CategoriesScreen({super.key, required this.onFavoriteToggle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          for (final cat in availableCategories)
            CategoryGridItem(
              category: cat,
              onSelectCategory: () {
                _selectCategory(context, cat);
              },
            ),
        ],
      ),
    );
  }

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = availableMeals.where((meal) => meal.categories.contains(category.id)).toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(title: category.title, meals: filteredMeals, onFavoriteMeal: onFavoriteToggle,),
      ),
    );
  }
}
