import 'package:flutter/widgets.dart';
import 'package:recipe_app_mvvm_riverpod/feature/home/model/recipe_model.dart';

class SearchViewState {
  List<Recipe> recipes;
  List<String>? tags;
  bool isLoading;
  TextEditingController? sController = TextEditingController();
  SearchViewState({
    required this.recipes,
    this.tags,
    this.isLoading = false,
    this.sController,
  });

  SearchViewState copyWith({
    List<Recipe>? recipes,
    List<String>? tags,
    bool? isLoading,
    TextEditingController? sController,
  }) {
    return SearchViewState(
      recipes: recipes ?? this.recipes,
      tags: tags ?? this.tags,
      isLoading: isLoading ?? this.isLoading,
      sController: sController ?? this.sController,
    );
  }
}
