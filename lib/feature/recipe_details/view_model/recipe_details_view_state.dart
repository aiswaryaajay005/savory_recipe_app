import 'package:recipe_app_mvvm_riverpod/feature/home/model/recipe_model.dart';

class RecipeDetailsViewState {
  Recipe? recipes;

  bool isLoading;

  RecipeDetailsViewState({this.recipes, this.isLoading = false});

  RecipeDetailsViewState copyWith({Recipe? recipes, bool? isLoading}) {
    return RecipeDetailsViewState(
      recipes: recipes ?? this.recipes,

      isLoading: isLoading ?? this.isLoading,
    );
  }
}
