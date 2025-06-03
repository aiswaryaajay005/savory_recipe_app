import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app_mvvm_riverpod/feature/home/model/recipe_model.dart';
import 'package:recipe_app_mvvm_riverpod/feature/search/service/search_view_service.dart';
import 'package:recipe_app_mvvm_riverpod/feature/search/view_model/search_view_state.dart';

final SearchQueryProvider = StateNotifierProvider((ref) {
  return SearchViewNotifier();
});

class SearchViewNotifier extends StateNotifier<SearchViewState> {
  SearchViewNotifier() : super(SearchViewState(recipes: []));

  Future<void> searchRecipes() async {
    try {
      state = state.copyWith(isLoading: true);
      final service = SearchViewService();
      final recipes =
          await service.searchRecipes(
                searchQuery: state.sController?.text ?? "pasta",
              )
              as List<Recipe>;
      state = state.copyWith(isLoading: false, recipes: recipes);
    } catch (e) {
      log("SEARCH VIEW MODEL ERROR");
      log(e.toString());
      state = state.copyWith(isLoading: false);
    }
    state = state.copyWith(isLoading: false);
  }
}
