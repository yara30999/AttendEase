import 'package:cloud_firestore/cloud_firestore.dart';

class PermissionResponse {
  final String? id;
  final String? userId;
  final String? groupId;
  final DateTime? date;
  final String? type;
  final String? message;

  PermissionResponse({
    this.id,
    this.userId,
    this.groupId,
    this.date,
    this.type,
    this.message,
  });

  factory PermissionResponse.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return PermissionResponse(
      id: snapshot.id,
      userId: data?['userId'],
      groupId: data?['groupId'],
      date: (data?['date'] as Timestamp?)?.toDate(),
      type: data?['type'],
      message: data?['message'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (userId != null) "userId": userId,
      if (groupId != null) "groupId": groupId,
      "date": Timestamp.fromDate(date!), //can not be null
      "type": type,
      "message": message,
    };
  }
}
