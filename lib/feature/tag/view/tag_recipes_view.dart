import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app_mvvm_riverpod/feature/home/view_model/home_view_model.dart';
import 'package:recipe_app_mvvm_riverpod/feature/home/view_model/home_view_state.dart';
import 'package:recipe_app_mvvm_riverpod/feature/recipe_details/view/recipe_details_view.dart';
import 'package:recipe_app_mvvm_riverpod/feature/search/view/search_view.dart';
import 'package:recipe_app_mvvm_riverpod/feature/tag/view_model/tag_recipe_view_model.dart';
import 'package:recipe_app_mvvm_riverpod/feature/tag/view_model/tag_recipe_view_state.dart';

class TagRecipeView extends ConsumerStatefulWidget {
  final String tag;
  const TagRecipeView({super.key, required this.tag});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<TagRecipeView> {
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(tagRecipeProvider.notifier).fetchRecipes(tag: widget.tag);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenProvider = ref.watch(tagRecipeProvider) as TagRecipeViewState;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.green,
        title: Text(
          widget.tag,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
          screenProvider.isLoading
              ? Center(child: CircularProgressIndicator())
              : Expanded(
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
                                      recId:
                                          screenProvider.recipes[index].id ?? 0,
                                    ),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.green,
                                width: 4.0,
                              ),
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
