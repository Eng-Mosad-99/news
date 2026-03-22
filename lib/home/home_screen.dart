import 'package:flutter/material.dart';
import 'package:news/home/category_details/category_details.dart';
import 'package:news/home/category_fragment/category_fragment.dart';
import 'package:news/home/drawer/home_drawer.dart';
import 'package:news/model/category.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          selectedCategory?.id == null ? 'Home' : selectedCategory!.title,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      drawer: Drawer(child: HomeDrawer(onGoToHomeClick: onGoToHomeClick)),
      body: selectedCategory == null
          ? CategoryFragment(onCategoryItemClick: onCategoryItemClick)
          : CategoryDetails(category: selectedCategory!),
    );
  }

  Category? selectedCategory;

  void onCategoryItemClick(Category newSelectedCategory) {
    selectedCategory = newSelectedCategory;
    print('selected category is ${selectedCategory?.id ?? ''}');
    setState(() {});
  }

  void onGoToHomeClick() {
    selectedCategory = null;
    Navigator.pop(context);
    setState(() {});
  }
}
