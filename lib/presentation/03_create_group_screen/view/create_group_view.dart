import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../app/functions.dart';
import '../../01_auth_screens/view/widgets/custom_text_form_field.dart';
import '../../02_home_screens/view/widgets/custom_app_bar.dart';
import '../../02_home_screens/view/widgets/custom_drawer.dart';
import '../../resourses/assets_manager.dart';
import '../../resourses/colors_manager.dart';
import '../../resourses/styles_manager.dart';
import 'widgets/day_selector.dart';
import 'widgets/location_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../app/di.dart';
import '../../../app/validation_service.dart';
import '../../resourses/assets_manager.dart';
import '../../resourses/colors_manager.dart';
import '../../resourses/styles_manager.dart';
import 'widgets/time_picker_field.dart';

class CreateGroupView extends StatefulWidget {
  const CreateGroupView({Key? key}) : super(key: key);

  @override
  State<CreateGroupView> createState() => _CreateGroupViewState();
}

class _CreateGroupViewState extends State<CreateGroupView> {
  final _formKey = GlobalKey<FormState>();
  final _validationService = instance<IValidationService>();
  String _groupName = '';
  final Set<int> _selectedDays = {};
  TimeOfDay _checkInTime = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _checkOutTime = const TimeOfDay(hour: 17, minute: 0);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Text(
                  'Create Work Zone'.tr(),
                  style: Styles.style24Bold(),
                ),
              ),
              const SizedBox(height: 16),
              // Group Name Field
              // Group Name Field
              CustomTextField(
                label: 'Group Name'.tr(),
                inputType: TextInputType.name,
                onChanged: (value) {
                  setState(() {
                    _groupName = value;
                  });
                },
                customValidator: _validationService.validateNotEmpty,
                prefixIcon: SvgPicture.asset(
                  SvgAssets.name,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).primaryColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Working Days Selection
              Text(
                'Choose the working days:'.tr(),
                style: Styles.style16Medium(),
              ),
              const SizedBox(height: 12),
              DaySelector(
                selectedDays: _selectedDays,
                onDaySelected: (day) {
                  setState(() {
                    if (_selectedDays.contains(day)) {
                      _selectedDays.remove(day);
                    } else {
                      _selectedDays.add(day);
                    }
                  });
                },
              ),
              const SizedBox(height: 24),
              // Check-in Time
              Text(
                'Check-in Time:'.tr(),
                style: Styles.style16Medium(),
              ),
              const SizedBox(height: 8),
              TimePickerField(
                initialTime: _checkInTime,
                onTimeSelected: (time) {
                  setState(() {
                    _checkInTime = time;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Check-out Time
              Text(
                'Check-out Time:'.tr(),
                style: Styles.style16Medium(),
              ),
              const SizedBox(height: 8),
              TimePickerField(
                initialTime: _checkOutTime,
                onTimeSelected: (time) {
                  setState(() {
                    _checkOutTime = time;
                  });
                },
              ),
              const SizedBox(height: 24),

              // Map Location Selection
              Text(
                'Tap on the map to choose your work location:'.tr(),
                style: Styles.style16Medium(),
              ),
              const SizedBox(height: 12),
              const LocationPicker(),
              const SizedBox(height: 24),

              // Create Button
              ElevatedButton(
                onPressed: _validateAndCreateGroup,
                child: Text('Create Group'.tr()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _validateAndCreateGroup() {
    if (_formKey.currentState!.validate()) {
      if (_selectedDays.isEmpty) {
        showToast("Please select working days".tr(), ColorsManager.red);
        return;
      }
      // TODO: Implement group creation logic
    }
  }
}