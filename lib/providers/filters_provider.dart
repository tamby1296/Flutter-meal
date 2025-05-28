import 'package:demo4/providers/meals_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum FilterEnum { glutenFree, lactoseFree, vegetarian, vegan }

class FiltersNotifier extends StateNotifier<Map<FilterEnum, bool>> {
  FiltersNotifier()
    : super({
        FilterEnum.glutenFree: false,
        FilterEnum.lactoseFree: false,
        FilterEnum.vegetarian: false,
        FilterEnum.vegan: false,
      });

  void setFilter(FilterEnum key) {
    state = {...state, key: !state[key]!};
  }
}

final filtersProvider = StateNotifierProvider((ref) {
  return FiltersNotifier();
});

final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(MealsProvider);
  final activeFilters = ref.watch(filtersProvider);
  return meals.where((meal) {
    if (activeFilters[FilterEnum.glutenFree]! && !meal.isGlutenFree) return false;
    if (activeFilters[FilterEnum.lactoseFree]! && !meal.isLactoseFree) return false;
    if (activeFilters[FilterEnum.vegetarian]! && !meal.isVegetarian) return false;
    if (activeFilters[FilterEnum.vegan]! && !meal.isVegan) return false;
    return true;
  }).toList();
});
