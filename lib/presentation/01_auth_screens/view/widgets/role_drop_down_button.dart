import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../../app/extensions.dart';
import '../../../02_home_screens/view_model/theme_bloc/theme_bloc.dart';
import '../../../resourses/assets_manager.dart';
import '../../../resourses/colors_manager.dart';
import '../../../resourses/styles_manager.dart';
import '../../view_model/auth_bloc/auth_bloc.dart';

class RoleDropdown extends StatefulWidget {
  const RoleDropdown({super.key});

  @override
  State<RoleDropdown> createState() => _RoleDropdownState();
}

class _RoleDropdownState extends State<RoleDropdown> {
  // Define the role options
  List<DropdownMenuItem<Role>> get roleOptions => [
    DropdownMenuItem(
      value: Role.admin,
      child: Row(
        spacing: 16,
        children: [
          SvgPicture.asset(
            SvgAssets.admin,
            fit: BoxFit.scaleDown,
            height: 20,
            colorFilter:
                context.watch<ThemeBloc>().state.themeMode == ThemeMode.dark
                    ? const ColorFilter.mode(
                      ColorsManager.white,
                      BlendMode.srcIn,
                    )
                    : const ColorFilter.mode(
                      ColorsManager.grey,
                      BlendMode.srcIn,
                    ),
          ),
          Text(tr('admin')),
        ],
      ),
    ),
    DropdownMenuItem(
      value: Role.user,
      child: Row(
        spacing: 16,
        children: [
          SvgPicture.asset(
            SvgAssets.user,
            height: 20,
            fit: BoxFit.scaleDown,
            colorFilter:
                context.watch<ThemeBloc>().state.themeMode == ThemeMode.dark
                    ? const ColorFilter.mode(
                      ColorsManager.white,
                      BlendMode.srcIn,
                    )
                    : const ColorFilter.mode(
                      ColorsManager.grey,
                      BlendMode.srcIn,
                    ),
          ),
          Text(tr('user')),
        ],
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    Role initialRole = context.read<AuthBloc>().memberRole;
    ThemeMode themeMode = context.watch<ThemeBloc>().state.themeMode;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color:
              themeMode == ThemeMode.dark
                  ? ColorsManager.lightOrange
                  : ColorsManager.darkGreen,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: DropdownButton<Role>(
        value: initialRole,
        padding: EdgeInsets.all(0),
        items: roleOptions,
        onChanged: (Role? newSelectedRole) {
          if (newSelectedRole != null) {
            context.read<AuthBloc>().memberRole = newSelectedRole;
            setState(() {
              initialRole = newSelectedRole;
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
          colorFilter:
              themeMode == ThemeMode.dark
                  ? const ColorFilter.mode(ColorsManager.white, BlendMode.srcIn)
                  : const ColorFilter.mode(ColorsManager.grey, BlendMode.srcIn),
        ),
        style: Styles.style16Medium().copyWith(
          color:
              themeMode == ThemeMode.dark
                  ? ColorsManager.lightOrange
                  : ColorsManager.darkGreen,
        ),
        isExpanded: true, // Make the dropdown take full width
      ),
    );
  }
}
