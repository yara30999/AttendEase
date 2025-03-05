import 'package:cloud_firestore/cloud_firestore.dart';

class UserResponse {
  final String? name;
  final String? email;
  final String? role;

  UserResponse({this.name, this.email, this.role});

  factory UserResponse.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return UserResponse(
      name: data?['name'],
      email: data?['email'],
      role: data?['role'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (email != null) "email": email,
      "role": role,
    };
  }
}
