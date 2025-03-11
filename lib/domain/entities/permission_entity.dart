import '../../app/extensions.dart';

class PermissionEntity {
  final String id;
  final String userId;
  final String groupId;
  final DateTime date;
  final PermissionType type;
  final String? message;

  PermissionEntity({
    required this.id,
    required this.userId,
    required this.groupId,
    required this.date,
    required this.type,
    required this.message,
  });
}
