import 'package:flutter/material.dart';

import 'widgets/custom_app_bar.dart';
import 'widgets/custom_drawer.dart';

class CheckInView extends StatefulWidget {
  const CheckInView({super.key});

  @override
  State<CheckInView> createState() => _CheckInViewState();
}

class _CheckInViewState extends State<CheckInView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: const CustomAppBar(),
      drawer: const CustomDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // time 
          // date 
          // state menu 
          // time row 
          // permission options
        ],
      ),
    );
  }
}