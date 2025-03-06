import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../app/functions.dart';
import '../../01_auth_screens/view/widgets/custom_text_form_field.dart';
import '../../02_home_screens/view/widgets/custom_app_bar.dart';
import '../../02_home_screens/view/widgets/custom_drawer.dart';
import '../../resourses/colors_manager.dart';
import '../../resourses/styles_manager.dart';
import 'widgets/day_selector.dart';
import 'widgets/location_picker.dart';
import 'widgets/time_picker_field.dart';

class CreateGroupView extends StatefulWidget {
  const CreateGroupView({Key? key}) : super(key: key);

  @override
  State<CreateGroupView> createState() => _CreateGroupViewState();
}

class _CreateGroupViewState extends State<CreateGroupView> {
  final _formKey = GlobalKey<FormState>();
  String _groupName = '';
  final Set<int> _selectedDays = {};
  TimeOfDay _checkInTime = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _checkOutTime = const TimeOfDay(hour: 17, minute: 0);

  void _validateAndCreateGroup() {
    if (_formKey.currentState!.validate()) {
      if (_selectedDays.isEmpty) {
        showToast(context.tr("Please select working days"), ColorsManager.red);
        return;
      }
      // TODO: Implement group creation logic
    }
  }

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
            spacing: 14,
            children: [
              Center(
                child: Text(
                  context.tr('Create Work Zone'),
                  style: Styles.style24Bold(),
                ),
              ),
              CustomTextField(
                label: context.tr('Group Name'),
                inputType: TextInputType.text,
                onChanged: (value) {
                  setState(() {
                    _groupName = value;
                  });
                },
              ),
              Text(
                context.tr('Choose the working days:'),
                style: Styles.style16Medium(),
              ),
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
              Text(context.tr('Check-in Time:'), style: Styles.style16Medium()),
              TimePickerField(
                initialTime: _checkInTime,
                onTimeSelected: (time) {
                  setState(() {
                    _checkInTime = time;
                  });
                },
              ),
              Text(
                context.tr('Check-out Time:'),
                style: Styles.style16Medium(),
              ),
              TimePickerField(
                initialTime: _checkOutTime,
                onTimeSelected: (time) {
                  setState(() {
                    _checkOutTime = time;
                  });
                },
              ),
              Text(
                context.tr('Tap on the map to choose your work location:'),
                style: Styles.style16Medium(),
              ),
              const LocationPicker(),
              ElevatedButton(
                onPressed: _validateAndCreateGroup,
                child: Text(context.tr('Create Group')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
