import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../resourses/routes_manager.dart';

class JoinGroupBtn extends StatelessWidget {
  final password ;
  const JoinGroupBtn({super.key, required this.password});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
          onPressed: () {
            //TODO: Implemnt join group logic 
            Navigator.pushReplacementNamed(context, Routes.CheckInRoute);
          
          },
          child: Text(context.tr("JoinGroupBtn")),
        );
  }
}