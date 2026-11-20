import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:food_court/utilies/repository/authentication_repository.dart';
import 'package:food_court/utilies/firebase_auth_exceptions.dart';
import 'package:food_court/utilies/userModel.dart';
import 'package:get/get.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection("users").doc(user.id).set(user.toJson());
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<UserModel> fetchUserDetails() async {
    try {
      final currentUid = FirebaseAuth.instance.currentUser?.uid;

      if (currentUid == null || currentUid.isEmpty) {
        if (kDebugMode) print("DEBUG FIRESTORE: Current Auth User UID is NULL");
        return UserModel.empty();
      }

      if (kDebugMode)
        print("DEBUG FIRESTORE: Fetching document for UID -> $currentUid");

      final documentSnapshot = await _db
          .collection("users")
          .doc(currentUid)
          .get();

      if (documentSnapshot.exists && documentSnapshot.data() != null) {
        if (kDebugMode)
          print("DEBUG FIRESTORE Data Found: ${documentSnapshot.data()}");
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        if (kDebugMode)
          print(
            "DEBUG FIRESTORE: Document does not exist for UID $currentUid in 'users' collection.",
          );
        return UserModel.empty();
      }
    } catch (e) {
      if (kDebugMode) print("DEBUG FIRESTORE ERROR: $e");
      return UserModel.empty();
    }
  }

  Future<void> updateUserDetails(UserModel updatedUser) async {
    try {
      await _db
          .collection("users")
          .doc(updatedUser.id)
          .update(updatedUser.toJson());
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db
          .collection("users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .update(json);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void> removeUserRecord(String userId) async {
    try {
      await _db.collection("users").doc(userId).delete();
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
