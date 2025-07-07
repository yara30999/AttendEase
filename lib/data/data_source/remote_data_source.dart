import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../app/encryption_helper.dart';
import '../../app/functions.dart';
import '../network/requests.dart';
import '../responses/group_response.dart';
import '../responses/history_response.dart';
import '../responses/permission_response.dart';
import '../responses/user_response.dart';

abstract class RemoteDataSource {
  Future<UserResponse> login(LoginRequest loginRequest);
  Future<void> register(RegisterRequest registerRequest);
  Future<void> forgotPassword(String email);
  Future<void> logout();
  Future<void> createGroup(CreateGroupRequest createGroupRequest);
  Stream<List<GroupResponse>> getGroups();
  Stream<String?> getCurrentUserGroupId();
  Stream<List<UserResponse>> getGroupMembersStream(String groupId);
  Future<GroupResponse> getGroupInfo(String groupId);
  Future<List<UserResponse>> getGroupMembers(String groupId);
  Future<List<HistoryResponse>> getUserHistory(String userId);
  Future<List<PermissionResponse>> getUserPermissions(String userId);
  Future<void> deleteUserFromGroup(String userId);
  Future<void> deleteGroup(String groupId);
  Future<void> currentUserjoinGroup(String groupId);
  Future<void> currentUserCheckIn(CheckInRequest checkInRequest);
  Future<void> currentUserCheckOut(CheckOutRequest checkOutRequest);
  Future<void> currentUserTakePermission(PermissionRequest permissionRequest);
  Future<bool> canUserCheckInOrHavePermissionToday(String groupId);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference groups = FirebaseFirestore.instance.collection('groups');
  CollectionReference usersHistroy = FirebaseFirestore.instance.collection(
    'usersHistory',
  );
  CollectionReference usersPermission = FirebaseFirestore.instance.collection(
    'usersPermission',
  );

  RemoteDataSourceImpl(this._firebaseAuth);

  @override
  Future<UserResponse> login(LoginRequest loginRequest) async {
    final UserCredential credential = await _firebaseAuth
        .signInWithEmailAndPassword(
          email: loginRequest.email,
          password: loginRequest.password,
        );
    //read doc
    DocumentSnapshot<Map<String, dynamic>> userDoc =
        await users.doc(credential.user?.uid).get()
            as DocumentSnapshot<Map<String, dynamic>>;
    UserResponse userData = UserResponse.fromFirestore(userDoc);
    return userData;
  }

  @override
  Future<void> register(RegisterRequest registerRequest) async {
    final UserCredential credential = await _firebaseAuth
        .createUserWithEmailAndPassword(
          email: registerRequest.email,
          password: registerRequest.password,
        );
    //write doc
    await users
        .doc(credential.user?.uid)
        .set(
          UserResponse(
            name: registerRequest.userName,
            email: registerRequest.email,
            role: registerRequest.role,
          ).toFirestore(),
        );
  }

  @override
  Future<void> forgotPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> createGroup(CreateGroupRequest createGroupRequest) async {
    //write doc
    String plainPassword = generateRandomPassword();
    // String salt = generateSalt();
    // String hashedPassword = hashPassword(plainPassword, salt);
    String encryptedPassword = EncryptionHelper.encryptPassword(plainPassword);
    await groups.doc().set(
      GroupResponse(
        name: createGroupRequest.name,
        // hashedPassword: hashedPassword,
        // salt: salt,
        password: encryptedPassword,
        checkIn: createGroupRequest.checkIn,
        checkOut: createGroupRequest.checkOut,
        days: createGroupRequest.days,
        location: createGroupRequest.location,
      ).toFirestore(),
    );
  }

  @override
  Stream<List<GroupResponse>> getGroups() {
    return groups
        .snapshots() // Listen to the collection as a stream
        .map((QuerySnapshot snapshot) {
          return snapshot.docs
              .map(
                (doc) => GroupResponse.fromFirestore(
                  doc as DocumentSnapshot<Map<String, dynamic>>,
                ),
              )
              .toList();
        });
  }

  @override
  Stream<String?> getCurrentUserGroupId() {
    String currentUserId = _firebaseAuth.currentUser?.uid ?? "";
    return users.doc(currentUserId).snapshots().map((
      DocumentSnapshot snapshot,
    ) {
      final data = snapshot.data() as Map<String, dynamic>?;
      return data?['groupId'] as String?;
    });
  }

  @override
  Stream<List<UserResponse>> getGroupMembersStream(String groupId) {
    return users
        .where('groupId', isEqualTo: groupId) // Filter by groupId
        .snapshots() // Listen to the collection as a stream
        .map((QuerySnapshot snapshot) {
          return snapshot.docs
              .map(
                (doc) => UserResponse.fromFirestore(
                  doc as DocumentSnapshot<Map<String, dynamic>>,
                ),
              )
              .toList();
        });
  }

  @override
  Future<GroupResponse> getGroupInfo(String groupId) async {
    //read doc
    DocumentSnapshot<Map<String, dynamic>> groupDoc =
        await groups.doc(groupId).get()
            as DocumentSnapshot<Map<String, dynamic>>;
    GroupResponse groupData = GroupResponse.fromFirestore(groupDoc);
    return groupData;
  }

  @override
  Future<List<UserResponse>> getGroupMembers(String groupId) async {
    QuerySnapshot<Map<String, dynamic>> usersQuery =
        await users
                .where('groupId', isEqualTo: groupId) // Filter by groupId
                .get()
            as QuerySnapshot<Map<String, dynamic>>;
    if (usersQuery.docs.isEmpty) {
      return []; // Return an empty list if no data exists
    }
    // map each doc to UserResponse , then return list.
    List<UserResponse> usersData = usersQuery.docs
        .map(
          (doc) => UserResponse.fromFirestore(
            doc as DocumentSnapshot<Map<String, dynamic>>,
          ),
        )
        .toList();
    return usersData;
  }

  @override
  Future<List<HistoryResponse>> getUserHistory(String userId) async {
    QuerySnapshot<Map<String, dynamic>> usersHistoryQuery =
        await usersHistroy
                .where('userId', isEqualTo: userId) // Filter by userId
                .get()
            as QuerySnapshot<Map<String, dynamic>>;
    if (usersHistoryQuery.docs.isEmpty) {
      return []; // Return an empty list if no data exists
    }
    // map each doc to HistoryResponse , then return list.
    List<HistoryResponse> usersHistoryData = usersHistoryQuery.docs
        .map(
          (doc) => HistoryResponse.fromFirestore(
            doc as DocumentSnapshot<Map<String, dynamic>>,
          ),
        )
        .toList();
    return usersHistoryData;
  }

  @override
  Future<List<PermissionResponse>> getUserPermissions(String userId) async {
    QuerySnapshot<Map<String, dynamic>> usersPermissionsQuery =
        await usersPermission
                .where('userId', isEqualTo: userId) // Filter by userId
                .get()
            as QuerySnapshot<Map<String, dynamic>>;
    if (usersPermissionsQuery.docs.isEmpty) {
      return []; // Return an empty list if no data exists
    }
    // map each doc to PermissionResponse , then return list.
    List<PermissionResponse> usersPermissionData = usersPermissionsQuery.docs
        .map(
          (doc) => PermissionResponse.fromFirestore(
            doc as DocumentSnapshot<Map<String, dynamic>>,
          ),
        )
        .toList();
    return usersPermissionData;
  }

  @override
  Future<void> deleteUserFromGroup(String userId) async {
    WriteBatch batch = _firestore.batch();
    // 1 update user groupId to be empty (delete from group effect)
    DocumentReference userRef = users.doc(userId);
    batch.update(userRef, {'groupId': null});

    // 2 then delete all the user's history data
    QuerySnapshot<Map<String, dynamic>> usersHistoryQuery =
        await usersHistroy
                .where('userId', isEqualTo: userId) // Filter by userId
                .get()
            as QuerySnapshot<Map<String, dynamic>>;
    for (QueryDocumentSnapshot doc in usersHistoryQuery.docs) {
      batch.delete(doc.reference);
    }

    // 3 then delete all the user's permissions data
    QuerySnapshot<Map<String, dynamic>> usersPermissionsQuery =
        await usersPermission
                .where('userId', isEqualTo: userId) // Filter by userId
                .get()
            as QuerySnapshot<Map<String, dynamic>>;
    for (QueryDocumentSnapshot doc in usersPermissionsQuery.docs) {
      batch.delete(doc.reference);
    }

    // 4 Commit the batch operation
    await batch.commit();
  }

  @override
  Future<void> deleteGroup(String groupId) async {
    WriteBatch batch = _firestore.batch();
    // 1 delete group from groups collection
    DocumentReference groupRef = groups.doc(groupId);
    batch.delete(groupRef);

    // 2 then delete all the user's history data associated with that group
    QuerySnapshot<Map<String, dynamic>> usersHistoryQuery =
        await usersHistroy
                .where('groupId', isEqualTo: groupId) // Filter by groupId
                .get()
            as QuerySnapshot<Map<String, dynamic>>;
    for (QueryDocumentSnapshot doc in usersHistoryQuery.docs) {
      batch.delete(doc.reference);
    }

    // 3 then delete all the user's permissions data associated with that group
    QuerySnapshot<Map<String, dynamic>> usersPermissionsQuery =
        await usersPermission
                .where('groupId', isEqualTo: groupId) // Filter by groupId
                .get()
            as QuerySnapshot<Map<String, dynamic>>;
    for (QueryDocumentSnapshot doc in usersPermissionsQuery.docs) {
      batch.delete(doc.reference);
    }

    // 4 then delete all the users associated with that group
    QuerySnapshot<Map<String, dynamic>> usersQuery =
        await users
                .where('groupId', isEqualTo: groupId) // Filter by groupId
                .get()
            as QuerySnapshot<Map<String, dynamic>>;
    for (QueryDocumentSnapshot doc in usersQuery.docs) {
      batch.update(doc.reference, {'groupId': null});
    }

    // 5 Commit the batch operation
    await batch.commit();
  }

  @override
  Future<void> currentUserjoinGroup(String groupId) async {
    String currentUserId = _firebaseAuth.currentUser?.uid ?? "";
    //update doc
    await users.doc(currentUserId).update({'groupId': groupId});
  }

  @override
  Future<void> currentUserCheckIn(CheckInRequest checkInRequest) async {
    String currentUserId = _firebaseAuth.currentUser?.uid ?? "";
    //write doc
    await usersHistroy
        .doc(checkInRequest.docId)
        .set(
          HistoryResponse(
            id: checkInRequest.docId,
            userId: currentUserId,
            groupId: checkInRequest.groupId,
            checkIn: checkInRequest.checkIn,
            checkOut: null,
          ).toFirestore(),
        );
  }

  @override
  Future<void> currentUserCheckOut(CheckOutRequest checkOutRequest) async {
    String currentUserId = _firebaseAuth.currentUser?.uid ?? "";

    //read the date of the old doc
    DocumentSnapshot<Map<String, dynamic>> historyDoc =
        await usersHistroy.doc(checkOutRequest.docId).get()
            as DocumentSnapshot<Map<String, dynamic>>;
    HistoryResponse OldData = HistoryResponse.fromFirestore(historyDoc);

    //update the checkOut of the same doc
    if (OldData.userId == currentUserId &&
        OldData.groupId == checkOutRequest.groupId) {
      //update doc
      await usersHistroy
          .doc(checkOutRequest.docId) //the same doc
          //only update checkOut
          .update({'check-out': checkOutRequest.checkOut});
    } else {
      //if it is not the same doc with the same id's
      throw Exception();
    }
  }

  @override
  Future<void> currentUserTakePermission(
    PermissionRequest permissionRequest,
  ) async {
    String currentUserId = _firebaseAuth.currentUser?.uid ?? "";
    //write doc
    await usersPermission.doc().set(
      PermissionResponse(
        userId: currentUserId,
        groupId: permissionRequest.groupId,
        date: permissionRequest.time,
        type: permissionRequest.typeString,
        message: permissionRequest.message,
      ).toFirestore(),
    );
  }

  @override
  Future<bool> canUserCheckInOrHavePermissionToday(String groupId) async {
    String currentUserId = _firebaseAuth.currentUser?.uid ?? "";

    // Get the start and end of today
    DateTime now = DateTime.now();
    DateTime startOfDay = DateTime(now.year, now.month, now.day);
    DateTime endOfDay = startOfDay
        .add(Duration(days: 1))
        .subtract(Duration(seconds: 1));
    //get the permission that have been taken today
    QuerySnapshot<Map<String, dynamic>> usersPermissionsQuery =
        await usersPermission
                .where('userId', isEqualTo: currentUserId)
                .where('groupId', isEqualTo: groupId)
                .where(
                  'date',
                  isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay),
                )
                .where(
                  'date',
                  isLessThanOrEqualTo: Timestamp.fromDate(endOfDay),
                )
                .get()
            as QuerySnapshot<Map<String, dynamic>>;
    //get the history that have been checked in today
    QuerySnapshot<Map<String, dynamic>> usersHistoryQuery =
        await usersHistroy
                .where('userId', isEqualTo: currentUserId)
                .where('groupId', isEqualTo: groupId)
                .where(
                  'check-in',
                  isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay),
                )
                .where(
                  'check-in',
                  isLessThanOrEqualTo: Timestamp.fromDate(endOfDay),
                )
                .get()
            as QuerySnapshot<Map<String, dynamic>>;
    if (usersHistoryQuery.docs.isNotEmpty) {
      return Future.error('You_have_check_in_today'.tr());
    }
    if (usersPermissionsQuery.docs.isNotEmpty) {
      return Future.error('You_have_Taken_permission_today'.tr());
    }
    return true;
  }
}
