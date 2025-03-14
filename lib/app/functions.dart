import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import '../domain/entities/auth_entity.dart';
import '../domain/entities/group_entity.dart';
import '../presentation/02_home_screens/view/widgets/admin/delete_group_dialog.dart';
import '../presentation/02_home_screens/view/widgets/user/join_group_bottom_sheet.dart';
import '../presentation/02_home_screens/view_model/delete_group_cubit/delete_group_cubit.dart';
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

String generateRandomPassword({int length = 8}) {
  const String chars =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#\$%^&*()-_=+';
  Random random = Random();
  return List.generate(
    length,
    (index) => chars[random.nextInt(chars.length)],
  ).join();
}

bool isWithinCheckInTime(GroupEntity groupEntity) {
  DateTime now = DateTime.now();
  TimeOfDay currentTime = TimeOfDay(hour: now.hour, minute: now.minute);

  TimeOfDay checkInTime = TimeOfDay(
    hour: groupEntity.checkIn.hour,
    minute: groupEntity.checkIn.minute,
  );
  TimeOfDay checkOutTime = TimeOfDay(
    hour: groupEntity.checkOut.hour,
    minute: groupEntity.checkOut.minute,
  );
  bool isAfterCheckIn =
      currentTime.hour > checkInTime.hour ||
      (currentTime.hour == checkInTime.hour &&
          currentTime.minute >= checkInTime.minute);
  bool isBeforeCheckOut =
      currentTime.hour < checkOutTime.hour ||
      (currentTime.hour == checkOutTime.hour &&
          currentTime.minute <= checkOutTime.minute);
  return isAfterCheckIn && isBeforeCheckOut;
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
) {
  return showBottomSheet(
    context: context,
    builder: (context) => JoinGroupBottomSheet(groupEntity: groupEntity),
  );
}
