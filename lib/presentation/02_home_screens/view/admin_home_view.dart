import 'package:flutter/material.dart';
import '../../resourses/routes_manager.dart';
import 'widgets/custom_app_bar.dart';
import 'widgets/custom_drawer.dart';
import 'widgets/logout_button_bloc_consumer.dart';

class AdminHomeView extends StatelessWidget {
  const AdminHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: const CustomDrawer(),
      body: Column(
        children: [
          const LogoutButtonBlocConsumer(),
          const Text('admin home admin '),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.groupDetailsRoute);
            },
            child: const Text('Go to Group Details'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.createGroupRoute);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
