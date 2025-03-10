import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import '../domain/entities/auth_entity.dart';
import '../presentation/02_home_screens/view/widgets/admin/delete_group_dialog.dart';
import '../presentation/02_home_screens/view_model/theme_bloc/theme_bloc.dart';
import '../presentation/04_group_details_screen/view/widgets/delete_user_dialog.dart';
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

void showToast(String message, Color color) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.TOP,
    timeInSecForIosWeb: 20,
    backgroundColor: color,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

Future<void> showDeleteUserConfirmationDialog(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return DeleteUserDialog();
    },
  );
}

Future<void> showDeleteGroupConfirmationDialog(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return DeleteGroupDialog();
    },
  );
}