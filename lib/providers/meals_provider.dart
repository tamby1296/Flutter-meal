import 'package:demo4/data/dummy_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final MealsProvider = Provider((ref) {
  return availableMeals;
});