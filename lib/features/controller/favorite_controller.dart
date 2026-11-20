import 'package:get/get.dart';

class FavoriteItem {
  final String id;
  final String title;
  final String category;
  final String price;
  final String imageUrl;
  final String selectedOptions;

  FavoriteItem({
    required this.id,
    required this.title,
    required this.category,
    required this.price,
    required this.imageUrl,
    required this.selectedOptions,
  });
}

class FavoriteController extends GetxController {
  static FavoriteController get instance => Get.find();

  RxList<FavoriteItem> favoriteItems = <FavoriteItem>[].obs;

  bool isFavorite(String id) {
    return favoriteItems.any((item) => item.id == id);
  }

  void toggleFavorite(FavoriteItem item) {
    if (isFavorite(item.id)) {
      favoriteItems.removeWhere((i) => i.id == item.id);
      Get.snackbar(
        'Removed',
        '${item.title} removed from favorites',
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      favoriteItems.add(item);
      Get.snackbar(
        'Added',
        '${item.title} (${item.selectedOptions}) added to favorites!',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
