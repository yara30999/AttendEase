import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../01_auth_screens/view/widgets/custom_text_form_field.dart';
import '../../../../resourses/styles_manager.dart';
import 'join_group_btn.dart';

class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet({super.key});

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  String? _password;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * .25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(context.tr('EnterGroupPass'), style: Styles.style20Bold()),
            SizedBox(height: 10),
            CustomTextField(
              label: " ",
              inputType: TextInputType.visiblePassword,
              onChanged: (value) {
                setState(() {
                  _password = value;
                });
              },
            ),
            SizedBox(height: 10,),
            Center(child: JoinGroupBtn(password: _password)),
          ],
        ),
      ),
    );
  }
}
