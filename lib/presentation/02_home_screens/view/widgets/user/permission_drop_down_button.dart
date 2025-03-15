import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../../../app/extensions.dart';
import '../../../../../app/functions.dart';
import '../../../../resourses/assets_manager.dart';
import '../../../../resourses/colors_manager.dart';
import '../../../../resourses/styles_manager.dart';
import '../../../view_model/permission_cubit/permission_cubit.dart';

class PermissionDropDownButton extends StatefulWidget {
  const PermissionDropDownButton({super.key});

  @override
  State<PermissionDropDownButton> createState() =>
      _PermissionDropDownButtonState();
}

class _PermissionDropDownButtonState extends State<PermissionDropDownButton> {
  // Define the role options
  List<DropdownMenuItem<PermissionType>> get permissionOptions => [
    DropdownMenuItem(
      value: PermissionType.emergencyLeave,
      child: Row(
        spacing: 16,
        children: [
          PermissionType.emergencyLeave.icon,
          Text(PermissionType.emergencyLeave.string),
        ],
      ),
    ),
    DropdownMenuItem(
      value: PermissionType.sickLeave,
      child: Row(
        spacing: 16,
        children: [
          PermissionType.sickLeave.icon,
          Text(PermissionType.sickLeave.string),
        ],
      ),
    ),
    DropdownMenuItem(
      value: PermissionType.vacationLeave,
      child: Row(
        spacing: 16,
        children: [
          PermissionType.vacationLeave.icon,
          Text(PermissionType.vacationLeave.string),
        ],
      ),
    ),
    DropdownMenuItem(
      value: PermissionType.workFromHome,
      child: Row(
        spacing: 16,
        children: [
          PermissionType.workFromHome.icon,
          Text(PermissionType.workFromHome.string),
        ],
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    PermissionType initialPermission =
        context.read<PermissionCubit>().initPermission;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color:
              Theme.of(context).brightness == Brightness.light
                  ? ColorsManager.emeraldGreen
                  : ColorsManager.paleBlushRed,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: DropdownButton<PermissionType>(
        value: initialPermission,
        padding: EdgeInsets.all(0),
        items: permissionOptions,
        onChanged: (PermissionType? newSelected) {
          if (newSelected != null) {
            context.read<PermissionCubit>().initPermission = newSelected;
            setState(() {
              initialPermission = newSelected;
            });
          }
        },
        borderRadius: const BorderRadius.all(
          //for dropdown menu
          Radius.circular(30),
        ),
        underline: Container(), // Remove the default underline
        icon: SvgPicture.asset(
          SvgAssets.dropdownArrow,
          width: 16,
          colorFilter: const ColorFilter.mode(
            ColorsManager.grey,
            BlendMode.srcIn,
          ),
        ),
        style: Styles.style16Medium().copyWith(
          color:
              isLightTheme(context)
                  ? ColorsManager.emeraldGreen
                  : ColorsManager.paleBlushRed,
        ),
        isExpanded: true, // Make the dropdown take full width
      ),
    );
  }
}
