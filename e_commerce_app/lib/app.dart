import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/auth/presentation/bloc/bloc/user_bloc.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/product/presentation/bloc/product_bloc.dart';
import 'features/product/presentation/pages/add_page.dart';
import 'features/product/presentation/pages/details_page.dart';
import 'features/product/presentation/pages/search_product.dart';
import 'features/product/presentation/pages/update_page.dart';
import 'injection_container.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<ProductBloc>(create: (context) => sl<ProductBloc>()),
          BlocProvider<UserBloc>(create: (context) => sl<UserBloc>())
        ],
        child: MaterialApp(
          initialRoute: '/',
          routes: {
            '/': (context) => const LoginPage(),
            '/search': (context) => const SearchProduct(),
            '/add': (context) => const AddPage(),
            '/detail_page': (context) => DetailsPage(),
            '/update_page': (context) => const UpdatePage(),
          },
          debugShowCheckedModeBanner: false,
        ));
  }
}
