import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app_mvvm_riverpod/feature/recipe_details/view_model/recipe_details_view_model.dart';

class RecipeDetailsView extends ConsumerStatefulWidget {
  final int recId;
  const RecipeDetailsView({super.key, required this.recId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RecipeDetailsViewState();
}

class _RecipeDetailsViewState extends ConsumerState<RecipeDetailsView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref
          .read(recipeDetailsProvider.notifier)
          .fetchRecipeDetails(id: widget.recId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final recipeProvider = ref.watch(recipeDetailsProvider);
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.green),
      body:
          recipeProvider.isLoading
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                child: Column(
                  spacing: 10,
                  children: [
                    Container(
                      height: 300,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                            recipeProvider.recipes?.image ??
                                "https://images.pexels.com/photos/18342416/pexels-photo-18342416/free-photo-of-cup-of-coffee-on-a-bed.jpeg?auto=compress&cs=tinysrgb&w=600",
                          ),
                        ),
                      ),
                    ),
                    Text(
                      recipeProvider.recipes?.name ?? "",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 60,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.timer, size: 30),
                                  Text(
                                    "${recipeProvider.recipes?.prepTimeMinutes.toString()} min" ??
                                        "",
                                  ),
                                  Text("Prep time"),
                                ],
                              ),
                            ),
                          ),
                          CircleAvatar(
                            radius: 60,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.timer, size: 30),
                                  Text(
                                    "${recipeProvider.recipes?.cookTimeMinutes.toString()} min" ??
                                        "",
                                  ),
                                  Text("Cook time"),
                                ],
                              ),
                            ),
                          ),
                          CircleAvatar(
                            radius: 60,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.food_bank_rounded, size: 30),
                                  Text(
                                    "${recipeProvider.recipes?.cuisine} " ?? "",
                                  ),
                                  Text("Cuisine"),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 60,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.restaurant, size: 30),
                                  Text(
                                    "${recipeProvider.recipes?.servings} " ??
                                        "",
                                  ),
                                  Text("Servings"),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          CircleAvatar(
                            radius: 60,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.food_bank_rounded, size: 30),
                                  Text(
                                    "${recipeProvider.recipes?.caloriesPerServing} " ??
                                        "",
                                  ),
                                  Text("calories"),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "Ingredients",
                      style: TextStyle(color: Colors.green, fontSize: 25),
                    ),
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            recipeProvider.recipes?.ingredients?.length ?? 0,
                        itemBuilder:
                            (context, index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 55,
                                backgroundColor: Colors.green,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 50,
                                  child: Center(
                                    child: Text(
                                      recipeProvider
                                              .recipes
                                              ?.ingredients?[index]
                                              .toString() ??
                                          "",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                      ),
                    ),
                    Text(
                      "Preparation Steps",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount:
                          recipeProvider.recipes?.instructions?.length ?? 0,
                      itemBuilder:
                          (context, index) => ListTile(
                            leading: Text("Step ${index + 1}"),
                            title: Text(
                              recipeProvider.recipes?.instructions?[index]
                                      .toString() ??
                                  "",
                            ),
                          ),
                    ),
                  ],
                ),
              ),
    );
  }
}
