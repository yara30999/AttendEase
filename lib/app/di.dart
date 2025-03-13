import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/data_source/local_data_source.dart';
import '../data/data_source/remote_data_source.dart';
import '../data/network/network_info.dart';
import '../data/repository/repository_impl.dart';
import '../domain/repository/repository.dart';
import '../domain/usecase/create_group_usecase.dart';
import '../domain/usecase/current_user_group_id_stream.dart';
import '../domain/usecase/current_user_join_group_usecase.dart';
import '../domain/usecase/delete_group_usecase.dart';
import '../domain/usecase/delete_user_from_group_usecase.dart';
import '../domain/usecase/forgot_password_usecase.dart';
import '../domain/usecase/get_group_info_usecase.dart';
import '../domain/usecase/get_group_members_usecase.dart';
import '../domain/usecase/get_user_history_usecase.dart';
import '../domain/usecase/get_user_permissions_usecase.dart';
import '../domain/usecase/groups_stream_usecase.dart';
import '../domain/usecase/login_usecase.dart';
import '../domain/usecase/logout_usecase.dart';
import '../domain/usecase/group_members_stream_usecase.dart';
import '../domain/usecase/register_usecase.dart';
import 'app_prefs.dart';
import 'geolocation_service.dart';
import 'validation_service.dart';

final instance = GetIt.instance;
Future<void> initAppModule() async {
  // shared prefs instance
  final sharedPrefs = await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
  // app prefs instance
  instance.registerLazySingleton<AppPreferences>(
    () => AppPreferencesImpl(instance()),
  );
  // validation service instance for all text form fields in the app
  instance.registerLazySingleton<IValidationService>(
    () => ValidationServiceImpl(),
  );
  // geolocation service instance for all geo usage in the app
  instance.registerLazySingleton<IGeolocationService>(
    () => GeolocationServiceImpl(),
  );
  // network info
  instance.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(InternetConnectionChecker.instance),
  );
  // remote data source
  final firebaseInstance = FirebaseAuth.instance;
  instance.registerLazySingleton<FirebaseAuth>(() => firebaseInstance);
  instance.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(instance<FirebaseAuth>()),
  );
  // local data source
  instance.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());
  // repository
  instance.registerLazySingleton<Repository>(
    () => RepositoryImpl(instance(), instance(), instance(), instance()),
  );
  // login usecase
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
  }
  // register usecase
  if (!GetIt.I.isRegistered<RegisterUsecase>()) {
    instance.registerFactory<RegisterUsecase>(
      () => RegisterUsecase(instance()),
    );
  }
  // forgot password usecase
  if (!GetIt.I.isRegistered<ForgotPasswordUsecase>()) {
    instance.registerFactory<ForgotPasswordUsecase>(
      () => ForgotPasswordUsecase(instance()),
    );
  }
  // logout usecase
  if (!GetIt.I.isRegistered<LogoutUsecase>()) {
    instance.registerFactory<LogoutUsecase>(() => LogoutUsecase(instance()));
  }
  // create group usecase
  if (!GetIt.I.isRegistered<CreateGroupUsecase>()) {
    instance.registerFactory<CreateGroupUsecase>(
      () => CreateGroupUsecase(instance()),
    );
  }
  // groups stream usecase
  if (!GetIt.I.isRegistered<GroupsStreamUsecase>()) {
    instance.registerFactory<GroupsStreamUsecase>(
      () => GroupsStreamUsecase(instance()),
    );
  }
  // current user group-id stream usecase
  if (!GetIt.I.isRegistered<CurrentUserGroupIdStream>()) {
    instance.registerFactory<CurrentUserGroupIdStream>(
      () => CurrentUserGroupIdStream(instance()),
    );
  }
  // group members stream usecase
  if (!GetIt.I.isRegistered<GroupMembersStreamUsecase>()) {
    instance.registerFactory<GroupMembersStreamUsecase>(
      () => GroupMembersStreamUsecase(instance()),
    );
  }
  // get group info usecase
  if (!GetIt.I.isRegistered<GetGroupInfoUsecase>()) {
    instance.registerFactory<GetGroupInfoUsecase>(
      () => GetGroupInfoUsecase(instance()),
    );
  }
  // get group members usecase
  if (!GetIt.I.isRegistered<GetGroupMembersUsecase>()) {
    instance.registerFactory<GetGroupMembersUsecase>(
      () => GetGroupMembersUsecase(instance()),
    );
  }
  // get user history usecase
  if (!GetIt.I.isRegistered<GetUserHistoryUsecase>()) {
    instance.registerFactory<GetUserHistoryUsecase>(
      () => GetUserHistoryUsecase(instance()),
    );
  }
  // get user permissions usecase
  if (!GetIt.I.isRegistered<GetUserPermissionsUsecase>()) {
    instance.registerFactory<GetUserPermissionsUsecase>(
      () => GetUserPermissionsUsecase(instance()),
    );
  }
  // delete user from group usecase
  if (!GetIt.I.isRegistered<DeleteUserFromGroupUsecase>()) {
    instance.registerFactory<DeleteUserFromGroupUsecase>(
      () => DeleteUserFromGroupUsecase(instance()),
    );
  }
  // delete group usecase
  if (!GetIt.I.isRegistered<DeleteGroupUsecase>()) {
    instance.registerFactory<DeleteGroupUsecase>(
      () => DeleteGroupUsecase(instance()),
    );
  }
  // current user join group usecase
  if (!GetIt.I.isRegistered<CurrentUserJoinGroupUsecase>()) {
    instance.registerFactory<CurrentUserJoinGroupUsecase>(
      () => CurrentUserJoinGroupUsecase(instance()),
    );
  }
}
