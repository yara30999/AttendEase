import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../app/di.dart';
import '../../../../app/type_definitions.dart';
import '../../../../app/validation_service.dart';
import '../../../02_home_screens/view_model/theme_bloc/theme_bloc.dart';
import '../../../resourses/assets_manager.dart';
import '../../../resourses/colors_manager.dart';
import '../../../resourses/styles_manager.dart';

class CustomTextField extends StatefulWidget {
  final String? hint, label;
  final void Function(String)? onChanged;
  final Widget? prefixIcon, suffixIcon;
  final bool? fillColor;
  final TextInputType inputType;
  final ValidatorFunction? customValidator;
  final TextDirection? textDirection;

  const CustomTextField({
    super.key,
    required this.label,
    required this.inputType,
    required this.onChanged,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.fillColor,
    this.customValidator,
    this.textDirection,
  });

  static final validationService = instance<IValidationService>();

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isObscure = false;

  ValidatorFunction get _defaultValidator {
    switch (widget.inputType) {
      case TextInputType.name:
        return CustomTextField.validationService.validateName;
      case TextInputType.visiblePassword:
        return CustomTextField.validationService.validatePassword;
      case TextInputType.emailAddress:
        return CustomTextField.validationService.validateEmail;
      default:
        return CustomTextField.validationService.validateNotEmpty;
    }
  }

  Widget? _getPrefixIcon(ThemeMode themeMode) {
    ColorFilter colorFilter = const ColorFilter.mode(
      ColorsManager.grey,
      BlendMode.srcIn,
    );
    switch (widget.inputType) {
      case TextInputType.name:
        return SvgPicture.asset(
          SvgAssets.name,
          fit: BoxFit.scaleDown,
          colorFilter: colorFilter,
          height: 20,
        );
      case TextInputType.visiblePassword:
        return SvgPicture.asset(
          SvgAssets.password,
          fit: BoxFit.scaleDown,
          colorFilter: colorFilter,
          height: 20,
        );
      case TextInputType.emailAddress:
        return SvgPicture.asset(
          SvgAssets.email,
          fit: BoxFit.scaleDown,
          colorFilter: colorFilter,
          height: 20,
        );
      case TextInputType.text:
        return SvgPicture.asset(
          SvgAssets.group,
          fit: BoxFit.scaleDown,
          colorFilter: colorFilter,
          height: 5,
          width: 5,
        );
      default:
        return SvgPicture.asset(
          SvgAssets.name,
          fit: BoxFit.scaleDown,
          colorFilter: colorFilter,
          height: 20,
        );
    }
  }

  Widget? _getSuffixIcon(ThemeMode themeMode) {
    Color? color = ColorsManager.grey;
    switch (widget.inputType) {
      case TextInputType.visiblePassword:
        return IconButton(
          icon: Icon(
            isObscure ? Icons.visibility : Icons.visibility_off,
            color: color,
          ),
          onPressed: () {
            setState(() {
              isObscure = !isObscure;
            });
          },
        );
      default:
        return null;
    }
  }

  @override
  void initState() {
    super.initState();
    switch (widget.inputType) {
      case TextInputType.visiblePassword:
        isObscure = true;
      default:
        isObscure = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeBloc = BlocProvider.of<ThemeBloc>(context);
    return TextFormField(
      obscureText: isObscure,
      keyboardType: widget.inputType,
      textDirection: widget.textDirection,
      validator: widget.customValidator ?? _defaultValidator,
      onChanged: widget.onChanged,
      style: Styles.style16Medium(),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        hintText: widget.hint,
        labelText: widget.label,
        filled: widget.fillColor,
        fillColor: Theme.of(context).scaffoldBackgroundColor,
        prefixIcon:
            widget.prefixIcon ?? _getPrefixIcon(themeBloc.state.themeMode),
        suffixIcon:
            widget.suffixIcon ?? _getSuffixIcon(themeBloc.state.themeMode),
      ),
    );
  }
}
