import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../../app/functions.dart';
import '../../../../domain/entities/group_entity.dart';
import 'admin/admin_group_card.dart';
import 'user/user_group_card.dart';

class GroupListView extends StatelessWidget {
  final bool isAdmin;
  const GroupListView({super.key, required this.isAdmin});

  List<GroupEntity> get groupsDummy => [
    GroupEntity(
      id: '12344722558631415',
      name: 'name',
      password: generateRandomPassword(),
      checkIn: DateTime.now(),
      checkOut: DateTime.now(),
      days: [0, 1, 2, 3, 4],
      location: GeoPoint(31.00256, 30.25615),
    ),
    GroupEntity(
      id: '12344722558631415',
      name: 'name',
      password: generateRandomPassword(),
      checkIn: DateTime.now(),
      checkOut: DateTime.now(),
      days: [0, 1, 2, 3, 4],
      location: GeoPoint(31.00256, 30.25615),
    ),
    GroupEntity(
      id: '12344722558631415',
      name: 'name',
      password: generateRandomPassword(),
      checkIn: DateTime.now(),
      checkOut: DateTime.now(),
      days: [0, 1, 2, 3, 4],
      location: GeoPoint(31.00256, 30.25615),
    ),
    GroupEntity(
      id: '12344722558631415',
      name: 'name',
      password: generateRandomPassword(),
      checkIn: DateTime.now(),
      checkOut: DateTime.now(),
      days: [0, 1, 2, 3, 4],
      location: GeoPoint(31.00256, 30.25615),
    ),
    GroupEntity(
      id: '12344722558631415',
      name: 'name',
      password: generateRandomPassword(),
      checkIn: DateTime.now(),
      checkOut: DateTime.now(),
      days: [0, 1, 2, 3, 4],
      location: GeoPoint(31.00256, 30.25615),
    ),
    GroupEntity(
      id: '12344722558631415',
      name: 'name',
      password: generateRandomPassword(),
      checkIn: DateTime.now(),
      checkOut: DateTime.now(),
      days: [0, 1, 2, 3, 4],
      location: GeoPoint(31.00256, 30.25615),
    ),
    GroupEntity(
      id: '12344722558631415',
      name: 'name',
      password: generateRandomPassword(),
      checkIn: DateTime.now(),
      checkOut: DateTime.now(),
      days: [0, 1, 2, 3, 4],
      location: GeoPoint(31.00256, 30.25615),
    ),
    GroupEntity(
      id: '12344722558631415',
      name: 'name',
      password: generateRandomPassword(),
      checkIn: DateTime.now(),
      checkOut: DateTime.now(),
      days: [0, 1, 2, 3, 4],
      location: GeoPoint(31.00256, 30.25615),
    ),
    GroupEntity(
      id: '12344722558631415',
      name: 'name',
      password: generateRandomPassword(),
      checkIn: DateTime.now(),
      checkOut: DateTime.now(),
      days: [0, 1, 2, 3, 4],
      location: GeoPoint(31.00256, 30.25615),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: groupsDummy.length, // Replace with actual group count
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        if (isAdmin) {
          return AdminGroupCard(groupEntity: groupsDummy[index]);
        } else {
          return UserGroupCard(groupEntity: groupsDummy[index]);
        }
      },
      padding: EdgeInsets.only(bottom: 20),
    );
  }
}
