import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../resourses/colors_manager.dart';
import '../../../resourses/language_manager.dart';
import '../../../resourses/styles_manager.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
   Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(5),
      width: size.width * 0.8,
      height:  60,// size.height * 0.15,
      decoration: BoxDecoration(
        color: ColorsManager.grey,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        children: [
          TextFormField(
            textAlign: LocalizationUtils.isCurrentLocalAr(context) ? TextAlign.right : TextAlign.left,
            style: Styles.style16Medium(),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: context.tr("Search") ,
              hintStyle: Styles.style16Medium().copyWith(color: ColorsManager.black),
              prefixIcon:  Icon(Icons.search , color: ColorsManager.black),
            ),
          ),
         // IconButton(onPressed: () {}, icon: Icon(Icons.search , color: ColorsManager.black))
        ],
      ),
    );
  }
}