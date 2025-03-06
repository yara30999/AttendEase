import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as dui;
import '../../../app/di.dart';
import '../../../app/validation_service.dart';
import '../../resourses/assets_manager.dart';
import '../../resourses/routes_manager.dart';
import 'widgets/buttons/register_btn_bloc_consumer.dart';
import 'widgets/custom_text_form_field.dart';
import 'widgets/custom_text_row.dart';
import 'widgets/language_toggle_switch.dart';
import 'widgets/role_drop_down_button.dart';
import 'widgets/theme_toggle_switch.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  String? name;
  String? email;
  String? password;
  String? rePassword;
  String? role;
  final _formKey = GlobalKey<FormState>();
  final _validationService = instance<IValidationService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
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
                  Image.asset(
                    PngAssets.attendEaseLogo,
                    width: double.infinity,
                    height: 140,
                    fit: BoxFit.contain,
                  ),
                  CustomTextField(
                    label: context.tr('usernameLabel'),
                    inputType: TextInputType.name,
                    textDirection: dui.TextDirection.ltr,
                    onChanged: (value) {
                      setState(() {
                        name = value;
                      });
                    },
                  ),
                  const SizedBox(height: 24),
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
                  const SizedBox(height: 24),
                  CustomTextField(
                    label: context.tr('passwordLabel'),
                    inputType: TextInputType.visiblePassword,
                    textDirection: dui.TextDirection.ltr,
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                  ),
                  const SizedBox(height: 24),
                  CustomTextField(
                    label: context.tr('rePasswordLabel'),
                    inputType: TextInputType.visiblePassword,
                    textDirection: dui.TextDirection.ltr,
                    onChanged: (value) {
                      setState(() {
                        rePassword = value;
                      });
                    },
                    customValidator: (value) {
                      return _validationService.validateConfirmPassword(
                        value,
                        password,
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  const RoleDropdown(),
                  const SizedBox(height: 24),
                  RegisterButton(_formKey, name, email, password),
                  const SizedBox(height: 10),
                  CustomTextRow(
                    questionTxt: context.tr('haveAccount'),
                    clickTxt: context.tr('login_label'),
                    onTap: () {
                      //go back to login page
                      Navigator.pushReplacementNamed(
                        context,
                        Routes.loginRoute,
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.sizeOf(context).width * 0.35,
                    ),
                    child: const LanguageToggleSwitch(),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.sizeOf(context).width * 0.35,
                    ),
                    child: const ThemeToggleSwitch(),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
