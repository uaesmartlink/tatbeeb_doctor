import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

//import 'package:get_storage/get_storage.dart';
import 'package:hallo_doctor_doctor_app/app/models/doctor_category.dart';
import 'package:hallo_doctor_doctor_app/app/models/doctor_model.dart';
import 'package:hallo_doctor_doctor_app/app/modules/add_doctor_detail/views/pages/edit_image_page.dart';
import 'package:hallo_doctor_doctor_app/app/services/doctor_category_service.dart';
import 'package:hallo_doctor_doctor_app/app/services/doctor_service.dart';
import 'package:hallo_doctor_doctor_app/app/services/user_service.dart';

//import 'package:hallo_doctor_doctor_app/app/utils/constants.dart';
import 'package:hallo_doctor_doctor_app/app/utils/exceptions.dart';

class AddDoctorDetailController extends GetxController
    with StateMixin<List<DoctorCategory>> {
  //TODO: Implement AddDoctorDetailController

  final count = 0.obs;

  var formkey = GlobalKey<FormState>();
  var doctorName = ''.obs;
  var doctorPhone = ''.obs;
  var doctorHospital = 'English';
  var shortBiography = ''.obs;
  DoctorCategory? doctorCategory;
  Doctor? doctor = Get.arguments;
  var profilePicUrl = ''.obs;
  var certificateUrl = ''.obs;
  var name = ''.obs;
  bool isEdit = false;

  @override
  void onInit() {
    super.onInit();
    if (doctor != null) {
      isEdit = true;
      profilePicUrl.value = doctor!.doctorPicture!;
      doctorName.value = doctor!.doctorName!;
      doctorPhone.value = doctor!.doctorPhone!;
      doctorHospital = doctor!.doctorHospital!;
      shortBiography.value = doctor!.doctorShortBiography!;
      doctorCategory = doctor!.doctorCategory!;
      update();
    }
  }

  @override
  void onClose() {}

  void increment() => count.value++;

  void updateProfilePic(File filePath) {
    EasyLoading.show(maskType: EasyLoadingMaskType.black);
    UserService().updatePhoto(filePath).then((imgUrl) {
      profilePicUrl.value = imgUrl;
      Get.back();
    }).catchError((error) {
      Fluttertoast.showToast(
          msg: error.toString(), toastLength: Toast.LENGTH_LONG);
    }).whenComplete(() {
      EasyLoading.dismiss();
    });
  }

  void uploadCertificate(File filePath) {
    EasyLoading.show(maskType: EasyLoadingMaskType.black);
    UserService().updatePhoto(filePath).then((certifUrl) {
      certificateUrl.value = certifUrl;
      Get.back();
    }).catchError((error) {
      Fluttertoast.showToast(
          msg: error.toString(), toastLength: Toast.LENGTH_LONG);
    }).whenComplete(() {
      EasyLoading.dismiss();
    });
  }

  void toEditProfilePic() {
    Get.to(() => EditImagePage());
  }

  void initDoctorCategory() {
    DoctorCategoryService().getListDoctorCategory().then((doctorCategory) {
      change(doctorCategory, status: RxStatus.success());
    });
  }

  void saveDoctorDetail() async {
    /*
    if (profilePicUrl.value.isEmpty) {
      exceptionToast('Please choose your profile photo'.tr);
      return;
    }
     */
    if (certificateUrl.value.isEmpty) {
      exceptionToast('Please choose your certificate'.tr);
      return;
    }
    if (doctorCategory == null) {
      exceptionToast('Please chose doctor Specialty or Category'.tr);
      return;
    }
    if (formkey.currentState!.validate() && doctorCategory != null) {
      formkey.currentState!.save();
      EasyLoading.show(
          status: 'loading...'.tr, maskType: EasyLoadingMaskType.black);
      try {
        await DoctorService().saveDoctorDetail(
            doctorName: doctorName.value,
            doctorPhone: doctorPhone.value,
            hospital: doctorHospital,
            shortBiography: shortBiography.value,
            pictureUrl: profilePicUrl.value,
            certificateUrl: certificateUrl.value,
            doctorCategory: doctorCategory!,
            isUpdate: isEdit);
        Get.offNamed('/dashboard');
        EasyLoading.dismiss();
      } catch (e) {
        Fluttertoast.showToast(msg: e.toString());
        EasyLoading.dismiss();
      }
    }
  }

}
