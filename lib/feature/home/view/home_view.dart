import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app_mvvm_riverpod/feature/home/view_model/home_view_model.dart';
import 'package:recipe_app_mvvm_riverpod/feature/home/view_model/home_view_state.dart';
import 'package:recipe_app_mvvm_riverpod/feature/recipe_details/view/recipe_details_view.dart';
import 'package:recipe_app_mvvm_riverpod/feature/search/view/search_view.dart';
import 'package:recipe_app_mvvm_riverpod/feature/tag/view/tag_recipes_view.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(homeViewNotifierProvider.notifier).fetchRecipeTags();
      ref.read(homeViewNotifierProvider.notifier).fetchRecipes();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenProvider = ref.watch(homeViewNotifierProvider) as HomeViewState;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          "Savory",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchView()),
              );
            },
            icon: Icon(Icons.search, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 120,
            child:
                screenProvider.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: screenProvider.tags?.length ?? 0,
                      itemBuilder:
                          (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => TagRecipeView(
                                          tag: screenProvider.tags![index],
                                        ),
                                  ),
                                );
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.green,
                                radius: 55,
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundColor: Colors.white,
                                  child: Text(
                                    screenProvider.tags?[index] ?? "",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ),
                              ),
                            ),
                          ),
                    ),
          ),

          // Text("I would like to cook", style: TextStyle(fontSize: 24)),
          // SearchBar(
          //   backgroundColor: const WidgetStatePropertyAll(Colors.white),
          //   controller: controller,
          //   leading: IconButton(
          //     onPressed: controller.clear,
          //     icon: const Icon(Icons.close),
          //   ),
          //   shape: WidgetStatePropertyAll(
          //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          //   ),
          //   trailing: <Widget>[
          //     IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          //   ],
          // ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: screenProvider.recipes.length ?? 0,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                ),
                itemBuilder:
                    (context, index) => InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => RecipeDetailsView(
                                  recId: screenProvider.recipes[index].id ?? 0,
                                ),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green, width: 4.0),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 20,
                          children: [
                            SizedBox(height: 5),
                            CircleAvatar(
                              radius: 80,
                              backgroundImage: NetworkImage(
                                screenProvider.recipes[index].image ??
                                    "https://images.pexels.com/photos/842571/pexels-photo-842571.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                              ),
                            ),
                            Text(
                              screenProvider.recipes[index].name ??
                                  "Shrimp Salad",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
