import 'package:e_commerce_app/add_page.dart';
import 'package:e_commerce_app/details_page.dart';
import 'package:e_commerce_app/home_page.dart';
import 'package:e_commerce_app/search_product.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/search': (context) => const SearchProduct(),
        '/details': (context) => const DetailsPage(),
        '/add': (context) => const AddPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
