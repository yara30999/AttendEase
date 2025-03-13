import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../app/di.dart';
import '../../../domain/entities/auth_entity.dart';
import '../../02_home_screens/view/widgets/custom_app_bar.dart';
import '../../02_home_screens/view/widgets/custom_drawer.dart';
import '../view_model/history_bloc/user_history_bloc.dart';
import '../view_model/permissions_bloc/user_permissions_bloc.dart';
import 'widgets/bloc_builders/history_tap_view_bloc_builder.dart';
import 'widgets/bloc_builders/permissions_tap_view_bloc_builder.dart';
import 'widgets/custom_tab_bar.dart';

class UserHistoryView extends StatefulWidget {
  final AuthenticationEntity user;
  const UserHistoryView(this.user, {Key? key}) : super(key: key);

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
    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: const CustomDrawer(),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create:
                (context) =>
                    UserHistoryBloc(instance())
                      ..add(UserHistoryEventRequested(widget.user.id)),
          ),
          BlocProvider(
            create:
                (context) =>
                    UserPermissionsBloc(instance())
                      ..add(UserPermissionsEventRequested(widget.user.id)),
          ),
        ],
        child: Column(
          children: [
            CustomTabBar(tabController: _tabController),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  HistoryTapViewBlocBuilder(),
                  PermissionsTapViewBlocBuilder(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
