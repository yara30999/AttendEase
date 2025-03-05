import '../../app/extensions.dart';
import '../../domain/entities/auth_entity.dart';
import '../responses/user_response.dart';

extension UserResponseMapper on UserResponse? {
  AuthenticationEntity toDomain() {
    return AuthenticationEntity(
      name: this!.name.orEmpty(),
      email: this!.email.orEmpty(),
      role: this!.role.orEmpty(),
    );
  }
}
