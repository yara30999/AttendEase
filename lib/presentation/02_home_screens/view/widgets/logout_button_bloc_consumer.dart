import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../app/functions.dart';
import '../../../01_auth_screens/view_model/auth_bloc/auth_bloc.dart';
import '../../../resourses/colors_manager.dart';
import '../../../resourses/routes_manager.dart';

class LogoutButtonBlocConsumer extends StatelessWidget {
  const LogoutButtonBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
          Navigator.pushReplacementNamed(context, Routes.loginRoute);
        } else if (state is LogoutError) {
          showToast(state.errMessage, ColorsManager.softRed);
        }
      },
      builder: (context, state) {
        if (state is LogoutLoading) {
          return ElevatedButton(
            onPressed: null,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 10,
              children: [
                Text(tr("login.logoutButton")),
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
            context.read<AuthBloc>().add(LogoutRequested());
          },
          child: Text(tr("login.loginButton")),
        );
      },
    );
  }
}
