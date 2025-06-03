import 'package:recipe_app_mvvm_riverpod/feature/home/model/recipe_model.dart';

class TagRecipeViewState {
  List<Recipe> recipes;
  List<String>? tags;
  bool isLoading;

  TagRecipeViewState({
    required this.recipes,
    this.tags,
    this.isLoading = false,
  });

  TagRecipeViewState copyWith({List<Recipe>? recipes, bool? isLoading}) {
    return TagRecipeViewState(
      recipes: recipes ?? this.recipes,

      isLoading: isLoading ?? this.isLoading,
    );
  }
}
