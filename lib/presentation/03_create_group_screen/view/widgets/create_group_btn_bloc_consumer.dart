import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../app/functions.dart';
import '../../../resourses/colors_manager.dart';
import '../../view_model/bloc/create_group_bloc.dart';

class CreateGroupButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final String groupName;
  final Set<int> selectedDays;
  final TimeOfDay checkInTime;
  final TimeOfDay checkOutTime;

  const CreateGroupButton(
    this.formKey,
    this.groupName,
    this.selectedDays,
    this.checkInTime,
    this.checkOutTime, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateGroupBloc, CreateGroupState>(
      listener: (context, state) {
        if (state is CreateGroupSuccess) {
          showToast(context.tr('group_created_success'), ColorsManager.grey);
          Future.delayed(Duration(seconds: 2)).then((value) {
            if (context.mounted) {
              Navigator.pop(context);
            }
          });
        }
        if (state is CreateGroupError) {
          showToast(state.errMessage, ColorsManager.softRed);
        }
      },
      builder: (context, state) {
        if (state is CreateGroupLoading) {
          return ElevatedButton(
            onPressed: null,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 10,
              children: [
                Text(context.tr("create_group")),
                const CircularProgressIndicator(
                  color: ColorsManager.white,
                  strokeAlign: CircularProgressIndicator.strokeAlignInside,
                ),
              ],
            ),
          );
        }
        return ElevatedButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              context.read<CreateGroupBloc>().add(
                CreateGroupRequested(
                  groupName: groupName,
                  days: selectedDays.toList(),
                  checkInTime: checkInTime,
                  checkOutTime: checkOutTime,
                ),
              );
            }
          },
          child: Text(context.tr("create_group")),
        );
      },
    );
  }
}
