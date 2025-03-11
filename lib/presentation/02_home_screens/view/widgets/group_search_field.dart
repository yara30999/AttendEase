import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../resourses/assets_manager.dart';
import '../../../resourses/colors_manager.dart';
import '../../../resourses/styles_manager.dart';
import '../../view_model/cubit/home_cubit.dart';

class GroupSearchField extends StatefulWidget {
  const GroupSearchField({super.key});

  @override
  State<GroupSearchField> createState() => _GroupSearchFieldState();
}

class _GroupSearchFieldState extends State<GroupSearchField> {
  final TextEditingController _textEditingController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _textEditingController.removeListener(_onSearchChanged);
    _textEditingController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged() {
    // Cancel the previous debounce timer
    _debounce?.cancel();

    // Start a new debounce timer when user stops typing :)
    _debounce = Timer(const Duration(seconds: 3), () {
      context.read<HomeCubit>().setSearchQuery(_textEditingController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textEditingController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: 'search_for_group'.tr(),
        hintStyle: Styles.style16Medium().copyWith(color: ColorsManager.grey),
        prefixIcon: IconButton(
          onPressed: null,
          icon: SvgPicture.asset(
            SvgAssets.search,
            colorFilter: ColorFilter.mode(ColorsManager.grey, BlendMode.srcIn),
          ),
        ),
      ),
    );
  }
}
