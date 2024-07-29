import 'dart:io';
import 'product.dart';

// Class to manage products
class ProductManager {
  final List<Product> _products = [];

  // Method to add a product
  void addProduct(Product product) {
    for (var pro in _products) {
      if (pro.name == product.name) {
        print('Product with the same name already exists in this category.');
        stdout.write(
            'Do you want to (1) Edit the product or (2) View the product? (Enter any other key to cancel): ');
        final choice = stdin.readLineSync();
        if (choice == '1') {
          editProduct(product.name,
              newName: product.name,
              newDescription: product.description,
              newPrice: product.price,
              newCategory: product.category,
              newStockQuantity: product.stockQuantity);
        } else if (choice == '2') {
          print(product);
        } else {
          print('Operation cancelled.');
        }
        return;
      }
    }
    _products.add(product);
    print('Product added successfully.');
  }

  // Method to view all products
  void viewAllProducts() {
    if (_products.isEmpty) {
      print('No products available.');
    } else {
      for (var product in _products) {
        print(product);
      }
      print('====================\n');
    }
  }

  // Method to view a single product by name
  void viewProduct(String name) {
    for (var product in _products) {
      if (product.name == name) {
        print(product);
        return;
      }
    }
    print('Product not found.');
  }

  // Method to edit a product
  void editProduct(String name,
      {String? newName,
      String? newDescription,
      double? newPrice,
      String? newCategory,
      int? newStockQuantity}) {
    for (var product in _products) {
      if (product.name == name) {
        if (newName != null) product.name = newName;
        if (newDescription != null) product.description = newDescription;
        if (newPrice != null) product.price = newPrice;
        if (newCategory != null) product.category = newCategory;
        if (newStockQuantity != null) product.stockQuantity = newStockQuantity;
        print('Product updated successfully.');
        return;
      }
    }
    print('Product not found.');
  }

  // Method to delete a product
  void deleteProduct(String name) {
    for (var product in _products) {
      if (product.name == name) {
        _products.remove(product);
        print('Product deleted successfully.');
        return;
      }
    }
    print('Product not found.');
  }
}
