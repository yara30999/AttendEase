import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../app/di.dart';
import '../../../app/extensions.dart';
import '../../../app/functions.dart';
import '../../../domain/entities/group_entity.dart';
import '../../02_home_screens/view/widgets/custom_app_bar.dart';
import '../../02_home_screens/view/widgets/custom_drawer.dart';
import '../../03_create_group_screen/view/widgets/day_selector.dart';
import '../../resourses/colors_manager.dart';
import '../../resourses/styles_manager.dart';
import '../view_model/delete_member_cubit/delete_member_from_group_cubit.dart';
import '../view_model/group_members_cubit/group_members_cubit.dart';
import 'widgets/group_members_bloc_builder.dart';
import 'widgets/group_password_row.dart';
import 'widgets/location_map_card.dart';
import 'widgets/time_row.dart';

class GroupDetailsView extends StatelessWidget {
  final GroupEntity groupEntity;
  const GroupDetailsView(this.groupEntity, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) =>
                  GroupMembersCubit(instance())
                    ..getStreamMembers(groupEntity.id),
        ),
        BlocProvider(
          create: (context) => DeleteMemberFromGroupCubit(instance()),
        ),
      ],
      child: BlocListener<
        DeleteMemberFromGroupCubit,
        DeleteMemberFromGroupState
      >(
        listener: (context, state) {
          if (state is DeleteMemberSuccess) {
            showToast(
              context.tr('member_deleted_successfully'),
              ColorsManager.grey,
            );
          }
          if (state is DeleteMemberError) {
            showToast(
              context.tr('something_went_wrong'),
              ColorsManager.softRed,
            );
          }
        },
        child: Scaffold(
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
                Text(groupEntity.name, style: Styles.style24Bold()),
                Text(context.tr('Work_Days:'), style: Styles.style16Medium()),
                DaySelector(selectedDays: groupEntity.days?.toSet() ?? {}),
                TimeRow(
                  label: context.tr('Check_in_Time:'),
                  time: groupEntity.checkIn.toFormattedTime(),
                ), //'05:00 PM'
                TimeRow(
                  label: context.tr('Check_out_Time:'),
                  time: groupEntity.checkOut.toFormattedTime(),
                ), //'05:00 PM'
                GroupPasswordRow(passwordTxt: groupEntity.password),
                // Location Map
                Text(context.tr('Location'), style: Styles.style20Bold()),
                LocationMapCard(groupEntity.location),
                Text(context.tr('Members:'), style: Styles.style20Bold()),
                //members list view will use group-id from ---> groupEntity.id
                GroupMembersBlocBuilder(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
