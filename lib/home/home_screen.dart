import 'package:flutter/material.dart';
import 'package:news/home/category_details/category_details.dart';
import 'package:news/home/category_fragment/category_fragment.dart';
import 'package:news/home/drawer/home_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('News App' , style: Theme.of(context).textTheme.headlineLarge),
      ),
      drawer: HomeDrawer(),
      body: CategoryFragment(),
    );
  }
}