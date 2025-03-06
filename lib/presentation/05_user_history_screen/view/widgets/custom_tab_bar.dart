import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../resourses/colors_manager.dart';
import '../../../resourses/styles_manager.dart';

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
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isDarkMode
            ? ColorsManager.darkBrown
            : ColorsManager.creamyBeige,
        borderRadius: BorderRadius.circular(25),
      ),
      child: TabBar(
        controller: tabController,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: isDarkMode
              ? ColorsManager.sandYellow
              : ColorsManager.darkBrown,
        ),
        labelColor:
        isDarkMode ? ColorsManager.darkBrown : ColorsManager.white,
        unselectedLabelColor: isDarkMode
            ? ColorsManager.sandYellow
            : ColorsManager.darkBrown,
        labelStyle: Styles.style16Medium().copyWith(
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: Styles.style16Medium(),
        padding: const EdgeInsets.all(3),
        tabs: [
          _buildTab(Icons.history, context.tr('History')),
          _buildTab(Icons.assignment_late_outlined, context.tr('Permissions')),
        ],
      ),
    );
  }

  Widget _buildTab(IconData icon, String text) {
    return Tab(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20),
            const SizedBox(width: 8),
            Text(text),
          ],
        ),
      ),
    );
  }
}