import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as dui;
import '../../resourses/assets_manager.dart';
import 'widgets/buttons/reset_password_btn_bloc_consumer.dart';
import 'widgets/custom_text_form_field.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  String? email;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            right: 16,
            left: 16,
            //for the opening keyboard
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUnfocus,
            child: ListView(
              shrinkWrap: true,
              children: [
                const SizedBox(height: 100),
                Image.asset(
                  PngAssets.attendEaseLogo,
                  width: double.infinity,
                  height: 340,
                  fit: BoxFit.contain,
                ),
                CustomTextField(
                  label: context.tr('emailLabel'),
                  inputType: TextInputType.emailAddress,
                  textDirection: dui.TextDirection.ltr,
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                ),
                const SizedBox(height: 30),
                ResetPasswordButton(_formKey, email),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
