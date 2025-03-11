import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryResponse {
  final String? id;
  final String? userId;
  final String? groupId;
  final DateTime? checkIn;
  final DateTime? checkOut;

  HistoryResponse({
    this.id,
    this.userId,
    this.groupId,
    this.checkIn,
    this.checkOut,
  });

  factory HistoryResponse.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return HistoryResponse(
      id: snapshot.id,
      userId: data?['userId'],
      groupId: data?['groupId'],
      checkIn: (data?['check-in'] as Timestamp?)?.toDate(), //can be null
      checkOut: (data?['check-out'] as Timestamp?)?.toDate(), //can be null
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (userId != null) "userId": userId,
      if (groupId != null) "groupId": groupId,
      "check-in":
          checkOut != null
              ? Timestamp.fromDate(checkIn!)
              : null, // Always included, even if null
      "check-out":
          checkOut != null
              ? Timestamp.fromDate(checkOut!)
              : null, // Always included, even if null
    };
  }
}
