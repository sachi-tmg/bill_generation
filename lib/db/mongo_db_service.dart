import 'package:mongo_dart/mongo_dart.dart';

import '../model/order.dart';

class MongoDbService {
  final String uri;
  late Db _db;

  MongoDbService(this.uri);

  Future<void> connect() async {
    _db = await Db.create(uri);
    await _db.open();
    print('Connected to MongoDB!');
  }

  // Get Product by Name (for placing an order)
  Future<Map<String, dynamic>?> getProductByName(String name) async {
    final productsCollection = _db.collection('Products');
    final product = await productsCollection.findOne({'product_name': name});
    return product;
  }

  // Insert Order (Including all product details and total amount)
  Future<void> insertOrder(Order order) async {
    final ordersCollection = _db.collection('Orders');
    await ordersCollection.insertOne({
      'order_date': order.orderDate,
      'items': order.items,
      'total_amount': order.totalAmount,
    });
    print('Inserted order on: ${order.orderDate}');
  }

  // Insert the product into the database
  Future<void> insertProduct(String name, double price) async {
    final productsCollection = _db.collection('Products');

    await productsCollection.insertOne({
      'product_name': name,
      'price': price,
    });

    print('Inserted product: $name');
  }

  // Close MongoDB connection
  Future<void> close() async {
    await _db.close();
  }
}
