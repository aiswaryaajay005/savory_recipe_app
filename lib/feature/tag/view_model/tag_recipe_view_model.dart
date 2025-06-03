import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app_mvvm_riverpod/feature/tag/service/tag_view_service.dart';
import 'package:recipe_app_mvvm_riverpod/feature/tag/view_model/tag_recipe_view_state.dart';

final tagRecipeProvider = StateNotifierProvider((ref) {
  return TagRecipeNotifier();
});

class TagRecipeNotifier extends StateNotifier<TagRecipeViewState> {
  TagRecipeNotifier() : super(TagRecipeViewState(recipes: []));
  Future<void> fetchRecipes({required String tag}) async {
    try {
      state = state.copyWith(isLoading: true);
      final recipes = await TagViewService.fetchRecipes(tags: tag);
      state = state.copyWith(isLoading: false, recipes: recipes);
    } catch (e) {
      log("TAG RECIPE VIEW MODEL ERROR");
      log(e.toString());
      state = state.copyWith(isLoading: false);
    }
    state = state.copyWith(isLoading: false);
  }
}
