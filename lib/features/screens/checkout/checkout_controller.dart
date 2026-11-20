import 'dart:math';
import 'package:get/get.dart';
import 'package:food_court/features/controller/cart_controller.dart';

class CheckoutController extends GetxController {
  static CheckoutController get instance => Get.find();

  final cart = CartController.instance;

  var selectedPayment = 'PayNow'.obs;
  var isEcoFriendly = true.obs;
  var splitCount = 1.obs;

  final int prepTime = 10 + Random().nextInt(11);

  double get subtotal => cart.totalCartPrice;
  double get serviceFee => 0.50;
  double get gst => subtotal * 0.09;
  double get total => subtotal + serviceFee + gst;
  double get splitAmount => total / splitCount.value;

  int get totalCalories => cart.cartItems.fold(
    0,
    (sum, item) => sum + (item.calories * item.quantity),
  );

  void incrementSplit() => splitCount.value++;

  void decrementSplit() {
    if (splitCount.value > 1) splitCount.value--;
  }
}
