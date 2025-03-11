import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../../domain/entities/group_entity.dart';
import '../../../../01_auth_screens/view/widgets/custom_text_form_field.dart';
import '../../../../resourses/language_manager.dart';
import '../../../../resourses/styles_manager.dart';

class CustomBottomSheet extends StatefulWidget {
  final GroupEntity groupEntity;
  const CustomBottomSheet(this.groupEntity, {super.key});

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  String? _password;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUnfocus,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(context.tr('EnterGroupPass'), style: Styles.style20Bold()),
              SizedBox(height: 10),
              CustomTextField(
                label: '',
                inputType: TextInputType.visiblePassword,
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    //ckeck if the entered password is equal to the actuall group password.
                    if (_password == widget.groupEntity.password) {
                      //TODO: Implemnt join group logic
                      //this joining group will be using group-id
                      //Navigator.pushReplacementNamed(context, Routes.CheckInRoute);
                    }
                  }
                },
                child: Text(context.tr("JoinGroupBtn")),
              ),
              Align(
                alignment:
                    LocalizationUtils.isCurrentLocalAr(context)
                        ? Alignment.bottomLeft
                        : Alignment.bottomRight,
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(context.tr('Cancel')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
