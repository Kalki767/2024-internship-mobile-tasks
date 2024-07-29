import 'dart:io';

import 'product.dart';

import 'product_manager.dart';

void main() {
  final productManager = ProductManager();

  while (true) {
    print('1. Add Product');
    print('2. View All Products');
    print('3. View Product');
    print('4. Edit Product');
    print('5. Delete Product');
    print('6. Exit');
    stdout.write('Choose an option: ');
    final choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        // Add a new product
        stdout.write('Enter product name: ');
        final name = stdin.readLineSync();
        stdout.write('Enter product description: ');
        final description = stdin.readLineSync();
        stdout.write('Enter product price: ');
        final price = double.tryParse(stdin.readLineSync() ?? '0') ?? 0;
        stdout.write('Enter product category: ');
        final category = stdin.readLineSync();
        stdout.write('Enter product stock quantity: ');
        final stockQuantity = int.tryParse(stdin.readLineSync() ?? '0') ?? 0;
        productManager.addProduct(
            Product(name!, description!, price, category!, stockQuantity));
        break;

      case '2':
        // View all products
        productManager.viewAllProducts();
        break;

      case '3':
        // View a single product by name
        stdout.write('Enter product name to view: ');
        final name = stdin.readLineSync();
        productManager.viewProduct(name!);
        break;

      case '4':
        // Edit a product
        stdout.write('Enter product name to edit: ');
        final name = stdin.readLineSync();
        stdout.write('Enter new product name (leave empty to keep current): ');
        final newName = stdin.readLineSync();
        stdout.write(
            'Enter new product description (leave empty to keep current): ');
        final newDescription = stdin.readLineSync();
        stdout.write('Enter new product price (leave empty to keep current): ');
        final newPrice = double.tryParse(stdin.readLineSync() ?? '0');
        stdout.write(
            'Enter new product category (leave empty to keep current): ');
        final newCategory = stdin.readLineSync();
        stdout.write(
            'Enter new product stock quantity (leave empty to keep current): ');
        final newStockQuantity = int.tryParse(stdin.readLineSync() ?? '0');
        productManager.editProduct(
          name!,
          newName: newName?.isEmpty ?? true ? null : newName,
          newDescription:
              newDescription?.isEmpty ?? true ? null : newDescription,
          newPrice: newPrice == 0 ? null : newPrice,
          newCategory: newCategory?.isEmpty ?? true ? null : newCategory,
          newStockQuantity: newStockQuantity == 0 ? null : newStockQuantity,
        );
        break;

      case '5':
        // Delete a product
        stdout.write('Enter product name to delete: ');
        final name = stdin.readLineSync();
        productManager.deleteProduct(name!);
        break;

      case '6':
        // Exit the application
        return;
      default:
        print('Invalid option. Please try again.');
    }
  }
}
