import 'dart:convert';
import 'dart:developer';

import 'package:recipe_app_mvvm_riverpod/core/services/api_Services.dart';
import 'package:recipe_app_mvvm_riverpod/feature/home/model/recipe_model.dart';

class RecipeDetailsViewService {
  // Service method
  static Future<Recipe?> fetchRecipeDeatils({required int id}) async {
    final res = await ApiService.getMethod(endpoint: '/recipes/$id');
    if (res != null) {
      final data = jsonDecode(res);
      return Recipe.fromJson(data); // returns a single Recipe
    }
    return null;
  }
}
