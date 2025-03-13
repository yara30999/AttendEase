import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../app/functions.dart';
import '../../../resourses/colors_manager.dart';
import '../../../resourses/styles_manager.dart';
import '../../view_model/group_details_bloc/group_details_bloc.dart';

class GroupPasswordRow extends StatelessWidget {
  final String passwordTxt;
  const GroupPasswordRow({super.key, required this.passwordTxt});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        Text(context.tr('GroupPassword'), style: Styles.style16Medium()),
        Text(passwordTxt, style: Styles.style16Medium()),
        InkWell(
          child: const Icon(Icons.copy, size: 18),
          onTap: () {
            Clipboard.setData(ClipboardData(text: passwordTxt)).then((_) {
              showToast(context.tr('password_copied'), ColorsManager.black);
            });
          },
        ),
      ],
    );
  }
}

String getPassword(BuildContext context) {
  final _groupInfo = context.watch<GroupDetailsBloc>().groupInfo;
  final _password = _groupInfo?.password ?? "";
  return _password;
}
