import 'package:recipe_app_mvvm_riverpod/feature/home/model/recipe_model.dart';

class HomeViewState {
  List<Recipe> recipes;
  List<String>? tags;
  bool isLoading;

  HomeViewState({required this.recipes, this.tags, this.isLoading = false});

  HomeViewState copyWith({
    List<Recipe>? recipes,
    List<String>? tags,
    bool? isLoading,
  }) {
    return HomeViewState(
      recipes: recipes ?? this.recipes,
      tags: tags ?? this.tags,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
