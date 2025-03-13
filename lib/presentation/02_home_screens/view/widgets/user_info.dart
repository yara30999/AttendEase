import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/entities/auth_entity.dart';
import '../../../01_auth_screens/view_model/auth_bloc/auth_bloc.dart';
import 'dart:ui' as dui;
import '../../../resourses/assets_manager.dart';
import '../../../resourses/styles_manager.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthenticationEntity currentUser = context.read<AuthBloc>().authObj!;
    return Directionality(
      textDirection: dui.TextDirection.ltr,
      child: Card(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Image.asset(PngAssets.attendEaseLogo, fit: BoxFit.contain),
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(currentUser.email, style: Styles.style16Medium()),
                  Text(
                    currentUser.role + ': ' + currentUser.name,
                    style: Styles.style16Medium(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
