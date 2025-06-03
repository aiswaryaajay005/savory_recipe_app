import 'dart:convert';
import 'dart:developer';

import 'package:recipe_app_mvvm_riverpod/core/services/api_Services.dart';
import 'package:recipe_app_mvvm_riverpod/feature/home/model/recipe_model.dart';

class HomeViewService {
  static Future<List<String>> fetchTags() async {
    final res = await ApiService.getMethod(endpoint: '/recipes/tags');
    if (res != null) {
      final List<dynamic> jsonList = jsonDecode(res);
      log(jsonList.toString());
      return List<String>.from(jsonList);
    } else {
      log("HOME VIEW SERVICE");
      log("error");
      return [];
    }
  }

  static Future<List<Recipe>?> fetchRecipes() async {
    final resBody = await ApiService.getMethod(endpoint: "/recipes");
    if (resBody != null) {
      final resModel = recipeModelFromJson(resBody);
      log(resModel.recipes.toString());
      return resModel.recipes;
    } else {
      log("HOME VIEW SERVICE");
      log("error");
      return null;
    }
  }
}
