import 'package:cloud_firestore/cloud_firestore.dart';

import '../../app/extensions.dart';
import '../../domain/entities/auth_entity.dart';
import '../../domain/entities/group_entity.dart';
import '../responses/group_response.dart';
import '../responses/user_response.dart';

extension UserResponseMapper on UserResponse? {
  AuthenticationEntity toDomain() {
    return AuthenticationEntity(
      id: this!.id.orEmpty(),
      name: this!.name.orEmpty(),
      email: this!.email.orEmpty(),
      role: this!.role.orEmpty(),
    );
  }
}

extension GroupResponseMapper on GroupResponse? {
  GroupEntity toDomain() {
    return GroupEntity(
      id: this!.id.orEmpty(),
      name: this!.name.orEmpty(),
      days: this!.days ?? [],
      checkIn: this!.checkIn ?? DateTime.now(),
      checkOut: this!.checkOut ?? DateTime.now(),
      password: this!.password.orEmpty(),
      location: this!.location ?? GeoPoint(0, 0),
    );
  }
}
