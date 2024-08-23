import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/presentation/bloc/bloc/user_bloc.dart' as user_bloc;
import '../../domain/entities/product.dart';
import '../bloc/product_bloc.dart';
import '../widgets/cards.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(LoadAllProductEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
        backgroundColor: Colors.blue,
        shape: const CircleBorder(eccentricity: 0),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<ProductBloc, ProductBlocState>(
            listener: (context, state) {
              // Handle product-related states here if necessary
            },
          ),
          BlocListener<user_bloc.UserBloc, user_bloc.UserState>(
            listener: (context, state) {
              if (state is user_bloc.LoggedOutState) {
                Navigator.pushNamed(context, '/login_page');
              } else if (state is user_bloc.ErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
          ),
        ],
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(padding: EdgeInsets.only(top: 20)),
                Row(
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const SizedBox(height: 40, width: 40),
                    ),
                    const Padding(padding: EdgeInsets.only(right: 10)),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'July 14 2023',
                          style: TextStyle(
                            fontFamily: 'Syne',
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xffAAAAAA),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'Hello, ',
                              style: TextStyle(
                                fontFamily: 'Sora',
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              'Yohannes',
                              style: TextStyle(
                                fontFamily: 'Sora',
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        DecoratedBox(
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Icon(
                              CupertinoIcons.bell,
                              size: 16,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            context
                                .read<user_bloc.UserBloc>()
                                .add(user_bloc.LogoutEvent());
                          },
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Icon(
                                Icons.logout_rounded,
                                size: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        'Available Products',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        height: 30,
                        width: 30,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: BlocBuilder<ProductBloc, ProductBlocState>(
                            builder: (context, state) {
                              return IconButton(
                                onPressed: () {
                                  if (state is LoadedAllProductState) {
                                    if (state.allProducts.isEmpty) {
                                      return;
                                    } else {
                                      final productEntity = state.allProducts;
                                      Navigator.pushNamed(context, '/search',
                                          arguments: productEntity);
                                    }
                                  }
                                },
                                icon: const Icon(
                                  CupertinoIcons.search,
                                ),
                                color: Colors.grey,
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: BlocBuilder<ProductBloc, ProductBlocState>(
                    builder: (context, state) {
                      if (state is LoadingState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is ErrorState) {
                        return Center(child: Text(state.message));
                      } else if (state is LoadedAllProductState) {
                        if (state.allProducts.isEmpty) {
                          return const Center(
                            child: Text("There's no product"),
                          );
                        } else {
                          return ListView.builder(
                            itemCount: state.allProducts.length,
                            itemBuilder: (context, index) {
                              final productEntity = state.allProducts[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/detail_page',
                                    arguments: Product(
                                      productid: productEntity.productid,
                                      description: productEntity.description,
                                      imageUrl: productEntity.imageUrl,
                                      name: productEntity.name,
                                      price: productEntity.price,
                                    ),
                                  );
                                },
                                child: Cards(
                                  imageUrl: productEntity.imageUrl,
                                  name: productEntity.name,
                                  price: productEntity.price,
                                ),
                              );
                            },
                          );
                        }
                      } else {
                        return const Center(
                            child: Text("Something went wrong"));
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
