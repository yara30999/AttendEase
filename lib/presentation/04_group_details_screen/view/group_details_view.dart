import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../02_home_screens/view/widgets/custom_app_bar.dart';
import '../../02_home_screens/view/widgets/custom_drawer.dart';
import '../../03_create_group_screen/view/widgets/day_selector.dart';
import '../../resourses/styles_manager.dart';
import '../view_model/group_details_bloc/group_details_bloc.dart';
import 'widgets/group_password_row.dart';
import 'widgets/location_map_card.dart';
import 'widgets/members_list_view.dart';
import 'widgets/time_row.dart';

class GroupDetailsView extends StatelessWidget {
  const GroupDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 14,
          children: [
            Center(
              child: Text(
                context.tr('group_details'),
                style: Styles.style24Bold(),
              ),
            ),
            Text(
              context.watch<GroupDetailsBloc>().groupInfo?.name ?? "",
              style: Styles.style24Bold(),
            ),
            Text(context.tr('Work_Days:'), style: Styles.style16Medium()),
            DaySelector(selectedDays: getWorkDays(context)),
            TimeRow(label: context.tr('Check_in_Time:'), time: '09:00 AM'),
            TimeRow(label: context.tr('Check_out_Time:'), time: '05:00 PM'),
            GroupPasswordRow(),
            // Location Map
            Text(context.tr('Location'), style: Styles.style20Bold()),
            const LocationMapCard(),
            Text(context.tr('Members:'), style: Styles.style20Bold()),
            MembersListView(),
          ],
        ),
      ),
    );
  }
}

Set<int> getWorkDays(BuildContext context) {
  return context.watch<GroupDetailsBloc>().groupInfo?.days?.toSet() ?? Set<int>();
}
