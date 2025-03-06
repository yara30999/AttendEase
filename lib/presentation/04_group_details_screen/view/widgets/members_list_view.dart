import 'package:flutter/material.dart';
import '../../../../app/functions.dart';
import 'member_tile.dart';

class MembersListView extends StatelessWidget {
  const MembersListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 8, // Replace with actual members count
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        return MemberTile(
          name: 'John Doe $index', // Replace with actual member name
          onTap: () {
            // Navigate to user history
            Navigator.pushNamed(context, '/user_history_route');
          },
          onDelete: () {
            showDeleteUserConfirmationDialog(context);
          },
        );
      },
    );
  }
}
