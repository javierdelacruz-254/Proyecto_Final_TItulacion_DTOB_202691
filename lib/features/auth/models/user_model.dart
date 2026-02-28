import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String uid;
  final String email;
  final String? fullname;
  final String? photo;

  UserModel({
    required this.uid,
    required this.email,
    this.fullname,
    this.photo,
  });

  factory UserModel.fromFirebase(User user) {
    return UserModel(
      uid: user.uid,
      email: user.email ?? '',
      fullname: user.displayName,
      photo: user.photoURL,
    );
  }

  Map<String, dynamic> toMap() {
    return {'uid': uid, 'email': email, 'fullname': fullname, 'photo': photo};
  }
}
