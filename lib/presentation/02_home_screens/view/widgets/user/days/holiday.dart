import 'package:flutter/material.dart';
import '../../../../../../domain/entities/group_entity.dart';
import 'holi_animation.dart';

class Holiday extends StatelessWidget {
  final GroupEntity currentUserGroupEntity;
  const Holiday(this.currentUserGroupEntity, {super.key});

  @override
  Widget build(BuildContext context) {
    return HoliAnimation(currentUserGroupEntity.name);
  }
}
