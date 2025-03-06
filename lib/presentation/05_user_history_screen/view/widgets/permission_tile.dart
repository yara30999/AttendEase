import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../app/extensions.dart';
import '../../../resourses/colors_manager.dart';
import '../../../resourses/styles_manager.dart';

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
              // Date Container
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isDarkMode
                        ? ColorsManager.sandYellow
                        : ColorsManager.darkBrown,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text(
                      DateFormat('dd').format(date),
                      style: Styles.style20Bold().copyWith(
                        color: isDarkMode
                            ? ColorsManager.sandYellow
                            : ColorsManager.darkBrown,
                      ),
                    ),
                    Text(
                      DateFormat('EEE').format(date).toUpperCase(),
                      style: Styles.style14Medium().copyWith(
                        color: isDarkMode
                            ? ColorsManager.sandYellow
                            : ColorsManager.darkBrown,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              // Permission Details
              Expanded(
                child: Row(
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
                    type.icon, // Using the icon getter from the extension
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
