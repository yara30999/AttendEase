import 'package:flutter/material.dart';

import 'widgets/custom_app_bar.dart';
import 'widgets/custom_drawer.dart';
import 'widgets/logout_button_bloc_consumer.dart';

class UserHomeView extends StatefulWidget {
  const UserHomeView({super.key});

  @override
  State<UserHomeView> createState() => _UserHomeViewState();
}

class _UserHomeViewState extends State<UserHomeView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(),
      drawer: CustomDrawer(),
      body: Column(children: [LogoutButtonBlocConsumer(), Text('user home ')]),
    );
  }
}
