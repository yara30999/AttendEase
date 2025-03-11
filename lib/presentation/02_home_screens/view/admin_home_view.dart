import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../app/di.dart';
import '../../resourses/language_manager.dart';
import '../../resourses/routes_manager.dart';
import '../../resourses/styles_manager.dart';
import '../view_model/cubit/home_cubit.dart';
import 'widgets/custom_app_bar.dart';
import 'widgets/custom_drawer.dart';
import 'widgets/group_bloc_builder.dart';
import 'widgets/group_search_field.dart';

class AdminHomeView extends StatelessWidget {
  const AdminHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(),
      drawer: const CustomDrawer(),

      body: BlocProvider(
        create: (context) => HomeCubit(instance()),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Column(
            spacing: 20,
            children: [
              // Fixed Header (Title + Search Field)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment:
                        LocalizationUtils.isCurrentLocalAr(context)
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                    child: Text(
                      context.tr("YourGroup"),
                      style: Styles.style24Bold(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GroupSearchField(),
                ],
              ),
              // Scrollable Content
              Expanded(child: GroupBlocBuilder(isAdmin: true)),
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
