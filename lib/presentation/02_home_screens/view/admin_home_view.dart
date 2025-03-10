import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../resourses/routes_manager.dart';
import '../../resourses/styles_manager.dart';
import 'widgets/custom_app_bar.dart';
import 'widgets/custom_drawer.dart';
import 'widgets/group_list.dart';

class AdminHomeView extends StatelessWidget {
  const AdminHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const SearchBar(),
              SizedBox(height: 10),
              Align( 
                child: Text(context.tr("YourGroup"), style: Styles.style24Bold()),
              ),
              SizedBox(height: 10),
              GroupListView(isAdmin: true,),
            ],
          ),
        ),
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
