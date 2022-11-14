import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

//import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_doctor_app/app/models/repeat_duration_model.dart';
import 'package:hallo_doctor_doctor_app/app/models/repeat_model.dart';

import '../controllers/add_timeslot_controller.dart';
import 'package:intl/intl.dart';

class AddTimeslotView extends GetView<AddTimeslotController> {
  @override
  Widget build(BuildContext context) {
    List<int> durationList = [
      15,
      30,
      45,
      60,
    ];
    var dropdownDuration = durationList
        .map(
          (e) =>
          DropdownMenuItem(
            value: e.toString(),
            child: Text(e.toString() + ' Minute'.tr),
          ),
    )
        .toList();
    List<RepeatTimeslot> listRepeat = [
      controller.repeat,
      RepeatTimeslot(repeatText: 'Every Day'.tr, repeat: Repeat.EVERY_DAY),
      RepeatTimeslot(
          repeatText: 'Same Day Every Week'.tr,
          repeat: Repeat.SAME_DAY_EVERY_WEEK),
      RepeatTimeslot(
          repeatText: 'Same Day Every Month'.tr,
          repeat: Repeat.SAME_DAY_EVERY_MONTH),
    ];
    List<RepeatDuration> listRepeatDuration = [
      controller.repeatDuration,
      RepeatDuration(month: 3, monthText: '3 Month'.tr),
      RepeatDuration(month: 6, monthText: '6 Month'.tr),
      RepeatDuration(month: 12, monthText: '12 Month'.tr)
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Timeslot'.tr),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          FormBuilder(
            key: controller.formKey,
            child: Column(
              children: [
                FormBuilderDateTimePicker(
                  name: 'timeSlot',
                  inputType: InputType.time,
                  initialValue: controller.from_timeSlot,
                  format: DateFormat('hh:mm a'),
                  alwaysUse24HourFormat: false,
                  autocorrect: true,
                  enableInteractiveSelection: true,
                  timePickerInitialEntryMode: TimePickerEntryMode.input,
                  autofocus: false,
                  onChanged: (value) {
                    controller.from_timeSlot = DateTime(
                        controller.date.year,
                        controller.date.month,
                        controller.date.day,
                        value!.hour,
                        value.minute)
                        .toLocal();
                    controller.to_timeSlot = DateTime(
                        controller.date.year,
                        controller.date.month,
                        controller.date.day,
                        value!.hour,
                        value.minute)
                        .toLocal();
                  },
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.access_time),
                      labelText: "From: "),
                ),
                Divider(),
                FormBuilderDateTimePicker(
                  name: 'to_timeSlot',
                  inputType: InputType.time,
                  initialValue: controller.to_timeSlot,
                  format: DateFormat('hh:mm a'),
                  alwaysUse24HourFormat: false,
                  onChanged: (value) {
                    controller.to_timeSlot = DateTime(
                        controller.date.year,
                        controller.date.month,
                        controller.date.day,
                        value!.hour,
                        value.minute)
                        .toLocal();
                  },
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.access_time),
                      labelText: "To: "),
                ),
                Divider(),
                if (controller.editedTimeSlot == null)
                  FormBuilderDateTimePicker(
                    name: 'Date',
                    inputType: InputType.date,
                    initialValue: controller.date,
                    format: DateFormat('EEEE, dd MMMM, y'),
                    onChanged: (dateTime) {
                      controller.date = dateTime!;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.date_range_outlined)),
                  ),
                Divider(),
                GetBuilder<AddTimeslotController>(
                  builder: (_) {
                    return Visibility(
                      visible: !controller.isEditMode,
                      child: DropdownSearch<RepeatTimeslot>(
                        mode: Mode.MENU,
                        items: listRepeat,
                        itemAsString: (repeatTimeslot) =>
                        repeatTimeslot!.repeatText,
                        onChanged: (RepeatTimeslot? dropdown) {
                          if (dropdown != controller.repeat) {
                            controller.repeatDurationVisibility.value = true;
                          } else {
                            controller.repeatDurationVisibility.value = false;
                          }
                        },
                        selectedItem: controller.repeat,
                        dropdownSearchDecoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.refresh),
                            label: Text('Repeat Timeslot'.tr)),
                        onSaved: (RepeatTimeslot? repeat) {
                          controller.repeat = repeat!;
                        },
                      ),
                    );
                  },
                ),
                Divider(),
                Obx(
                      () =>
                      Visibility(
                        visible: controller.repeatDurationVisibility.value,
                        child: DropdownSearch<RepeatDuration>(
                          mode: Mode.MENU,
                          items: listRepeatDuration,
                          itemAsString: (repeatDuration) {
                            return repeatDuration!.monthText;
                          },
                          onChanged: print,
                          selectedItem: controller.repeatDuration,
                          dropdownSearchDecoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.date_range_outlined),
                              label: Text('Repeat for how long')),
                          onSaved: (RepeatDuration? repeatDuration) {
                            controller.repeatDuration = repeatDuration!;
                          },
                        ),
                      ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: 330,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.addTimeslot();
                        },
                        child: Text(
                          'Add'.tr,
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Note:",
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "When you click on the " +
                        " button, will be added the time period in which you are available, and the duration is divided into time slots of 15 minutes each.",
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
