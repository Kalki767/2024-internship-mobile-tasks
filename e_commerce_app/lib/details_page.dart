import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<DetailsPage> {
  int selected = 0;
  @override
  Widget build(BuildContext context) {
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
                child: Image.asset(
                  'assets/shoes.jpg',
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
                  const Row(
                    children: [
                      SizedBox(
                        height: 60,
                      ),
                      Text('Derby Leather ',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins')),
                      Spacer(),
                      Text(
                        '\$120',
                        style: TextStyle(
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
                  const Text(
                      'A derby leather shoe is a classic and versatile footwear option characterized by its open lacing system, where the shoelace eyelets are sewn on top of the vamp (the upper part of the shoe). This design feature provides a more relaxed and casual look compared to the closed lacing system of oxford shoes. Derby shoes are typically made of high-quality leather, known for its durability and elegance, making them suitable for both formal and casual occasions. With their timeless style and comfortable fit, derby leather shoes are a staple in any well-rounded wardrobe.',
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff666666),
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500)),
                  const SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(120, 50),
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  side: const BorderSide(color: Colors.red))),
                          clipBehavior: Clip.antiAlias,
                          onPressed: () {},
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
                                  borderRadius: BorderRadius.circular(8.0))),
                          clipBehavior: Clip.antiAlias,
                          onPressed: () {},
                          child: const Text(
                            'Update',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
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
