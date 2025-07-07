import 'package:cloud_firestore/cloud_firestore.dart';

import '../../app/extensions.dart';
import '../../domain/entities/auth_entity.dart';
import '../../domain/entities/group_entity.dart';
import '../../domain/entities/history_entity.dart';
import '../../domain/entities/permission_entity.dart';
import '../responses/group_response.dart';
import '../responses/history_response.dart';
import '../responses/permission_response.dart';
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

extension HistoryResponseMapper on HistoryResponse? {
  HistoryEntity toDomain() {
    return HistoryEntity(
      id: this!.id.orEmpty(),
      userId: this!.userId.orEmpty(),
      groupId: this!.groupId.orEmpty(),
      checkIn: this!.checkIn ?? null,
      checkOut: this!.checkOut ?? null,
    );
  }
}

extension PermissionResponseMapper on PermissionResponse? {
  PermissionEntity toDomain() {
    return PermissionEntity(
      id: this!.id.orEmpty(),
      userId: this!.userId.orEmpty(),
      groupId: this!.groupId.orEmpty(),
      date: this!.date ?? DateTime.now(),
      type: this!.type.getPermissionType(),
      message: this!.message.orEmpty(),
    );
  }
}
