import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../resourses/colors_manager.dart';

class CustomTabBar extends StatelessWidget {
  final TabController tabController;
  final bool isDarkMode;

  const CustomTabBar({
    Key? key,
    required this.tabController,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
      decoration: BoxDecoration(
        color: isDarkMode ? ColorsManager.grey : ColorsManager.creamyBeige,
        borderRadius: BorderRadius.circular(25),
      ),
      child: TabBar(
        controller: tabController,
        padding: const EdgeInsets.all(2),
        tabs: [
          CustomTab(icon: Icons.history, label: context.tr('History')),
          CustomTab(
            icon: Icons.assignment_late_outlined,
            label: context.tr('Permissions'),
          ),
        ],
      ),
    );
  }
}

class CustomTab extends StatelessWidget {
  final IconData icon;
  final String label;

  const CustomTab({Key? key, required this.icon, required this.label})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18),
            const SizedBox(width: 4),
            Text(label),
          ],
        ),
      ),
    );
  }
}
