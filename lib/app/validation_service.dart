import 'package:easy_localization/easy_localization.dart';

abstract class IValidationService {
  String? validateName(String? value);
  String? validatePassword(String? value);
  String? validateConfirmPassword(String? value, String? originalPassword);
  String? validateEmail(String? value);
  String? validatePhone(String? value);
  String? validateNotEmpty(String? value);
}

class ValidationServiceImpl implements IValidationService {
  @override
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'emptyMsg'.tr();
    } else if (value.length < 3) {
      return 'usernameTooShort'.tr();
    } else if (value.length > 30) {
      return 'usernameTooLong'.tr();
    } else if (!RegExp(r'^[\p{L}0-9_\s]+$', unicode: true).hasMatch(value)) {
      return 'usernameNotValid'.tr();
    }
    return null;
  }

  @override
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'emptyMsg'.tr();
    } else if (!RegExp(r'^.{6,}$').hasMatch(value)) {
      return 'passwordNotValid'.tr();
    }
    return null;
  }

  @override
  String? validateConfirmPassword(String? value, String? originalPassword) {
    if (value == null || value.isEmpty) {
      return 'emptyMsg'.tr();
    } else if (!RegExp(r'^.{6,}$').hasMatch(value)) {
      return 'passwordNotValid'.tr();
    } else if (value != originalPassword) {
      return 'passwordsDoNotMatch'.tr();
    }
    return null;
  }

  @override
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'emptyMsg'.tr();
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+$")
        .hasMatch(value)) {
      return 'emailNotValid'.tr();
    }
    return null;
  }

  @override
  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    if (value.length < 11) {
      return "signup.phoneEmptyMessage".tr();
    }
    return null;
  }

  @override
  String? validateNotEmpty(String? value) {
    return value == null || value.isEmpty ? 'emptyMsg'.tr() : null;
  }
}
