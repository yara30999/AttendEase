import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../network/requests.dart';
import '../responses/user_response.dart';

abstract class RemoteDataSource {
  Future<UserResponse> login(LoginRequest loginRequest);
  Future<void> register(RegisterRequest registerRequest);
  Future<void> forgotPassword(String email);
  Future<void> logout();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

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
}
