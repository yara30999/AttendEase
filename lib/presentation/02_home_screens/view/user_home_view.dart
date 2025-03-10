import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../resourses/styles_manager.dart';
import 'widgets/custom_app_bar.dart';
import 'widgets/custom_drawer.dart';
import 'widgets/group_list.dart';


class UserHomeView extends StatelessWidget {
  const UserHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const SearchBar(),
              SizedBox(height: 10),
              Align( 
                child: Text(context.tr("JoinGroup"), style: Styles.style24Bold()),
              ),
              SizedBox(height: 10),
              GroupListView(isAdmin: false,),
            ],
          ),
        ),
      ),
    );
  }
}
