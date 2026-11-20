import 'package:get/get.dart';

class OrderModel {
  final String orderId;
  final String date;
  final String status;
  final double totalPrice;
  final int totalCalories;
  final List<dynamic> items;

  OrderModel({
    required this.orderId,
    required this.date,
    required this.status,
    required this.totalPrice,
    required this.totalCalories,
    required this.items,
  });
}

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  RxList<OrderModel> liveOrders = <OrderModel>[].obs;

  double get totalSpent =>
      liveOrders.fold(0, (sum, order) => sum + order.totalPrice);

  void placeOrder(OrderModel order) {
    liveOrders.insert(0, order);
  }
}
