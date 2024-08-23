import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/product.dart';
import '../bloc/product_bloc.dart';
import '../widgets/bottom_sheet.dart';
import '../widgets/cards.dart';

class SearchProduct extends StatefulWidget {
  const SearchProduct({super.key});

  @override
  State<SearchProduct> createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  TextEditingController _searchController = TextEditingController();
  List<Product> filteredProducts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            context.read<ProductBloc>().add(LoadAllProductEvent());
            Navigator.of(context).pop();
          },
        ),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Search Product',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins',
                color: Color(0xff3E3E3E),
              ),
            )
          ],
        ),
      ),
      body: BlocConsumer<ProductBloc, ProductBlocState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is ErrorState) {
            return Center(
              child: Text(state.message),
            );
          }
          if (state is LoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        onChanged: (value) {
                          context
                              .read<ProductBloc>()
                              .add(FilterProductEvent(text: value));
                        },
                        decoration: InputDecoration(
                          labelText: 'Leather',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          suffixIcon: const Icon(Icons.arrow_forward),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      iconSize: 35,
                      icon: const Icon(Icons.filter_alt_sharp,
                          color: Colors.blue),
                      onPressed: () {
                        bottomSheet(context);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount:
                        (state as LoadedAllProductState).allProducts.length,
                    itemBuilder: (context, index) {
                      String _imageUrl = (state).allProducts[index].imageUrl;
                      String _name = (state).allProducts[index].name;
                      dynamic _price = (state).allProducts[index].price;
                      return Cards(
                        imageUrl: _imageUrl,
                        name: _name,
                        price: _price,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          );
        },
      ),
    );
  }
}
