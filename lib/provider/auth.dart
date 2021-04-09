import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class Auth with ChangeNotifier {
  final _auth = FirebaseAuth.instance;

  String _username;
  String _email;
  String _userId;
  String _userImageUrl;

  int _mathExercises;
  int _alphExercises;
  Map<String, dynamic> _completedExercises;

  bool _logado = false;

  String get userId {
    return _userId;
  }

  void _setUser(String username, String email, String userId,
      String userImageUrl, Map<String, dynamic> completedExercises) {
    this._username = username;
    this._email = email;
    this._userId = userId;
    this._userImageUrl = userImageUrl;
    this._completedExercises = completedExercises;

    this._mathExercises = 0;
    this._alphExercises = 0;
    _completedExercises.forEach((key, value) {
      if (key.contains('math') && value.toString() == 'true') {
        this._mathExercises++;
      }
      if (key.contains('alph') && value.toString() == 'true') {
        this._alphExercises++;
      }
    });
    this._logado = true;
    notifyListeners();
  }

  Map<String, dynamic> get currUser {
    return {
      'id': _userId,
      'username': _username,
      'email': _email,
      'image_url': _userImageUrl,
      'exercises': _completedExercises,
      'math': _mathExercises,
      'alph': _alphExercises,
    };
  }

  Future<void> signIn(String email, String password) async {
    try {
      UserCredential authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      final user = _auth.currentUser;
      final userData = await _getUserData(user);
      _setUser(userData.data()['username'], email, authResult.user.uid,
          userData.data()['image_url'], userData.data()['exercises']);
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
        'exercises': {}
      });
      _setUser(username, email, authResult.user.uid, url, {});
    } on PlatformException catch (error) {
      print('error log:' + error.toString());
      var message = 'Um erro ocorreu, por favor olhe usas credenciais';
      if (error.message != null) {
        message = error.message;
      }
      throw message;
    } catch (error) {
      print('error log:' + error.toString());
      throw error;
    }
  }

  Stream<User> tryAutoLogin() {
    return _auth.authStateChanges().map((user) {
      if (user == null) return null;

      if (!this._logado)
        Future.delayed(Duration(microseconds: 100)).then((value) async {
          final userData = await _getUserData(user);
          if (userData != null) if (userData.data() == null) return;
          _setUser(
              userData.data()['username'],
              userData.data()['email'],
              user.uid,
              userData.data()['image_url'],
              userData.data()['exercises']);
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
    _setUser(empty, empty, empty, empty, {});
    try {
      _auth.signOut();
    } catch (e) {
      print(e);
    }
    this._logado = false;
    notifyListeners();
  }

  Future<void> updateQuestion(String id) async {
    if (id.contains('math') || id.contains('alph')) {
      _completedExercises[id] = true;
      if (id.contains('math'))
        this._mathExercises++;
      else if (id.contains('alph')) this._alphExercises++;

      await FirebaseFirestore.instance
          .collection('users')
          .doc(this._userId)
          .update({'exercises': this._completedExercises});

      notifyListeners();
    }
  }
}
