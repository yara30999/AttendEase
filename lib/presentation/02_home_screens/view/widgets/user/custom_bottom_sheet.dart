import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../app/di.dart';
import '../../../../../app/functions.dart';
import '../../../../../domain/entities/group_entity.dart';
import '../../../../01_auth_screens/view/widgets/custom_text_form_field.dart';
import '../../../../resourses/colors_manager.dart';
import '../../../../resourses/language_manager.dart';
import '../../../../resourses/routes_manager.dart';
import '../../../../resourses/styles_manager.dart';
import '../../../view_model/current_user_join_group_cubit/current_user_join_group_cubit.dart';

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
    return BlocProvider(
      create: (context) => CurrentUserJoinGroupCubit(instance()),
      child: Container(
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
                BlocConsumer<
                  CurrentUserJoinGroupCubit,
                  CurrentUserJoinGroupState
                >(
                  listener: (context, state) {
                    if (state is CurrentUserJoinGroupSuccess) {
                      showToast(
                        context.tr('joined_group_successfully'),
                        ColorsManager.grey,
                      );
                      Navigator.pushReplacementNamed(
                        context,
                        Routes.CheckInRoute,
                      );
                    }
                    if (state is CurrentUserJoinGroupError) {
                      showToast(state.errMessage, ColorsManager.softRed);
                    }
                  },
                  builder: (context, state) {
                    if (state is CurrentUserJoinGroupLoading) {
                      return ElevatedButton(
                        onPressed: null,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          spacing: 10,
                          children: [
                            Text(context.tr("JoinGroupBtn")),
                            const CircularProgressIndicator(
                              color: ColorsManager.white,
                              strokeAlign:
                                  CircularProgressIndicator.strokeAlignInside,
                            ),
                          ],
                        ),
                      );
                    }
                    return ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Check if the entered password matches the group's password
                          if (_password == widget.groupEntity.password) {
                            // Call the use case to join the group
                            context.read<CurrentUserJoinGroupCubit>().joinGroup(
                              widget.groupEntity.id,
                            );
                          } else {
                            showToast(
                              context.tr('incorrect_password'),
                              ColorsManager.softRed,
                            );
                          }
                        }
                      },
                      child: Text(context.tr("JoinGroupBtn")),
                    );
                  },
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
      ),
    );
  }
}
