import 'package:flutter/material.dart';
import 'add_page.dart';
import 'details_page.dart';
import 'home_page.dart';
import 'search_product.dart';

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
