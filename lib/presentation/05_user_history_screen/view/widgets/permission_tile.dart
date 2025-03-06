import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../app/extensions.dart';
import '../../../resourses/colors_manager.dart';
import '../../../resourses/styles_manager.dart';
import 'date_box.dart';

class PermissionTile extends StatelessWidget {
  final DateTime date;
  final PermissionType type;
  final VoidCallback onTap;

  const PermissionTile({
    Key? key,
    required this.date,
    required this.type,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Card(
      elevation: 4,
      color: isDarkMode ? ColorsManager.mediumBrown : ColorsManager.creamyBeige,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              DateBox(date: date),
              const SizedBox(width: 16),
              Expanded(
                child: PermissionDetails(
                  type: type,
                  date: date,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PermissionDetails extends StatelessWidget {
  final PermissionType type;
  final DateTime date;

  const PermissionDetails({
    Key? key,
    required this.type,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              type.name,
              style: Styles.style16Medium().copyWith(
                color: isDarkMode
                    ? ColorsManager.white
                    : ColorsManager.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              DateFormat('EEEE, MMMM d, y').format(date),
              style: Styles.style14Medium().copyWith(
                color: isDarkMode
                    ? ColorsManager.sandYellow.withOpacity(0.7)
                    : ColorsManager.darkBrown.withOpacity(0.7),
              ),
            ),
          ],
        ),
        PermissionIcon(type: type),
      ],
    );
  }
}

class PermissionIcon extends StatelessWidget {
  final PermissionType type;

  const PermissionIcon({
    Key? key,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: _getBackgroundColor(),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        _getIcon(),
        color: Colors.white,
        size: 24,
      ),
    );
  }

  Color _getBackgroundColor() {
    switch (type) {
      case PermissionType.sickLeave:
        return const Color(0xFFFFB5B5);
      case PermissionType.emergencyLeave:
        return const Color(0xFFFFC107);
      case PermissionType.vacationLeave:
        return const Color(0xFF90CAF9);
      case PermissionType.workFromHome:
        return const Color(0xFF81C784);
    }
  }

  IconData _getIcon() {
    switch (type) {
      case PermissionType.sickLeave:
        return Icons.healing;
      case PermissionType.emergencyLeave:
        return Icons.warning_rounded;
      case PermissionType.vacationLeave:
        return Icons.beach_access;
      case PermissionType.workFromHome:
        return Icons.home_work;
    }
  }
}