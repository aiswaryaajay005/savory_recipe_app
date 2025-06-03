import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app_mvvm_riverpod/feature/recipe_details/view/recipe_details_view.dart';
import 'package:recipe_app_mvvm_riverpod/feature/search/view_model/search_view_model.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

class SearchView extends ConsumerWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(SearchQueryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Recipes"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              controller: query.sController,
              decoration: InputDecoration(
                hintText: 'Search by name...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                ref.read(SearchQueryProvider.notifier).searchRecipes();
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child:
                  query.isLoading
                      ? Center(child: CircularProgressIndicator())
                      : query.recipes.isEmpty
                      ? const Center(child: Text("No results found"))
                      : ListView.builder(
                        itemCount: query.recipes.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              title: Text(query.recipes[index].name ?? ""),
                              leading: const Icon(Icons.restaurant_menu),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => RecipeDetailsView(
                                          recId: query.recipes[index].id ?? 0,
                                        ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
