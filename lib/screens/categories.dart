import 'package:demo4/data/dummy_data.dart';
import 'package:demo4/models/category.dart';
import 'package:demo4/models/meal.dart';
import 'package:demo4/screens/meals.dart';
import 'package:demo4/widgets/category_grid_item.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatefulWidget {
  final List<Meal> meals;

  const CategoriesScreen({super.key, required this.meals});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
      // lowerBound: 0,
      // upperBound: 1
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: Scaffold(
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
      ),
      builder:
          (context, child) => SlideTransition(
            position: Tween(
              begin: Offset(0, 1),
              end: Offset(0, 0)
            ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut)),
            child: child,
          ),
    );
  }

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals =
        widget.meals
            .where((meal) => meal.categories.contains(category.id))
            .toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (ctx) => MealsScreen(title: category.title, meals: filteredMeals),
      ),
    );
  }
}
