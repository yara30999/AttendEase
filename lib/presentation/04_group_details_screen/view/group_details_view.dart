import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../02_home_screens/view/widgets/custom_app_bar.dart';
import '../../02_home_screens/view/widgets/custom_drawer.dart';
import '../../03_create_group_screen/view/widgets/day_selector.dart';
import '../../resourses/styles_manager.dart';
import 'widgets/group_password_row.dart';
import 'widgets/location_map_card.dart';
import 'widgets/members_list_view.dart';
import 'widgets/time_row.dart';

class GroupDetailsView extends StatelessWidget {
  const GroupDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Set<int> _selectedDays = {0, 1, 5};
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
                context.tr('Group Details'),
                style: Styles.style24Bold(),
              ),
            ),
            Text(
              // Replace with actual group name
              'Marketing Team',
              style: Styles.style24Bold(),
            ),
            Text(context.tr('Work Days:'), style: Styles.style16Medium()),
            DaySelector(selectedDays: _selectedDays),
            TimeRow(label: context.tr('Check-in Time:'), time: '09:00 AM'),
            TimeRow(label: context.tr('Check-out Time:'), time: '05:00 PM'),
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
