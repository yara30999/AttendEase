import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../02_home_screens/view/widgets/state_widgets/empty_state_widget.dart';
import '../../../../02_home_screens/view/widgets/state_widgets/error_state_widget.dart';
import '../../../../resourses/colors_manager.dart';
import '../../../view_model/permissions_bloc/user_permissions_bloc.dart';
import 'permissions_tab_view.dart';

class PermissionsTapViewBlocBuilder extends StatelessWidget {
  const PermissionsTapViewBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserPermissionsBloc, UserPermissionsState>(
      builder: (context, state) {
        if (state is UserPermissionsLoading) {
          return Center(
            child: CircularProgressIndicator(
              color: ColorsManager.grey,
              strokeAlign: CircularProgressIndicator.strokeAlignInside,
            ),
          );
        } else if (state is UserPermissionsError) {
          return ErrorStateWidget(
            width: MediaQuery.sizeOf(context).width * 0.3,
            errorText: context.tr(
              'failed_to_load_permissions_list',
              args: [state.errMessage],
            ),
          );
        } else if (state is UserPermissionsSuccess) {
          if (state.userPermissions.isEmpty) {
            return EmptyStateWidget(label: context.tr('no_permissions'));
          } else {
            return PermissionsTabView(state.userPermissions);
          }
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
