import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_app_mvvm_riverpod/feature/home/view/home_view.dart';
import 'package:recipe_app_mvvm_riverpod/feature/recipe_details/view/recipe_details_view.dart';

void main() {
  runApp(ProviderScope(child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Scaffold(body: HomeView()));
  }
}
