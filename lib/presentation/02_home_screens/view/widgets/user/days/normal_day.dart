import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../../../app/di.dart';
import '../../../../../../app/functions.dart';
import '../../../../../../domain/entities/group_entity.dart';
import '../../../../../resourses/colors_manager.dart';
import '../../../../../resourses/styles_manager.dart';
import '../../../../view_model/check_in_out_bloc/check_in_out_bloc.dart';
import '../../../../view_model/permission_cubit/permission_cubit.dart';
import '../../time/live_date_time.dart';
import '../check_in_out_button.dart';
import '../group_check_details_row.dart';
import '../permission_btn.dart';
import '../time_card.dart';

class NormalDay extends StatelessWidget {
  final GroupEntity currentUserGroupEntity;
  const NormalDay(this.currentUserGroupEntity, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) => CheckInOutBloc(
                instance(),
                instance(),
                instance(),
                instance(),
              ),
        ),
        BlocProvider(
          create: (context) => PermissionCubit(instance(), instance()),
        ),
      ],
      child: BlocListener<PermissionCubit, PermissionState>(
        listener: (BuildContext context, PermissionState state) {
          if (state is PermissionSuccess) {
            showToast(
              context.tr('take_permission_successfully'),
              ColorsManager.grey,
            );
          }
          if (state is PermissionError) {
            showToast(state.message, ColorsManager.softRed, Toast.LENGTH_LONG);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(currentUserGroupEntity.name, style: Styles.style24Bold()),
              TimeCard(),
              LiveDateTime(),
              CheckInOutButton(currentUserGroupEntity),
              PermissionBtn(currentUserGroupEntity),
              GroupCheckDetails(
                checkInTime: currentUserGroupEntity.checkIn,
                checkOutTime: currentUserGroupEntity.checkOut,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
