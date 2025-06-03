import 'dart:convert';
import 'dart:developer';

import 'package:recipe_app_mvvm_riverpod/core/services/api_Services.dart';
import 'package:recipe_app_mvvm_riverpod/feature/home/model/recipe_model.dart';

class SearchViewService {
  Future<List<Recipe>> searchRecipes({required String searchQuery}) async {
    final res = await ApiService.getMethod(
      endpoint: '/recipes/search?q=$searchQuery',
    );

    if (res != null) {
      final Map<String, dynamic> jsonMap = jsonDecode(res);

      // Adjust this based on the actual key from the API response
      final List<dynamic> recipeList = jsonMap['recipes']; // or another key

      final recipes = recipeList.map((json) => Recipe.fromJson(json)).toList();
      return recipes;
    } else {
      log("SEARCH VIEW SERVICE");
      log("error");
      return [];
    }
  }
}
