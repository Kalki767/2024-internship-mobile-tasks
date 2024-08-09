import 'package:flutter/material.dart';

import 'custom_text.dart';

class Cards extends StatelessWidget {
  const Cards({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.asset(
                'assets/shoes.jpg',
                fit: BoxFit.cover,
              )),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomText(text: 'Derby Leather Shoes'),
                Spacer(),
                CustomText(
                  text: '\$120',
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ],
            ),
          ),
          const Padding(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomText(
                      text: "Men's Shoes",
                      fontSize: 12,
                    ),
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
                    CustomText(
                      text: '(4.0)',
                      fontFamily: 'Sora',
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  ]))
        ],
      ),
    );
  }
}
