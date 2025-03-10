import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  Future<GroupResponse> getGroupInfo(String groupId);
  Future<List<UserResponse>> getGroupMembers(String groupId);
  Future<List<HistoryResponse>> getUserHistory(String userId);
  Future<List<PermissionResponse>> getUserPermissions(String userId);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final FirebaseAuth _firebaseAuth;
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
    await groups.doc().set(
      GroupResponse(
        name: createGroupRequest.name,
        password: generateRandomPassword(),
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
    List<UserResponse> usersData =
        usersQuery.docs
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
    List<HistoryResponse> usersHistoryData =
        usersHistoryQuery.docs
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
    List<PermissionResponse> usersPermissionData =
        usersPermissionsQuery.docs
            .map(
              (doc) => PermissionResponse.fromFirestore(
                doc as DocumentSnapshot<Map<String, dynamic>>,
              ),
            )
            .toList();
    return usersPermissionData;
  }
}
