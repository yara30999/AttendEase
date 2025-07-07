import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import '../domain/entities/auth_entity.dart';
import '../domain/entities/group_entity.dart';
import '../presentation/02_home_screens/view/widgets/admin/delete_group_dialog.dart';
import '../presentation/02_home_screens/view/widgets/user/bottom_sheets/join_group_bottom_sheet.dart';
import '../presentation/02_home_screens/view/widgets/user/bottom_sheets/take_permission_bottom_sheet.dart';
import '../presentation/02_home_screens/view_model/delete_group_cubit/delete_group_cubit.dart';
import '../presentation/02_home_screens/view_model/join_group_cubit/join_group_cubit.dart';
import '../presentation/02_home_screens/view_model/permission_cubit/permission_cubit.dart';
import '../presentation/02_home_screens/view_model/theme_bloc/theme_bloc.dart';
import '../presentation/04_group_details_screen/view/widgets/delete_user_dialog.dart';
import '../presentation/04_group_details_screen/view_model/delete_member_cubit/delete_member_from_group_cubit.dart';
import '../presentation/resourses/constant_manager.dart';

Future<void> hiveBoxes() async {
  await Hive.openBox<AuthenticationEntity>(AppConstants.kUserDataBox);
}

void hiveAdapters() {
  Hive.registerAdapter(AuthenticationEntityAdapter());
}

bool isLightTheme(BuildContext context) {
  return context.read<ThemeBloc>().state.themeMode == ThemeMode.light;
}

//hashing and salting functions (one way encryptiion), but i need to show
// the group password in the UI, so the admin can copy it and send it to his members
// asociated with that group only.
// so, i need to use encryption instead of hashing.
String generateSalt([int length = 16]) {
  final random = Random.secure();
  final values = List<int>.generate(length, (_) => random.nextInt(256));
  return base64Url.encode(values);
}

String hashPassword(String password, String salt) {
  final bytes = utf8.encode(password + salt);
  final digest = sha256.convert(bytes);
  return digest.toString();
}

String generateRandomPassword({int length = 8}) {
  const String chars =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#\$%^&*()-_=+';
  Random random = Random();
  return List.generate(
    length,
    (index) => chars[random.nextInt(chars.length)],
  ).join();
}

String generateRandomFirebaseDocId({int length = 20}) {
  const String chars =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  Random random = Random();
  return List.generate(
    length,
    (index) => chars[random.nextInt(chars.length)],
  ).join();
}

bool isWithinCheckInTime(GroupEntity groupEntity) {
  DateTime now = DateTime.now();
  // Normalize `now`, `checkInTime`, and `checkOut` to ignore the date & and care only about hours...
  DateTime todayCheckIn = DateTime(
    now.year,
    now.month,
    now.day,
    groupEntity.checkIn.hour,
    groupEntity.checkIn.minute,
  );
  DateTime todayCheckOut = DateTime(
    now.year,
    now.month,
    now.day,
    groupEntity.checkOut.hour,
    groupEntity.checkOut.minute,
  );
  return now.isBefore(todayCheckOut) && now.isAfter(todayCheckIn);
}

void showToast(String message, Color color, [Toast? toast]) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: toast ?? Toast.LENGTH_SHORT,
    gravity: ToastGravity.TOP,
    timeInSecForIosWeb: 20,
    backgroundColor: color,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

Future<void> showDeleteUserConfirmationDialog(
  BuildContext context,
  String userId,
  DeleteMemberFromGroupCubit deleteMemberCubit,
) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return DeleteUserDialog(
        userId: userId,
        deleteMemberCubit: deleteMemberCubit,
      );
    },
  );
}

Future<void> showDeleteGroupConfirmationDialog(
  BuildContext context,
  String groupId,
  DeleteGroupCubit deleteCubit,
) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return DeleteGroupDialog(groupId: groupId, deleteGroupCubit: deleteCubit);
    },
  );
}

PersistentBottomSheetController showJoinGroupBottomSheet(
  BuildContext context,
  GroupEntity groupEntity,
  JoinGroupCubit joinGroupCubit,
) {
  return showBottomSheet(
    context: context,
    builder: (context) => JoinGroupBottomSheet(
      groupEntity: groupEntity,
      joinGroupCubit: joinGroupCubit,
    ),
  );
}

PersistentBottomSheetController showTakePermissionBottomSheet(
  BuildContext context,
  GroupEntity groupEntity,
  PermissionCubit permissionCubit,
) {
  return showBottomSheet(
    context: context,
    builder: (context) => TakePermissionBottomSheet(
      groupEntity: groupEntity,
      permissionCubit: permissionCubit,
    ),
  );
}
