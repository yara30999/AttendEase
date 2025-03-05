import 'package:flutter/material.dart';
import '../../../resourses/constant_manager.dart';
import '../../../resourses/styles_manager.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      iconTheme: Theme.of(context).iconTheme,
      title: Text(AppConstants.AttendEase, style: Styles.style35Bold()),
      leading: IconButton(
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
        icon: const Icon(Icons.menu),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
