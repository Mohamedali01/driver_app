import 'dart:async';
import 'dart:convert';
import 'package:driver_app/core/services/globaldatabase/save_user_global.dart';
import 'package:driver_app/core/services/localdatabase/save_user_local.dart';
import 'package:driver_app/model/user.dart';
import 'package:driver_app/view/auth/login_view.dart';
import 'package:driver_app/view/map_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  String? name, email, password, phone, userId;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> createUserWithEmailAndPass() async {
    try {
      _isLoading = true;
      notifyListeners();
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email!, password: password!);
      User? user = userCredential.user;
      if (user != null) {
        await saveData(userCredential);
        _isLoading = false;
        notifyListeners();
        Get.offAll(MapView());
        await Fluttertoast.showToast(
            msg: 'Congratulations! Email created successfully');
      }
    } catch (e) {
      print('Mohamed Ali createUserWithEmailAndPass error : ${e.toString()}');
      Get.snackbar('Error!!', e.toString(),
          backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signIn() async {
    try {
      _isLoading = true;
      notifyListeners();
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email!, password: password!);
      User? user = userCredential.user;
      if (user != null) {
        await getDataAndSaveLocal(user.uid);
        _isLoading = false;
        notifyListeners();
        Get.offAll(MapView());
        await Fluttertoast.showToast(msg: 'Logged in successfully');
      }
    } catch (e) {
      print('Mohamed Ali signIn error : ${e.toString()}');
      Get.snackbar('Error in signIn !!', e.toString(),
          backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    try {
      _isLoading = true;
      notifyListeners();
      await _firebaseAuth.signOut();
      await SaveUserLocal.clear();
      _isLoading = false;
      notifyListeners();
      Get.offAll(LoginView());
      await Fluttertoast.showToast(msg: 'Logged out successfully');
    } catch (e) {
      Get.snackbar('Error', 'Error in logout');
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> autoLogin() async {
    print('start');
    String? data = await SaveUserLocal.getData();
    UserModel userModel = UserModel.fromJson(json.decode(data!));
    email = userModel.email;
    name = userModel.name;
    phone = userModel.phone;
    userId = userModel.userId;
    print('end');
  }

  Future<void> saveData(UserCredential cred) async {
    UserModel userModel = UserModel(
        name: name,
        email: cred.user!.email,
        userId: cred.user!.uid,
        phone: phone);
    await SaveUserGlobal.saveData(userModel);
    await SaveUserLocal.setData(json.encode(userModel.toJson()));
  }

  Future<void> getDataAndSaveLocal(String localId) async {
    UserModel? userModel = await SaveUserGlobal.getData(localId);
    name = userModel!.name;
    phone = userModel.phone;
    email = userModel.email;
    userId = userModel.userId;
    await SaveUserLocal.setData(json.encode(userModel.toJson()));
  }

  bool get isAuth {
    User? user = _firebaseAuth.currentUser;
    return user != null;
  }
}
