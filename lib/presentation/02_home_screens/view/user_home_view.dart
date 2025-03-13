import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../app/di.dart';
import '../../../domain/usecase/current_user_group_id_stream.dart';
import '../../resourses/colors_manager.dart';
import 'already_have_group.dart';
import 'choose_group.dart';
import 'widgets/custom_app_bar.dart';
import 'widgets/custom_drawer.dart';
import 'widgets/state_widgets/error_state_widget.dart';

class UserHomeView extends StatelessWidget {
  const UserHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final CurrentUserGroupIdStream currentUserGroupIdStream = instance();
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: CustomDrawer(),
      body: StreamBuilder<String?>(
        stream: currentUserGroupIdStream.execute(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: ColorsManager.grey,
                strokeAlign: CircularProgressIndicator.strokeAlignInside,
              ),
            );
          }
          if (snapshot.hasError) {
            return ErrorStateWidget(
              width: MediaQuery.sizeOf(context).width * 0.3,
              errorText: context.tr('something_went_wrong'),
            );
          }
          if (snapshot.hasData) {
            debugPrint('User groupId: ${snapshot.data}');
            return AlreadyHaveGroup();
          } else {
            debugPrint('No data available');
            return ChooseGroup();
          }
        },
      ),
    );
  }
}
