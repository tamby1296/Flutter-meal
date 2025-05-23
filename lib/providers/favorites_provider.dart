import 'package:demo4/models/meal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesMealsNotifier extends StateNotifier<List<Meal>> {
  FavoritesMealsNotifier() : super([]); // initial data

  bool toggleMealFavoriteStatus(Meal meal) {
    final isFavorite = state.contains(meal);

    if (isFavorite) {
      state = state.where((m) => meal.id != m.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoritesMealsNotifier, List<Meal>>((ref) {
      return FavoritesMealsNotifier();
    });
