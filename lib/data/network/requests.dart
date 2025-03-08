import 'package:cloud_firestore/cloud_firestore.dart';

class LoginRequest {
  String email;
  String password;

  LoginRequest(this.email, this.password);
}

class RegisterRequest {
  String userName;
  String email;
  String password;
  String role;

  RegisterRequest(this.userName, this.email, this.password, this.role);
}

class CreateGroupRequest {
  final String name;
  final DateTime checkIn;
  final DateTime checkOut;
  final List<int> days;
  final GeoPoint location;

  CreateGroupRequest(
    this.name,
    this.checkIn,
    this.checkOut,
    this.days,
    this.location,
  );
}
