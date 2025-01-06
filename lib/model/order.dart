class Order {
  final DateTime orderDate;
  final List<Map<String, dynamic>> items;
  late final double totalAmount;

  Order({required this.orderDate, required this.items}) {
    totalAmount = _calculateTotalAmount();
  }

  double _calculateTotalAmount() {
    double total = 0.0;
    for (var item in items) {
      total += item['quantity'] * item['price_per_unit'];
    }
    return total;
  }
}
