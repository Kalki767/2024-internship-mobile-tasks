import 'package:flutter/material.dart';

import 'features/injection_container.dart' as di;
import 'features/product/presentation/pages/add_page.dart';
import 'features/product/presentation/pages/details_page.dart';
import 'features/product/presentation/pages/home_page.dart';
import 'features/product/presentation/pages/search_product.dart';

Future<void> main() async {
  await di.init();
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
