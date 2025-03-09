import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../app/di.dart';
import '../../01_auth_screens/view/widgets/custom_text_form_field.dart';
import '../../02_home_screens/view/widgets/custom_app_bar.dart';
import '../../02_home_screens/view/widgets/custom_drawer.dart';
import '../../resourses/styles_manager.dart';
import '../view_model/bloc/create_group_bloc.dart';
import 'widgets/create_group_btn_bloc_consumer.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: const CustomDrawer(),
      body: BlocProvider(
        create: (context) => CreateGroupBloc(instance()),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 14,
              children: [
                Center(
                  child: Text(
                    context.tr('Create_Work_Zone'),
                    style: Styles.style24Bold(),
                  ),
                ),
                CustomTextField(
                  label: context.tr('GroupName'),
                  inputType: TextInputType.text,
                  onChanged: (value) {
                    setState(() {
                      _groupName = value;
                    });
                  },
                ),
                Text(
                  context.tr('Choose_the_working_days:'),
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
                Text(
                  context.tr('Check_in_Time:'),
                  style: Styles.style16Medium(),
                ),
                TimePickerField(
                  initialTime: _checkInTime,
                  onTimeSelected: (time) {
                    setState(() {
                      _checkInTime = time;
                    });
                  },
                ),
                Text(
                  context.tr('Check_out_Time:'),
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
                  context.tr('Tap_on_the_map'),
                  style: Styles.style16Medium(),
                ),
                const LocationPicker(),
                CreateGroupButton(
                  _formKey,
                  _groupName,
                  _selectedDays,
                  _checkInTime,
                  _checkOutTime,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
