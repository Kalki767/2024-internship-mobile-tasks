import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
            // Handle back button press
          },
        ),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Add Product",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Poppins",
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
                onTap: () {
                  // Handle image upload
                },
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Color(0xffF3F3F3),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Center(
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
                    "name",
                    style: TextStyle(color: Color(0xff3E3E3E)),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const TextField(
                decoration: InputDecoration(
                  fillColor: Color(0xffF3F3F3),
                  focusColor: Color(0xffF3F3F3),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "category",
                    style: TextStyle(color: Color(0xff3E3E3E)),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "price",
                    style: TextStyle(color: Color(0xff3E3E3E)),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(16.0),
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
                    "description",
                    style: TextStyle(color: Color(0xff3E3E3E)),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff3F51F3),
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      fixedSize: const Size(300, 30),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                  child: const Text(
                    "ADD",
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14,
                        color: Colors.white),
                  )),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      fixedSize: Size(300, 30),
                      side: BorderSide(color: Colors.red),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                  child: Text(
                    "DELETE",
                    style: TextStyle(
                        fontFamily: "Poppins", fontSize: 14, color: Colors.red),
                  )),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
