import 'dart:io';

import 'db/mongo_db_service.dart';

void main() async {
  // Initialize MongoDB service and connect
  final mongoService = MongoDbService('mongodb://localhost:27017/shopping_db');
  await mongoService.connect();

  // Prompt user for product details and insert them into the database
  print('Enter product name:');
  String productName = stdin.readLineSync()!;

  print('Enter product price:');
  double price = double.parse(stdin.readLineSync()!);

  // Insert the product into the database
  await mongoService.insertProduct(productName, price);

  // Close the MongoDB connection
  await mongoService.close();
}
