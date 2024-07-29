import 'dart:io';

// Class representing a product
class Product {
  String name;
  String description;
  double price;
  String category;
  int stockQuantity;

  // Constructor to initialize the product
  Product(this.name, this.description, this.price, this.category,
      this.stockQuantity);

  // Overriding toString method to display product information
  @override
  String toString() {
    return '''
Name           : $name
Description    : $description
Price          : \$${price.toStringAsFixed(2)}
Category       : $category
Stock Quantity : $stockQuantity
--------------------------
''';
  }
}
