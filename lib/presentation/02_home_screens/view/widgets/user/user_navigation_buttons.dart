import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../app/di.dart';
import '../../../../../domain/entities/auth_entity.dart';
import '../../../../../domain/usecase/current_user_group_id_stream.dart';
import '../../../../01_auth_screens/view_model/auth_bloc/auth_bloc.dart';
import '../../../../resourses/routes_manager.dart';
import '../../../../resourses/styles_manager.dart';

class UserNavigationButtons extends StatelessWidget {
  const UserNavigationButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final CurrentUserGroupIdStream currentUserGroupIdStream = instance();
    final AuthenticationEntity currentUser = context.read<AuthBloc>().authObj!;
    return StreamBuilder<String?>(
      stream: currentUserGroupIdStream.execute(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          //user joined group, then show the button
          debugPrint('User groupId: ${snapshot.data}');
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      Routes.userHomeRoute,
                      (route) => false, // to remove all previous routes
                    );
                  },
                  child: Text(
                    'go to home',
                    style: Styles.style16Medium().copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      Routes.userHistoryRoute,
                      (route) => false, // to remove all previous routes
                      arguments: currentUser,
                    );
                  },
                  child: Text(
                    'go to your records',
                    style: Styles.style16Medium().copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          debugPrint('No data available');
          return SizedBox.shrink();
        }
      },
    );
  }
}
