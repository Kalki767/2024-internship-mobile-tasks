import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../domain/entities/product.dart';
import '../bloc/product_bloc.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({super.key});

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  File? selectedImage;
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as String;
    late Product _updatedProduct;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Navigator.pop(context);
              // Handle back button press
            },
          ),
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Update Product',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                    color: Color(0xff3E3E3E)),
              )
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 16),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'name',
                      style: TextStyle(color: Color(0xff3E3E3E)),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                TextField(
                  decoration: const InputDecoration(
                    fillColor: Color(0xffF3F3F3),
                    focusColor: Color(0xffF3F3F3),
                    border: OutlineInputBorder(),
                  ),
                  controller: nameController,
                ),
                const SizedBox(height: 16),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'category',
                      style: TextStyle(color: Color(0xff3E3E3E)),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  controller: categoryController,
                ),
                const SizedBox(height: 16),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'price',
                      style: TextStyle(color: Color(0xff3E3E3E)),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: priceController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    suffixIcon: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        '\$',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'description',
                      style: TextStyle(color: Color(0xff3E3E3E)),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 5,
                  controller: descriptionController,
                ),
                const SizedBox(height: 16),
                BlocConsumer<ProductBloc, ProductBlocState>(
                  builder: (context, state) {
                    return ElevatedButton(
                        onPressed: () {
                          if (nameController.text == '' ||
                              descriptionController.text == '' ||
                              validatePrice(priceController.text) == false) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Please Provide Required Fields')));
                          } else {
                            final Product updatedProduct = Product(
                                productid: args,
                                name: nameController.text,
                                description: descriptionController.text,
                                price: priceController.text,
                                imageUrl: '');

                            final productBloc =
                                BlocProvider.of<ProductBloc>(context);

                            productBloc
                                .add(UpdateProductEvent(args, updatedProduct));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff3F51F3),
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            fixedSize: const Size(300, 30),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8))),
                        child: const Text(
                          'Update',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: Colors.white),
                        ));
                  },
                  listener: (BuildContext context, ProductBlocState state) {
                    if (state is LoadingState) {
                      const CircularProgressIndicator.adaptive();
                    } else if (state is SuccesfulUpdate) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              'You have succesfully updated your product')));

                      context.read<ProductBloc>().add(LoadAllProductEvent());
                      Navigator.pushNamed(
                        context,
                        '/',
                      );
                    } else if (state is ErrorState) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(state.message)));
                      ;
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ));
  }
}

bool validatePrice(String value) {
  final int? price = int.tryParse(value);
  if (price == null) {
    return false;
  }
  return true;
}
