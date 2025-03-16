import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../domain/entities/group_entity.dart';
import '../../../../../resourses/colors_manager.dart';
import '../../../../../resourses/language_manager.dart';
import '../../../../../resourses/styles_manager.dart';
import '../../../../view_model/permission_cubit/permission_cubit.dart';
import '../permission_drop_down_button.dart';

class TakePermissionBottomSheet extends StatefulWidget {
  final GroupEntity groupEntity;
  final PermissionCubit permissionCubit;
  const TakePermissionBottomSheet({
    super.key,
    required this.groupEntity,
    required this.permissionCubit,
  });

  @override
  State<TakePermissionBottomSheet> createState() =>
      _TakePermissionBottomSheetState();
}

class _TakePermissionBottomSheetState extends State<TakePermissionBottomSheet> {
  String? _message;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              context.tr('choose_permission_type:'),
              style: Styles.style20Bold(),
            ),
            SizedBox(height: 10),
            PermissionDropDownButton(widget.permissionCubit),
            SizedBox(height: 10),
            TextField(
              maxLines: 2,
              decoration: InputDecoration(hintText: context.tr('more_details')),
              onChanged: (value) {
                setState(() {
                  _message = value;
                });
              },
            ),
            SizedBox(height: 10),
            // take permission button.
            BlocConsumer<PermissionCubit, PermissionState>(
              bloc: widget.permissionCubit,
              listener: (BuildContext context, PermissionState state) {
                if (state is PermissionSuccess) {
                  // Close the bottom sheet if it's still open
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                }
              },
              builder: (context, state) {
                if (state is PermissionLoading) {
                  return ElevatedButton(
                    onPressed: null,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      spacing: 10,
                      children: [
                        Text(context.tr("HavePermission")),
                        const CircularProgressIndicator(
                          color: ColorsManager.white,
                          strokeAlign:
                              CircularProgressIndicator.strokeAlignInside,
                        ),
                      ],
                    ),
                  );
                }
                return ElevatedButton(
                  onPressed: () {
                    //for datebase we need to provide group-id
                    widget.permissionCubit.takePermission(
                      groupId: widget.groupEntity.id,
                      time: DateTime.now(),
                      message: _message,
                    );
                  },
                  child: Text(context.tr("HavePermission")),
                );
              },
            ),
            // close button.
            Align(
              alignment:
                  LocalizationUtils.isCurrentLocalAr(context)
                      ? Alignment.bottomLeft
                      : Alignment.bottomRight,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(context.tr('close')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
