 import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../resourses/assets_manager.dart';
import '../../../../resourses/colors_manager.dart';
import '../../../../resourses/styles_manager.dart';

class CheckInOutBtns extends StatelessWidget {
  final bool isCheckedIn = false;
  final bool isCheckedOut = false;
  const CheckInOutBtns({super.key});

  @override
  Widget build(BuildContext context) {
    Color primary   =  Theme.of(context).brightness == Brightness.light ?ColorsManager.paleCream    :ColorsManager.grey ;
    Color secondery =  Theme.of(context).brightness == Brightness.light ?ColorsManager.emeraldGreen :ColorsManager.deepRed ;
    return Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  color: primary,
                  shape: BoxShape.circle,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (!isCheckedIn)
                      InkWell(
                        onTap: () {
                          // TODO: Check in logic
                        },
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              SvgAssets.checkIn,
                              fit: BoxFit.scaleDown,
                              height: 50,
                              colorFilter: ColorFilter.mode(
                                secondery,
                                BlendMode.srcIn,
                              ),
                            ),
                            Text(
                              context.tr('CheckIn'),
                              style: Styles.style24Bold().copyWith(
                                color: secondery,
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (isCheckedIn && !isCheckedOut)
                      InkWell(
                        onTap: () {
                          //TODO: Check out
                        },
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              SvgAssets.checkOut,
                              fit: BoxFit.scaleDown,
                              height: 50,
                              colorFilter: ColorFilter.mode(
                                secondery,
                                BlendMode.srcIn,
                              ),
                            ),

                            Text(
                              context.tr('CheckOut'),
                              style: Styles.style24Bold().copyWith(
                                color: secondery,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              );
  }}