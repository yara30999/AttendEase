import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../02_home_screens/view/widgets/state_widgets/empty_state_widget.dart';
import '../../../../02_home_screens/view/widgets/state_widgets/error_state_widget.dart';
import '../../../../resourses/colors_manager.dart';
import '../../../view_model/history_bloc/user_history_bloc.dart';
import 'history_tab_view.dart';

class HistoryTapViewBlocBuilder extends StatelessWidget {
  const HistoryTapViewBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserHistoryBloc, UserHistoryState>(
      builder: (context, state) {
        if (state is UserHistoryLoading) {
          return Center(
            child: CircularProgressIndicator(
              color: ColorsManager.grey,
              strokeAlign: CircularProgressIndicator.strokeAlignInside,
            ),
          );
        } else if (state is UserHistoryError) {
          return ErrorStateWidget(
            width: MediaQuery.sizeOf(context).width * 0.3,
            errorText: context.tr(
              'failed_to_load_history_list',
              args: [state.errMessage],
            ),
          );
        } else if (state is UserHistorySuccess) {
          if (state.userHistory.isEmpty) {
            return EmptyStateWidget(label: context.tr('no_history'));
          } else {
            return HistoryTabView(state.userHistory);
          }
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
