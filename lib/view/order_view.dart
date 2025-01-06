import 'dart:io';

import '../controller/order_controller.dart';
import '../model/order.dart';

class OrderView {
  final OrderController _controller;

  OrderView(this._controller);

  // This function simulates user input by prompting the user for product names and quantities
  Future<void> createOrderView() async {
    print('Creating Order...');

    // Ask user for products and quantities
    List<Map<String, dynamic>> items = [];
    bool addingItems = true;

    while (addingItems) {
      print('Enter product name:');
      String productName = stdin.readLineSync()!;

      // Check if the product exists in the database
      final product = await _controller.getProductByName(productName);
      if (product == null) {
        print('Product not found. Please try again.');
        continue;
      }

      print('Enter quantity for $productName:');
      int quantity = int.parse(stdin.readLineSync()!);

      // Add product and quantity to the order items list
      items.add({
        'product_name': product['product_name'],
        'price_per_unit': product['price'],
        'quantity': quantity,
      });

      print('Do you want to add another item? (y/n)');
      String? response = stdin.readLineSync();
      if (response?.toLowerCase() != 'y') {
        addingItems = false;
      }
    }

    // Create the order and display the bill
    final order = Order(
      items: items,
      orderDate: DateTime.now(),
    );
    _controller.showBill(order);
    await _controller.createOrder(items); // Only create the order (no bill)
  }
}
