import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as dui;
import '../../resourses/assets_manager.dart';
import '../../resourses/language_manager.dart';
import '../../resourses/routes_manager.dart';
import 'widgets/custom_divider_with_text.dart';
import 'widgets/custom_text_form_field.dart';
import 'widgets/custom_text_row.dart';
import 'widgets/language_toggle_switch.dart';
import 'widgets/buttons/login_btn_bloc_consumer.dart';
import 'widgets/theme_toggle_switch.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String? _email;
  String? _password;
  final _formKey = GlobalKey<FormState>();

  void loginWithGoogle() {}

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
                    height: 180,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 24),
                  CustomTextField(
                    label: context.tr('emailLabel'),
                    inputType: TextInputType.emailAddress,
                    textDirection: dui.TextDirection.ltr,
                    onChanged: (value) {
                      setState(() {
                        _email = value;
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
                        _password = value;
                      });
                    },
                  ),
                  Align(
                    alignment:
                        LocalizationUtils.isCurrentLocalAr(context)
                            ? Alignment.bottomLeft
                            : Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          Routes.forgotPasswordRoute,
                        );
                      },
                      child: Text(context.tr('forgotPassword')),
                    ),
                  ),
                  LoginButton(_formKey, _email, _password),
                  const SizedBox(height: 24),
                  CustomTextRow(
                    questionTxt: context.tr('doNotHaveAccount'),
                    clickTxt: context.tr('createAccount'),
                    onTap: () {
                      Navigator.pushReplacementNamed(
                        context,
                        Routes.registerRoute,
                      );
                    },
                  ),
                  CustomDividerWithText(label: context.tr('or')),
                  const SizedBox(height: 16),
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
