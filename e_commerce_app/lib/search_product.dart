import 'package:flutter/material.dart';

class SearchProduct extends StatefulWidget {
  const SearchProduct({super.key});

  @override
  State<SearchProduct> createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  RangeValues _priceRange = const RangeValues(20, 80);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Search Product",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: "Poppins",
                color: Color(0xff3E3E3E),
              ),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: TextField(
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
                  icon: const Icon(Icons.filter_alt_sharp, color: Colors.blue),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        RangeValues _tempPriceRange = _priceRange;
                        return StatefulBuilder(
                          builder:
                              (BuildContext context, StateSetter setState) {
                            return Padding(
                              padding: const EdgeInsets.all(32.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const TextField(
                                    decoration: InputDecoration(
                                      labelText: 'Category',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  const Text(
                                    "Price",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  RangeSlider(
                                    values: _tempPriceRange,
                                    min: 0,
                                    max: 100,
                                    divisions: 10,
                                    activeColor: Colors.blue,
                                    inactiveColor: Colors.grey,
                                    onChanged: (RangeValues values) {
                                      setState(() {
                                        _tempPriceRange = values;
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        _priceRange = _tempPriceRange;
                                      });
                                      Navigator.of(context).pop();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: const Size(double.infinity,
                                          48), // Make button full width
                                      backgroundColor: const Color(0xff3F51F3),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            8), // Background color
                                      ),
                                    ),
                                    child: const Text(
                                      "APPLY",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xffFFFFFF)),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/shoes.jpg",
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 20),
                        const Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    height: 60,
                                  ),
                                  Text("Derby Leather",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500)),
                                  Spacer(),
                                  Text(
                                    '\$120',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text("Men's Shoes",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400)),
                                  Spacer(),
                                  Icon(
                                    Icons.star,
                                    size: 20,
                                    color: Colors.yellow,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '(4.0)',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
