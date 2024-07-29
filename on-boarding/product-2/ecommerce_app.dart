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
