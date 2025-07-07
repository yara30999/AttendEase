import 'package:cloud_firestore/cloud_firestore.dart';

class GroupResponse {
  final String? id;
  final String? name;
  final String? hashedPassword;
  final String? salt;
  final DateTime? checkIn;
  final DateTime? checkOut;
  final List<int>? days;
  final GeoPoint? location;

  GroupResponse({
    this.id,
    this.name,
    this.hashedPassword,
    this.salt,
    this.checkIn,
    this.checkOut,
    this.days,
    this.location,
  });

  factory GroupResponse.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return GroupResponse(
      id: snapshot.id,
      name: data?['name'],
      hashedPassword: data?['password'],
      salt: data?['salt'],
      checkIn: (data?['check-in'] as Timestamp?)?.toDate(),
      checkOut: (data?['check-out'] as Timestamp?)?.toDate(),
      days: (data?['days'] as List<dynamic>?)?.map((e) => e as int).toList(),
      location: data?['location'] as GeoPoint?,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      "password": hashedPassword,
      "salt": salt,
      "check-in": Timestamp.fromDate(checkIn!),
      "check-out": Timestamp.fromDate(checkOut!),
      "days": days,
      "location": location,
    };
  }
}
