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
      margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
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
        labelStyle: Styles.style14Medium().copyWith(
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: Styles.style14Medium(),
        padding: const EdgeInsets.all(2),
        tabs: [
          CustomTab(
            icon: Icons.history,
            label: context.tr('History'),
          ),
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

  const CustomTab({
    Key? key,
    required this.icon,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: TabContent(
          icon: icon,
          label: label,
        ),
      ),
    );
  }
}

class TabContent extends StatelessWidget {
  final IconData icon;
  final String label;

  const TabContent({
    Key? key,
    required this.icon,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        TabIcon(icon: icon),
        const SizedBox(width: 4),
        TabLabel(label: label),
      ],
    );
  }
}

class TabIcon extends StatelessWidget {
  final IconData icon;

  const TabIcon({
    Key? key,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: 18,
    );
  }
}

class TabLabel extends StatelessWidget {
  final String label;

  const TabLabel({
    Key? key,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(label);
  }
}