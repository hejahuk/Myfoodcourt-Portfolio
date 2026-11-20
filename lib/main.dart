import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:food_court/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:food_court/features/controller/cart_controller.dart';
import 'package:food_court/features/controller/favorite_controller.dart';
import 'package:food_court/features/controller/order_control.dart';
import 'package:food_court/utilies/repository/authentication_repository.dart';
import 'package:food_court/features/controller/user_controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get_storage/get_storage.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((FirebaseApp value) => Get.put(AuthenticationRepository()));

  Get.put(UserController());
  Get.put(CartController());
  Get.put(OrderController());
  Get.put(FavoriteController());

  runApp(const App());
}

class MyScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}
