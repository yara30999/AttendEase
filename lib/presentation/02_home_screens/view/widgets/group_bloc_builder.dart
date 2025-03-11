import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../resourses/colors_manager.dart';
import '../../view_model/cubit/home_cubit.dart';
import 'group_list_view.dart';
import 'state_widgets/empty_state_widget.dart';
import 'state_widgets/error_state_widget.dart';

class GroupBlocBuilder extends StatelessWidget {
  final bool isAdmin;
  const GroupBlocBuilder({super.key, required this.isAdmin});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return Center(
            child: CircularProgressIndicator(
              color: ColorsManager.grey,
              strokeAlign: CircularProgressIndicator.strokeAlignInside,
            ),
          );
        } else if (state is HomeError) {
          return ErrorStateWidget(
            width: MediaQuery.sizeOf(context).width * 0.3,
            errorText: context.tr(
              'failed_to_load_groups',
              args: [state.message],
            ),
          );
        } else if (state is HomeSuccess) {
          if (state.groups.isEmpty) {
            return EmptyStateWidget(label: context.tr('no_groups'));
          } else {
            return GroupListView(isAdmin: isAdmin, groups: state.groups);
          }
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
