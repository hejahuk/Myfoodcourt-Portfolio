import 'package:get/get.dart';

class CartItem {
  final String id;
  final String title;
  final String imageUrl;
  final double unitPrice;
  int quantity;
  final String selectedOptions;
  final int calories; 

  CartItem({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.unitPrice,
    required this.quantity,
    required this.selectedOptions,
    required this.calories, 
  });
}


class CartController extends GetxController {
  static CartController get instance => Get.find();

  
  RxList<CartItem> cartItems = <CartItem>[].obs;

  
  double get totalCartPrice => cartItems.fold(0, (sum, item) => sum + (item.unitPrice * item.quantity));

  
  void addToCart(CartItem item) {
    cartItems.add(item);
    Get.snackbar('Success', '${item.title} added to cart!', snackPosition: SnackPosition.BOTTOM);
  }

  
  void addOne(int index) {
    cartItems[index].quantity++;
    cartItems.refresh(); 
  }

  
  void removeOne(int index) {
    if (cartItems[index].quantity > 1) {
      cartItems[index].quantity--;
    } else {
      cartItems.removeAt(index);
    }
    cartItems.refresh();
  }
}