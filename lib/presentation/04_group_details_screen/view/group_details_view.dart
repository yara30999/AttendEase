import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../app/functions.dart';
import '../../02_home_screens/view/widgets/custom_app_bar.dart';
import '../../02_home_screens/view/widgets/custom_drawer.dart';
import '../../resourses/colors_manager.dart';
import '../../resourses/styles_manager.dart';
import 'widgets/day_indicator.dart';
import 'widgets/member_tile.dart';

class GroupDetailsView extends StatelessWidget {
  const GroupDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // add edit to the group
/*      appBar: AppBar(
        title: Text('Group Details'.tr()),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // TODO: Implement edit functionality
            },
          ),
        ],
      ),*/
      appBar: const CustomAppBar(),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Group Details'.tr(),
                style: Styles.style24Bold(),
              )),
            const SizedBox(height: 16),
            // Group Name
            Text(
              'Marketing Team', // Replace with actual group name
              style: Styles.style24Bold(),
            ),
            const SizedBox(height: 24),
            // Working Days
            Text(
              'Work Days:'.tr(),
              style: Styles.style16Medium(),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                DayIndicator(day: 'Sun'.tr(), isActive: true),
                SizedBox(width: 8),
                DayIndicator(day: 'Mon'.tr(), isActive: true),
                SizedBox(width: 8),
                DayIndicator(day: 'Tue'.tr(), isActive: true),
                SizedBox(width: 8),
                DayIndicator(day: 'Wed'.tr(), isActive: true),
                SizedBox(width: 8),
                DayIndicator(day: 'Thu'.tr(), isActive: true),
                SizedBox(width: 8),
                DayIndicator(day: 'Fri'.tr(), isActive: true),
                SizedBox(width: 8),
                DayIndicator(day: 'Sat'.tr(), isActive: false),
              ],
            ),
            const SizedBox(height: 24),
            // Check-in Time
            _buildTimeRow('Check-in Time:'.tr(), '09:00 AM'),
            const SizedBox(height: 12),

            // Check-out Time
            _buildTimeRow('Check-out Time:'.tr(), '05:00 PM'),
            const SizedBox(height: 24),

            // Password Section
            Row(
              children: [
                Text(
                  'passwordLabel'.tr(),
                  style: Styles.style16Medium(),
                ),
                const SizedBox(width: 12),
                Text(
                  'XZ1235', // Replace with actual password
                  style: Styles.style16Medium(),
                ),
                IconButton(
                  icon: const Icon(Icons.copy),
                  onPressed: () {
                    Clipboard.setData(const ClipboardData(text: 'XZ1235'))
                        .then((_) {
                      showToast('Password Copied'.tr(), ColorsManager.black);
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Members Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Members:'.tr(),
                  style: Styles.style20Bold(),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Members List
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3, // Replace with actual members count
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                return MemberTile(
                  name: 'John Doe $index', // Replace with actual member name
                  onTap: () {
                    // Navigate to user history
                    Navigator.pushNamed(context, '/user_history_route');
                  },
                  onDelete: () {
                    // TODO: Implement delete functionality
                    _showDeleteConfirmationDialog(context);
                  },
                );
              },
            ),
            ],
        ),
      ),
    );
  }

  Widget _buildTimeRow(String label, String time) {
    return Row(
      children: [
        Text(
          label,
          style: Styles.style16Medium(),
        ),
        const SizedBox(width: 12),
        Text(
          time,
          style: Styles.style16Medium(),
        ),
      ],
    );
  }

  Future<void> _showDeleteConfirmationDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'.tr()),
          content: Text('Are you sure you want to remove this member?'.tr()),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'.tr()),
            ),
            TextButton(
              onPressed: () {
                // TODO: Implement delete logic
                Navigator.pop(context);
              },
              child: Text(
                'Delete'.tr(),
                style: const TextStyle(color: ColorsManager.red),
              ),
            ),
          ],
        );
      },
    );
  }
}