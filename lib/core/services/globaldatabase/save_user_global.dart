import 'package:driver_app/exception/http_exception.dart';
import 'package:driver_app/model/user.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class SaveUserGlobal {
  static Future<void> saveData(UserModel userModel) async {
    FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
    await firebaseDatabase
        .reference()
        .child('users')
        .child(userModel.userId)
        .set(userModel.toJson());
  }

  static Future<UserModel?> getData(String userId) async {
    DataSnapshot? dataSnapshot;
    try {
      dataSnapshot = await FirebaseDatabase.instance
          .reference()
          .child('users')
          .child(userId)
          .once();
    } catch (e) {
      Get.snackbar('Error!!', 'Error in retrieving data');
      throw HttpException('Error in retrieving data');
    }
    return UserModel.fromJson(dataSnapshot.value);
  }
}
