import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/product.dart';
import '../bloc/product_bloc.dart';

class DetailsPage extends StatefulWidget {
  DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => DetailsPageState();
}

class DetailsPageState extends State<DetailsPage> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Product;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(10)),
                child: Image.network(
                  args.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 10),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                  ),
                  onPressed: () {
                    context.read<ProductBloc>().add(LoadAllProductEvent());
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ]),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Men's Shoes",
                            style: TextStyle(fontSize: 16, color: Colors.grey)),
                        Spacer(),
                        Icon(
                          Icons.star,
                          size: 24,
                          color: Colors.yellow,
                          weight: 4,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '(4.0)',
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 14),
                        ),
                      ]),
                  Row(
                    children: [
                      const SizedBox(
                        height: 60,
                      ),
                      Text(args.name,
                          style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins')),
                      const Spacer(),
                      Text(
                        '\$${args.price}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ],
                  ),
                  const Row(
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        'Size:',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins'),
                      )
                    ],
                  ),
                  // Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [],)

                  SizedBox(
                    height: 60,
                    child: ListView.builder(
                      itemCount: 10,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selected = index;
                            });
                          },
                          child: Card(
                            color: selected == index
                                ? const Color(0xff3F51F3)
                                : Colors.white,
                            child: Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  '${index + 39}',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: selected == index
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(args.description,
                      style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xff666666),
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500)),
                  const SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: BlocConsumer<ProductBloc, ProductBlocState>(
                      builder: (context, state) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(120, 50),
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      side:
                                          const BorderSide(color: Colors.red))),
                              clipBehavior: Clip.antiAlias,
                              onPressed: () {
                                final productBloc =
                                    BlocProvider.of<ProductBloc>(context);

                                productBloc
                                    .add(DeleteProductEvent(args.productid));
                              },
                              child: const Text(
                                'Delete',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(120, 50),
                                  backgroundColor: const Color(0xff3F51F3),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(8.0))),
                              clipBehavior: Clip.antiAlias,
                              onPressed: () {
                                Navigator.pushNamed(context, '/update_page',
                                    arguments: args.productid);
                              },
                              child: const Text(
                                'Update',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                        );
                      },
                      listener: (BuildContext context, ProductBlocState state) {
                        if (state is LoadingState) {
                          const CircularProgressIndicator();
                        }
                        if (state is SuccessfulDelete) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text(
                                  'You have succesfully deleted your product')));
                          context
                              .read<ProductBloc>()
                              .add(LoadAllProductEvent());
                          Navigator.pop(context);
                        } else if (state is ErrorState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.message)));
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
