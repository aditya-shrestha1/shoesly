class OrderModel {
  final String productName;
  final String brandName;
  final String color;
  final String size;
  final double price;
  final int quantity;

  OrderModel({
    required this.productName,
    required this.brandName,
    required this.color,
    required this.size,
    required this.price,
    required this.quantity,
  });

  Map<String, dynamic> toMap(OrderModel orderModel) {
    return {
      'productName': orderModel.productName,
      'brandName': orderModel.brandName,
      'color': orderModel.color,
      'size': orderModel.size,
      'price': orderModel.price,
      'quantity': orderModel.quantity,
    };
  }
}
