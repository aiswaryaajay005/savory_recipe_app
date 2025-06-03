import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app_mvvm_riverpod/feature/recipe_details/service/recipe_details_view_Service.dart';
import 'package:recipe_app_mvvm_riverpod/feature/recipe_details/view_model/recipe_details_view_state.dart';

final recipeDetailsProvider = StateNotifierProvider((ref) {
  return RecipeDetailsNotifier();
});

class RecipeDetailsNotifier extends StateNotifier<RecipeDetailsViewState> {
  RecipeDetailsNotifier() : super(RecipeDetailsViewState());
  Future<void> fetchRecipeDetails({required int id}) async {
    try {
      state = state.copyWith(isLoading: true);
      final recipes = await RecipeDetailsViewService.fetchRecipeDeatils(id: id);
      state = state.copyWith(isLoading: false, recipes: recipes);
    } catch (e) {
      log(" RECIPE VIEW MODEL ERROR");
      log(e.toString());
      state = state.copyWith(isLoading: false);
    }
    state = state.copyWith(isLoading: false);
  }
}
