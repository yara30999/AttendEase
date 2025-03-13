import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../02_home_screens/view/widgets/state_widgets/empty_state_widget.dart';
import '../../../02_home_screens/view/widgets/state_widgets/error_state_widget.dart';
import '../../../resourses/colors_manager.dart';
import '../../view_model/group_members_cubit/group_members_cubit.dart';
import 'members_list_view.dart';

class GroupMembersBlocBuilder extends StatelessWidget {
  const GroupMembersBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupMembersCubit, GroupMembersState>(
      builder: (context, state) {
        if (state is GroupMembersLoading) {
          return Center(
            child: CircularProgressIndicator(
              color: ColorsManager.grey,
              strokeAlign: CircularProgressIndicator.strokeAlignInside,
            ),
          );
        } else if (state is GroupMembersError) {
          return ErrorStateWidget(
            width: MediaQuery.sizeOf(context).width * 0.3,
            errorText: context.tr(
              'failed_to_load_members',
              args: [state.message],
            ),
          );
        } else if (state is GroupMembersSuccess) {
          if (state.groupMembers.isEmpty) {
            return EmptyStateWidget(label: context.tr('no_members'));
          } else {
            return MembersListView(state.groupMembers);
          }
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
