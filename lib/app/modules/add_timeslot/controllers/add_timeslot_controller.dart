import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_doctor_app/app/models/repeat_duration_model.dart';
import 'package:hallo_doctor_doctor_app/app/models/repeat_model.dart';
import 'package:hallo_doctor_doctor_app/app/models/timeslot_model.dart';
import 'package:hallo_doctor_doctor_app/app/modules/appointment/controllers/appointment_controller.dart';
import 'package:hallo_doctor_doctor_app/app/services/doctor_service.dart';
import 'package:hallo_doctor_doctor_app/app/services/timeslot_service.dart';
import 'package:jiffy/jiffy.dart';

import '../../../utils/number_format.dart';

class AddTimeslotController extends GetxController {
  late TimeOfDay timeSlot;
  DateTime date = Get.arguments[0]['date'].toLocal();
  late DateTime newDateTime;
  TimeSlot? editedTimeSlot = Get.arguments[0]['timeSlot'];
  double? price=0.0;
  int? duration = 15;
  bool available = true;
  final formKey = GlobalKey<FormBuilderState>();
  AppointmentController appointController = Get.find();
  RepeatTimeslot repeat =
      RepeatTimeslot(repeatText: 'Not Repeat'.tr, repeat: Repeat.NOT_REPEAT);
  RepeatDuration repeatDuration =
      RepeatDuration(month: 1, monthText: '1 Month'.tr); // month
  var repeatDurationVisibility = false.obs;
  var isRepeatedTimeslot = false;
  bool isEditMode = false;

  @override
  void onInit() {
    super.onInit();
    if (editedTimeSlot != null) {
      isEditMode = true;
      newDateTime = date;
      price = editedTimeSlot!.price;
      duration = editedTimeSlot!.duration;
      timeSlot = TimeOfDay.fromDateTime(editedTimeSlot!.timeSlot!);
      isRepeatedTimeslot =
          editedTimeSlot!.parentTimeslotId != null ? true : false;
      update();
    } else {
      newDateTime = date;
      timeSlot = TimeOfDay.fromDateTime(date);
    }
  }

  @override
  void onClose() {}

  void addTimeslot() async {
    try {
      DateTime formattedDateTime =
      DateTime(newDateTime.year, newDateTime.month, newDateTime.day, 24);
      if (formattedDateTime.compareTo(DateTime.now()) < 0) {
        Fluttertoast.showToast(msg: 'Date Time is in the past'.tr);
        return;
      }
      final validationSuccess = formKey.currentState!.validate();
      if (validationSuccess) {
        formKey.currentState!.save();
        if (repeat.repeat != Repeat.NOT_REPEAT) {
          var timeslotUploadId = await addOneTimeSlot(isParent: true);
          List<DateTime> listRepeatTimeslot = _generateRepeatTimeslot(repeat, repeatDuration);
          await addRepeatTimeSlot(listRepeatTimeslot, timeslotUploadId);
        } else {
          await addOneTimeSlot();
        }
        Fluttertoast.showToast(msg: 'Success adding Timeslot'.tr);
        appointController.updateEventsCalendar();
        Get.back();
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void editTimeSlot() async {
    calculatePrice();
    DateTime formattedDateTime =
        DateTime(newDateTime.year, newDateTime.month, newDateTime.day, 24);
    if (formattedDateTime.compareTo(DateTime.now()) < 0) {
      Fluttertoast.showToast(msg: 'Date Time is in the past'.tr);
      return;
    }
    final validationSuccess = formKey.currentState!.validate();
    if (validationSuccess) {
      formKey.currentState!.save();
      if (isRepeatedTimeslot) {
        bool? result = await Get.defaultDialog(
            title: 'Edit Linked TimeSlot'.tr,
            middleText:
                'This timeslot is connected to several timeslots that were previously created together, do you also want to edit all timeslots that are connected to this timeslot'
                    .tr,
            radius: 15,
            textCancel: 'Edit Only this Timeslot'.tr,
            textConfirm: 'Edit All Connected Timeslot'.tr,
            onConfirm: () {
              Get.back(result: true);
            },
            onCancel: () {
              Get.back(result: false);
            });
        if (result!) {
          editedTimeSlot!.timeSlot = newDateTime;
          editedTimeSlot!.price = price;
          editedTimeSlot!.duration = duration;
          TimeSlotService()
              .updateRepeatedTimeSlot(editedTimeSlot!)
              .then((value) {
            Fluttertoast.showToast(msg: 'Success editing timeslot'.tr);
            appointController.updateEventsCalendar();
            Get.back(closeOverlays: true);
          });
        } else {
          editedTimeSlot!.timeSlot = newDateTime;
          editedTimeSlot!.price = price;
          editedTimeSlot!.duration = duration;
          TimeSlotService().updateTimeSlot(editedTimeSlot!).then((value) {
            Fluttertoast.showToast(msg: 'Success editing timeslot'.tr);
            appointController.updateEventsCalendar();
            Get.back(closeOverlays: true);
          });
        }
      } else {
        editedTimeSlot!.timeSlot = newDateTime;
        editedTimeSlot!.price = price;
        editedTimeSlot!.duration = duration;
        TimeSlotService().updateTimeSlot(editedTimeSlot!).then((value) {
          Fluttertoast.showToast(msg: 'Success editing timeslot'.tr);
          appointController.updateEventsCalendar();
          Get.back(closeOverlays: true);
        });
      }
    }
  }

  List<DateTime> _generateRepeatTimeslot(
      RepeatTimeslot repeatTimeslot, RepeatDuration repeatDuration) {
    List<DateTime> listDateTimeRepeat = [];
    switch (repeatTimeslot.repeat) {
      case Repeat.EVERY_DAY:
        int daysInMonth = Jiffy(newDateTime).daysInMonth;
        for (int i = 1; i < daysInMonth; i++) {
          DateTime dateRepeat = Jiffy(newDateTime).add(days: i).dateTime;
          listDateTimeRepeat.add(dateRepeat);
        }
        break;
      case Repeat.SAME_DAY_EVERY_WEEK:
        int week = 4 * repeatDuration.month;
        for (int i = 1; i <= week; i++) {
          DateTime dateRepeat = Jiffy(newDateTime).add(weeks: i).dateTime;
          listDateTimeRepeat.add(dateRepeat);
        }
        break;
      case Repeat.SAME_DAY_EVERY_MONTH:
        for (int i = 1; i <= repeatDuration.month; i++) {
          DateTime dateRepeat = Jiffy(newDateTime).add(months: i).dateTime;
          listDateTimeRepeat.add(dateRepeat);
        }
        break;
      default:
        return listDateTimeRepeat;
    }
    return listDateTimeRepeat;
  }

  Future deleteTimeSlot() async {
    if (isRepeatedTimeslot) {
      bool? result = await Get.defaultDialog(
          title: 'Delete Linked TimeSlot'.tr,
          middleText:
              'This timeslot is connected to several timeslots that were previously created simultaneously, do you also want to delete all timeslots that are connected to this timeslot'
                  .tr,
          radius: 15,
          textCancel: 'Cancel'.tr,
          textConfirm: 'Delete'.tr,
          onConfirm: () {
            Get.back(result: true);
          },
          onCancel: () {
            Get.back(result: false);
          });

      if (result == true) {
        await deleteRepeatedTimeslot();
      } else {
        await deleteOneTimeSlot();
      }
    } else {
      await deleteOneTimeSlot();
    }
  }

  Future deleteRepeatedTimeslot() async {
    TimeSlotService().deleteRepeatedTimeSlot(editedTimeSlot!).then((value) {
      Fluttertoast.showToast(msg: 'Success delete timeslot'.tr);
      appointController.updateEventsCalendar();
      Get.back(closeOverlays: true);
    });
  }

  Future deleteOneTimeSlot() async {
    TimeSlotService().deleteTimeSlot(editedTimeSlot!).then((value) {
      Fluttertoast.showToast(msg: 'Success delete timeslot'.tr);
      appointController.updateEventsCalendar();
      Get.back(closeOverlays: true);
    });
  }

   calculatePrice(){
   int doctorPrice= DoctorService.doctor!.doctorPrice!;
   switch(duration){
     case 15:{
       price=NumberFormatted().formatNumber(doctorPrice/4);
       break;
     }
     case 30:{
        price=NumberFormatted().formatNumber(doctorPrice/2);
        break;
     }
     case 45:{
        return price=NumberFormatted().formatNumber(doctorPrice/3);
     }
     case 60:{
         price=doctorPrice/1;
         break;
     }
   }
  }

  Future<String> addOneTimeSlot({bool isParent = false}) async {
    calculatePrice();
    String timeSlotId = await TimeSlotService().saveDoctorTimeslot(
        dateTime: newDateTime,
        price: price!,
        duration: duration!,
        available: available,
        isParentTimeslot: isParent);
    /*if (price! < DoctorService.doctor!.doctorPrice!) {
      await DoctorService().updateDoctorBasePrice(price!);
    }*/
    return timeSlotId;
  }

  addRepeatTimeSlot(
      List<DateTime> listRepeatTimeslot, String parentTimeslotId) async {
    calculatePrice();
    await TimeSlotService().saveMultipleTimeslot(
        dateTime: newDateTime,
        price: price!,
        duration: duration!,
        available: available,
        repeatTimeslot: listRepeatTimeslot,
        parentTimeslotId: parentTimeslotId);
    /*if (price! < DoctorService.doctor!.doctorPrice!) {
      await DoctorService().updateDoctorBasePrice(price!);
    }*/
  }
}
