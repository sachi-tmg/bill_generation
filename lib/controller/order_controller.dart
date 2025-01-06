import '../db/mongo_db_service.dart';
import '../model/order.dart';

class OrderController {
  final MongoDbService _mongoDbService;

  OrderController(this._mongoDbService);

  // Create an Order (Only order quantity increases, not product entries)
  Future<void> createOrder(List<Map<String, dynamic>> items) async {
    final order = Order(
      items: items,
      orderDate: DateTime.now(),
    );
    await _mongoDbService.insertOrder(order); // Only insert order
    print('Order created. Total Bill: \$${order.totalAmount}');
  }

  // Get Product by Name (for placing an order)
  Future<Map<String, dynamic>?> getProductByName(String name) async {
    return await _mongoDbService.getProductByName(name);
  }

  // Display the Bill (for the order)
  void showBill(Order order) {
    print('\n--- BILL ---');
    print('Order Date: ${order.orderDate}');
    print('Items Purchased:');
    for (var item in order.items) {
      final totalItemPrice = item['quantity'] * item['price_per_unit'];
      print(
          '${item['product_name']} - ${item['quantity']} x \$${item['price_per_unit']} = \$$totalItemPrice');
    }
    print('\nTotal Bill: \$${order.totalAmount}');
    print('---------------\n');
    print('---Thank you!!!---\n');
  }
}
