import 'package:hive/hive.dart';
part 'auth_entity.g.dart';

@HiveType(typeId: 0)
class AuthenticationEntity {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String role;
  @HiveField(3)
  final String id;

  const AuthenticationEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });
}
