import 'package:demo4/models/meal.dart';
import 'package:demo4/screens/meal_details.dart';
import 'package:demo4/widgets/meal_item.dart';
import 'package:flutter/material.dart';

class MealsScreen extends StatelessWidget {
  final String? title;
  final List<Meal> meals;
  final void Function(Meal) onFavoriteMeal;

  const MealsScreen({super.key, this.title, required this.meals, required this.onFavoriteMeal});

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: meals.length,
      itemBuilder: (ctx, i) => MealItem(meal: meals[i], onSelectMeal: () {
        _selectMeal(context, meals[i]);
      },),
    );

    if (meals.isEmpty) {
      Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'No meals for the selected category',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
      );
    }
    return title == null ? content : Scaffold(appBar: AppBar(title: Text(title!)), body: content);
  }

  void _selectMeal (BuildContext context, Meal meal) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => MealDetails(meal, onFavoriteToggle: onFavoriteMeal,),
      ),
    );
  }
}
