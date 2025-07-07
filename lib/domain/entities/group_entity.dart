import 'package:cloud_firestore/cloud_firestore.dart';

class GroupEntity {
  final String id;
  final String name;
  final String password;
  final String salt;
  final DateTime checkIn;
  final DateTime checkOut;
  final List<int>? days;
  final GeoPoint location;

  GroupEntity({
    required this.id,
    required this.name,
    required this.password,
    required this.salt,
    required this.checkIn,
    required this.checkOut,
    required this.days,
    required this.location,
  });
}
