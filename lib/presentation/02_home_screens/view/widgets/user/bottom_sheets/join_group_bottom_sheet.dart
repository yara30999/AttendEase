import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../app/di.dart';
import '../../../../../../app/functions.dart';
import '../../../../../../domain/entities/group_entity.dart';
import '../../../../../01_auth_screens/view/widgets/custom_text_form_field.dart';
import '../../../../../resourses/colors_manager.dart';
import '../../../../../resourses/language_manager.dart';
import '../../../../../resourses/styles_manager.dart';
import '../../../../view_model/join_group_cubit/join_group_cubit.dart';

class JoinGroupBottomSheet extends StatefulWidget {
  final GroupEntity groupEntity;
  const JoinGroupBottomSheet({super.key, required this.groupEntity});

  @override
  State<JoinGroupBottomSheet> createState() => _JoinGroupBottomSheetState();
}

class _JoinGroupBottomSheetState extends State<JoinGroupBottomSheet> {
  String? _password;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => JoinGroupCubit(instance()),
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
                Text(widget.groupEntity.name, style: Styles.style20Bold()),
                SizedBox(height: 10),
                CustomTextField(
                  label: context.tr('EnterGroupPass'),
                  inputType: TextInputType.visiblePassword,
                  onChanged: (value) {
                    setState(() {
                      _password = value;
                    });
                  },
                ),
                SizedBox(height: 10),
                // join group button.
                BlocConsumer<JoinGroupCubit, JoinGroupState>(
                  listener: (BuildContext context, JoinGroupState state) {
                    if (state is JoinGroupSuccess) {
                      showToast(
                        context.tr('group_joined_successfully'),
                        ColorsManager.grey,
                      );
                      //close the bottom sheet.
                      Navigator.pop(context);
                    }
                    if (state is JoinGroupError) {
                      showToast(
                        context.tr('something_went_wrong'),
                        ColorsManager.softRed,
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is JoinGroupLoading) {
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
                          //ckeck if the entered password is equal to the actual group password.
                          if (_password == widget.groupEntity.password) {
                            //this joining group will be using group-id
                            context.read<JoinGroupCubit>().joinGroup(
                              widget.groupEntity.id,
                            );
                          } else {
                            // wrong password
                            showToast(
                              context.tr("Wrong_password"),
                              ColorsManager.softRed,
                            );
                          }
                        }
                      },
                      child: Text(context.tr("JoinGroupBtn")),
                    );
                  },
                ),
                // cancel button.
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
