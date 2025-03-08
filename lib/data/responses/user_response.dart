import 'package:cloud_firestore/cloud_firestore.dart';

class UserResponse {
  final String? id;
  final String? name;
  final String? email;
  final String? role;
  final String? groupId;

  UserResponse({this.id, this.name, this.email, this.role, this.groupId});

  factory UserResponse.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return UserResponse(
      id: snapshot.id,
      name: data?['name'],
      email: data?['email'],
      role: data?['role'],
      groupId: data?['groupId'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (email != null) "email": email,
      "role": role,
      "groupId": groupId,
    };
  }
}
