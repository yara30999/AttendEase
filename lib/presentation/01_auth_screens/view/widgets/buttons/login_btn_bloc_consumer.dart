import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../app/extensions.dart';
import '../../../../../app/functions.dart';
import '../../../../resourses/colors_manager.dart';
import '../../../../resourses/routes_manager.dart';
import '../../../view_model/auth_bloc/auth_bloc.dart';

class LoginButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final String? email;
  final String? password;

  const LoginButton(this.formKey, this.email, this.password, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          if (state.authObj.role == Role.admin.name) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.adminHomeRoute,
              (route) => false, // to remove all previous routes
            );
          } else {
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.userHomeRoute,
              (route) => false, // to remove all previous routes
            );
          }
        }
        if (state is LoginError) {
          showToast(state.errMessage, ColorsManager.softRed);
        }
      },
      builder: (context, state) {
        if (state is LoginLoading) {
          return ElevatedButton(
            onPressed: null,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 10,
              children: [
                Text(context.tr("login_label")),
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
              context.read<AuthBloc>().add(
                LoginRequested(email: email!, password: password!),
              );
            }
          },
          child: Text(context.tr("login_label")),
        );
      },
    );
  }
}
