import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_doctor_app/app/services/auth_service.dart';

class RegisterController extends GetxController {
  //TODO: Implement RegisterController

  final count = 0.obs;
  var formkey = GlobalKey<FormState>();
  var username = '';
  var email = '';
  var password = '';
  var passwordVisible = false;

  @override
  void onClose() {}
  void increment() => count.value++;

  void signUpUser() async {
    if (formkey.currentState!.validate()) {
      formkey.currentState!.save();
      EasyLoading.show(
          status: 'loading...'.tr, maskType: EasyLoadingMaskType.black);
      AuthService().regiterNewUser(username, email, password).then((value) {
        Get.offAllNamed('/add-doctor-detail');
      }).onError((error, stackTrace) {
        Fluttertoast.showToast(
            msg: error.toString(), toastLength: Toast.LENGTH_LONG);
      }).whenComplete(() {
        EasyLoading.dismiss();
      });
    }
  }

  void passwordIconVisibility() {
    passwordVisible = !passwordVisible;
    update();
  }
}
