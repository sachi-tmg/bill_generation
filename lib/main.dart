import 'controller/order_controller.dart';
import 'db/mongo_db_service.dart';
import 'view/order_view.dart';

void main() async {
  // 1. Initialize MongoDB connection
  final mongoService = MongoDbService('mongodb://localhost:27017/shopping_db');
  await mongoService.connect();

  // 2. Initialize the controller and view
  final controller = OrderController(mongoService);
  final view = OrderView(controller);

  // 3. Ask user to create an order
  await view.createOrderView();

  // 4. Close MongoDB connection after everything is done
  await mongoService.close();
}
