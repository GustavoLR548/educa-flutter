import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class Auth with ChangeNotifier {
  String _username;
  String _email;
  String _userId;
  String _userImageUrl;

  final _auth = FirebaseAuth.instance;

  String get userId {
    return _userId;
  }

  void _setUser(
      String username, String email, String userId, String userImageUrl) {
    this._username = username;
    this._email = email;
    this._userId = userId;
    this._userImageUrl = userImageUrl;
  }

  Map<String, String> get currUser {
    return {
      'id': _userId,
      'username': _username,
      'email': _email,
      'image_url': _userImageUrl
    };
  }

  Future<void> signIn(String email, String password) async {
    try {
      UserCredential authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      final user = _auth.currentUser;
      final userData = await _getUserData(user);
      _setUser(userData.data()['username'], email, authResult.user.uid,
          userData.data()['image_url']);
    } on PlatformException catch (error) {
      var message = 'Um erro ocorreu, por favor olhe usas credenciais';
      if (error.message != null) {
        message = error.message;
      }
      throw message;
    } catch (error) {
      throw error;
    }
  }

  Future<void> signUp(
      String username, String email, String password, File imageFile) async {
    try {
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final ref = FirebaseStorage.instance
          .ref()
          .child('user_image')
          .child(authResult.user.uid + '.jpg');

      await ref.putFile(imageFile);

      final url = await ref.getDownloadURL();

      await FirebaseFirestore.instance
          .collection('users')
          .doc(authResult.user.uid)
          .set({
        'username': username,
        'email': email,
        'image_url': url,
      });
      _setUser(username, email, authResult.user.uid, url);
    } on PlatformException catch (error) {
      var message = 'Um erro ocorreu, por favor olhe usas credenciais';
      if (error.message != null) {
        message = error.message;
      }
      throw message;
    } catch (error) {
      throw error;
    }
  }

  Stream<User> tryAutoLogin() {
    return _auth.authStateChanges().map((user) {
      if (user == null) return null;

      Future.delayed(Duration(microseconds: 100)).then((value) async {
        final userData = await _getUserData(user);
        _setUser(userData.data()['username'], userData.data()['email'],
            user.uid, userData.data()['image_url']);
      });

      return user;
    });
  }

  Future<DocumentSnapshot> _getUserData(User user) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
  }

  void logout() {
    String empty = '';
    _setUser(empty, empty, empty, empty);
    try {
      _auth.signOut();
    } catch (e) {
      print(e);
    }
  }
}
