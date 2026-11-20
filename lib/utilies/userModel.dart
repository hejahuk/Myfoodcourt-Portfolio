import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  String firstName;
  String lastName;
  final String username;
  final String email;
  String phoneNumber;
  String profilePicture;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
  });

  String get fullName => '$firstName $lastName';

  static UserModel empty() => UserModel(
    id: '',
    firstName: '',
    lastName: '',
    username: '',
    email: '',
    phoneNumber: '',
    profilePicture: '',
  );

  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'Username': username,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'ProfilePicture': profilePicture,
    };
  }

  factory UserModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,

        firstName:
            data['FirstName'] ?? data['firstName'] ?? data['first_name'] ?? '',
        lastName:
            data['LastName'] ?? data['lastName'] ?? data['last_name'] ?? '',
        username:
            data['Username'] ?? data['username'] ?? data['user_name'] ?? '',
        email: data['Email'] ?? data['email'] ?? '',
        phoneNumber:
            data['PhoneNumber'] ??
            data['phoneNumber'] ??
            data['phone_number'] ??
            '',
        profilePicture:
            data['ProfilePicture'] ??
            data['profilePicture'] ??
            data['profile_picture'] ??
            '',
      );
    } else {
      return UserModel.empty();
    }
  }
}
