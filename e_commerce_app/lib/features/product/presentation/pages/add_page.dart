import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../domain/entities/product.dart';
import '../bloc/product_bloc.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  File? selectedImage;
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                'Add Product',
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
                GestureDetector(
                  onTap: () async {
                    // Handle image upload
                    final temp = await pickImage();

                    setState(() {
                      selectedImage = temp;
                    });
                  },
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: const Color(0xffF3F3F3),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: selectedImage != null
                        ? Image.file(
                            selectedImage!,
                            fit: BoxFit.cover,
                          )
                        : const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.image,
                                  size: 50,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'upload image',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                  ),
                ),
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
                          if (selectedImage == null ||
                              nameController.text == '' ||
                              descriptionController.text == '') {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Please Provide Required Fields')));
                          } else {
                            final Product addedProduct = Product(
                                productid: '',
                                name: nameController.text,
                                description: descriptionController.text,
                                price: priceController.text,
                                imageUrl: selectedImage!.path);

                            final productBloc =
                                BlocProvider.of<ProductBloc>(context);

                            productBloc.add(CreateProductEvent(addedProduct));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff3F51F3),
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            fixedSize: const Size(300, 30),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8))),
                        child: const Text(
                          'ADD',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: Colors.white),
                        ));
                  },
                  listener: (BuildContext context, ProductBlocState state) {
                    if (state is LoadingState) {
                      const Center(child: CircularProgressIndicator());
                    } else if (state is SuccesfulCreate) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content:
                              Text('You have succesfully added your product')));
                      context.read<ProductBloc>().add(LoadAllProductEvent());
                      Navigator.pop(context);
                    } else if (state is ErrorState) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(state.message)));
                      context.read<ProductBloc>().add(LoadAllProductEvent());
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        fixedSize: const Size(300, 30),
                        side: const BorderSide(color: Colors.red),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    child: const Text(
                      'DELETE',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          color: Colors.red),
                    )),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ));
  }
}

Future<File?> pickImage() async {
  final ImagePicker picker = ImagePicker();
  final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    return File(pickedFile.path);
  } else {
    return null;
  }
}

bool validatePrice(String value) {
  final int? price = int.tryParse(value);
  if (price == null) {
    return false;
  }
  return true;
}
