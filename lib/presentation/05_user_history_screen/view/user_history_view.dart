import 'package:flutter/material.dart';
import '../../02_home_screens/view/widgets/custom_app_bar.dart';
import '../../02_home_screens/view/widgets/custom_drawer.dart';
import 'widgets/custom_tab_bar.dart';
import 'widgets/history_tab_view.dart';
import 'widgets/permissions_tab_view.dart';

class UserHistoryView extends StatefulWidget {
  const UserHistoryView({Key? key}) : super(key: key);

  @override
  State<UserHistoryView> createState() => _UserHistoryViewState();
}

class _UserHistoryViewState extends State<UserHistoryView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: const CustomDrawer(),
      body: Column(
        children: [
          CustomTabBar(tabController: _tabController, isDarkMode: isDarkMode),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [HistoryTabView(), PermissionsTabView()],
            ),
          ),
        ],
      ),
    );
  }
}
