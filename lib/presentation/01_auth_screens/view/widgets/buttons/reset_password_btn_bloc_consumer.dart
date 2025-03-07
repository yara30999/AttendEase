import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../app/functions.dart';
import '../../../../resourses/colors_manager.dart';
import '../../../view_model/auth_bloc/auth_bloc.dart';

class ResetPasswordButton extends StatelessWidget {
  const ResetPasswordButton(this.formKey, this.email, {super.key});

  final String? email;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is ForgotPasswordSuccess) {
          showToast(
            context.tr('reset_password_mail_sent'),
            Theme.of(context).primaryColor,
          );
          Navigator.pop(context);
        }
        if (state is ForgotPasswordError) {
          showToast(state.errMessage, ColorsManager.softRed);
        }
      },
      builder: (context, state) {
        if (state is ForgotPasswordLoading) {
          return ElevatedButton(
            onPressed: null,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 10,
              children: [
                Text(context.tr('resetPassword_label')),
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
            if (formKey.currentState?.validate() ?? false) {
              context.read<AuthBloc>().add(
                ForgotPasswordRequested(email: email!),
              );
            }
          },
          child: Text(context.tr('resetPassword_label')),
        );
      },
    );
  }
}
