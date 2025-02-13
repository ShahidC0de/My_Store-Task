import 'package:flutter/material.dart';
import 'package:task/features/home/presentation/screens/category_screen.dart';
import 'package:task/features/home/presentation/screens/favorite_screen.dart';
import 'package:task/features/home/presentation/screens/product_screen.dart';
import 'package:task/features/home/presentation/screens/settings.dart';

class UIConstants {
  static TextEditingController controller = TextEditingController();

  static List<Widget> bottomTapBarScreens = [
    ProductScreen(),
    CategoryScreen(),
    FavoriteScreen(),
    Settings(),
  ];

  static List<String> screensTitle = [
    'Products',
    'Categories',
    'Favorites',
    'Shahid',
  ];
}
