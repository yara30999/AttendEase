import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../app/functions.dart';
import '../../../../../domain/entities/group_entity.dart';
import '../../../../04_group_details_screen/view/widgets/group_password_row.dart';
import '../../../../resourses/colors_manager.dart';
import '../../../../resourses/routes_manager.dart';
import '../../../../resourses/styles_manager.dart';
import '../../../view_model/delete_group_cubit/delete_group_cubit.dart';
import '../group_avatar.dart';
import '../total_group_members_stream_builder.dart';

class AdminGroupCard extends StatelessWidget {
  final GroupEntity groupEntity;

  const AdminGroupCard({super.key, required this.groupEntity});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.groupDetailsRoute,
          // Passing the groupEntity here
          arguments: groupEntity,
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              GroupAvatar(),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(groupEntity.name, style: Styles.style18Medium()),
                    TotalGroupMembersStreamBuilder(groupEntity.id),
                    FittedBox(
                      fit: BoxFit.fitWidth,
                      child: GroupPasswordRow(
                        passwordTxt: groupEntity.password,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: ColorsManager.deepRed),
                onPressed: () {
                  //delete will be by group-id.
                  final deleteCubit = context.read<DeleteGroupCubit>();
                  showDeleteGroupConfirmationDialog(
                    context,
                    groupEntity.id,
                    deleteCubit,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
