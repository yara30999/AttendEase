import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../../app/extensions.dart';
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
          const Icon(Icons.sunny, color: ColorsManager.darkGreen),
          Text(tr('admin')),
        ],
      ),
    ),
    DropdownMenuItem(
      value: Role.user,
      child: Row(
        spacing: 16,
        children: [
          const Icon(Icons.nightlight_round, color: ColorsManager.goldenSand),
          Text(tr('user')),
        ],
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    Role initialRole = context.read<AuthBloc>().memberRole;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: ColorsManager.lightOrange),
        borderRadius: BorderRadius.circular(16),
      ),
      child: DropdownButton<Role>(
        value: initialRole,
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
          Radius.circular(16),
        ), //for dropdown menu
        underline: Container(), // Remove the default underline
        icon: SvgPicture.asset(SvgAssets.dropdownArrow, width: 16),
        style: Styles.style24Bold().copyWith(color: ColorsManager.darkGreen),
        isExpanded: true, // Make the dropdown take full width
      ),
    );
  }
}
