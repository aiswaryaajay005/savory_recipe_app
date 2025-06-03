import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app_mvvm_riverpod/feature/home/model/recipe_model.dart';
import 'package:recipe_app_mvvm_riverpod/feature/home/service/home_view_service.dart';
import 'package:recipe_app_mvvm_riverpod/feature/home/view_model/home_view_state.dart';

final homeViewNotifierProvider = StateNotifierProvider((ref) {
  return HomeViewNotifier();
});

class HomeViewNotifier extends StateNotifier<HomeViewState> {
  HomeViewNotifier() : super(HomeViewState(recipes: [], tags: null));
  Future<void> fetchRecipeTags() async {
    try {
      state = state.copyWith(isLoading: true);

      final tags = await HomeViewService.fetchTags();

      log(tags.toString());

      state = state.copyWith(tags: tags, isLoading: false);
    } catch (e) {
      log("HOME VIEW MODEL ERROR");
      log(e.toString());
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> fetchRecipes() async {
    try {
      state = state.copyWith(isLoading: true);
      final recipes = await HomeViewService.fetchRecipes();
      state = state.copyWith(isLoading: false, recipes: recipes);
    } catch (e) {
      log("HOME VIEW MODEL ERROR");
      log(e.toString());
      state = state.copyWith(isLoading: false);
    }
    state = state.copyWith(isLoading: false);
  }
}
