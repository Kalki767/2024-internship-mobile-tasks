import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal:
                  32), //to make the screen horizontally symmetrical from both ends
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
                            color: Color(0xffAAAAAA)),
                      ),
                      Row(children: [
                        Text(
                          'Hello, ',
                          style: TextStyle(
                              fontFamily: 'Sora',
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          'Yohannes',
                          style: TextStyle(
                              fontFamily: 'Sora',
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ]),
                    ],
                  ),
                  const Spacer(),
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
                        )),
                  )
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
                            fontWeight: FontWeight.bold, fontSize: 24),
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
                            child: IconButton(
                              icon: const Icon(
                                CupertinoIcons.search,
                                color: Colors.grey,
                                size: 20,
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, '/search');
                              },
                            ),
                          ))
                    ],
                  )),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/details');
                          },
                          child: Card(
                            child: Column(
                              children: [
                                ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(10)),
                                    child: Image.asset(
                                      'assets/shoes.jpg',
                                      fit: BoxFit.cover,
                                    )),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('Derby Leather Shoes',
                                          style: TextStyle(fontSize: 16)),
                                    ),
                                    Spacer(),
                                    Text(
                                      '\$120',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                  ],
                                ),
                                const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 16),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text("Men's Shoes",
                                              style: TextStyle(fontSize: 12)),
                                          Spacer(),
                                          Icon(
                                            Icons.star,
                                            size: 14,
                                            color: Colors.yellow,
                                            weight: 4,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            '(4.0)',
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 12),
                                          ),
                                        ]))
                              ],
                            ),
                          ),
                        );
                      }))
            ],
          ),
        )));
  }
}
