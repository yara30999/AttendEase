import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../app/functions.dart';
import '../../../../resourses/colors_manager.dart';
import '../../../../resourses/routes_manager.dart';
import '../../../view_model/auth_bloc/auth_bloc.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton(
    this.formKey,
    this.name,
    this.email,
    this.password, {
    super.key,
  });

  final GlobalKey<FormState> formKey;
  final String? name;
  final String? email;
  final String? password;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          showToast(tr('register_successfully'), ColorsManager.softRed);
          Navigator.pushReplacementNamed(context, Routes.loginRoute);
        }
        if (state is RegisterError) {
          showToast(state.errMessage, ColorsManager.softRed);
        }
      },
      builder: (context, state) {
        if (state is RegisterLoading) {
          return ElevatedButton(
            onPressed: null,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 10,
              children: [
                Text(tr("createAccount")),
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
                RegisterRequested(
                  fullName: name!,
                  email: email!,
                  password: password!,
                ),
              );
            }
          },
          child: Text(tr("createAccount")),
        );
      },
    );
  }
}
