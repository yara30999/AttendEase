import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../app/di.dart';
import '../../resourses/colors_manager.dart';
import '../view_model/group_details_bloc/group_details_bloc.dart';
import 'widgets/state_widgets/error_state_widget.dart';
import 'widgets/user/days/holiday.dart';
import 'widgets/user/days/normal_day.dart';

class AlreadyHaveGroup extends StatelessWidget {
  final String currentUserGroupId;
  const AlreadyHaveGroup(this.currentUserGroupId, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              GroupDetailsBloc(instance())
                ..add(GroupDetailsRequested(groupId: currentUserGroupId)),
      child: BlocBuilder<GroupDetailsBloc, GroupDetailsState>(
        builder: (context, state) {
          if (state is GroupDetailsLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: ColorsManager.grey,
                strokeAlign: CircularProgressIndicator.strokeAlignInside,
              ),
            );
          } else if (state is GroupDetailsError) {
            debugPrint(
              'this is current user having group details error: ${state.errMessage}',
            );
            return ErrorStateWidget(
              width: MediaQuery.sizeOf(context).width * 0.3,
              errorText: context.tr('something_went_wrong'),
            );
          } else if (state is GroupDetailsSuccess) {
            List<int> days = state.groupEntity.days ?? [];
            // the current day index (0 = Sunday, 1 = Monday, ..., 6 = Saturday)
            int currentDayIndex = DateTime.now().weekday % 7;
            // check if today is a working day
            bool isWorkingDay = days.contains(currentDayIndex);
            return isWorkingDay
                ? NormalDay(state.groupEntity)
                : Holiday(state.groupEntity);
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
