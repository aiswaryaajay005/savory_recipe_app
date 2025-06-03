import 'dart:developer';

import 'package:recipe_app_mvvm_riverpod/core/services/api_Services.dart';
import 'package:recipe_app_mvvm_riverpod/feature/home/model/recipe_model.dart';

class TagViewService {
  static Future<List<Recipe>?> fetchRecipes({required String tags}) async {
    final resBody = await ApiService.getMethod(endpoint: "/recipes/tag/$tags");
    if (resBody != null) {
      final resModel = recipeModelFromJson(resBody);
      log(resModel.recipes.toString());
      return resModel.recipes;
    } else {
      log("TAG VIEW SERVICE");
      log("error");
      return null;
    }
  }
}
