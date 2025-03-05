import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../resourses/language_manager.dart';
import '../../../resourses/styles_manager.dart';

class LanguageButton extends StatelessWidget {
  const LanguageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: const Icon(Icons.language_sharp),
          title: FittedBox(
            alignment: AlignmentDirectional.centerStart,
            fit: BoxFit.scaleDown,
            child: Text("language".tr(), style: Styles.style16Medium()),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Wrap(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio<Locale>(
                    value: LocalizationUtils.arabicLocal,
                    groupValue: context.locale,
                    onChanged: (value) {
                      context.setLocale(LocalizationUtils.arabicLocal);
                    },
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text('arabic'.tr(), style: Styles.style16Medium()),
                  ),
                ],
              ),
              const SizedBox(width: 10),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio<Locale>(
                    value: LocalizationUtils.englishLocal,
                    groupValue: context.locale,
                    onChanged: (value) {
                      context.setLocale(LocalizationUtils.englishLocal);
                    },
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text('english'.tr(), style: Styles.style16Medium()),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
