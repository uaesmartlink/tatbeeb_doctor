import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import '../../widgets/background_container.dart';
import '../controllers/appointment_controller.dart';

enum TimeSlotViewType { add, edit }

class AppointmentView extends GetView<AppointmentController> {
  final DateTime dateTimePast = Jiffy(DateTime.now().toUtc())
      .subtract(months: 1)
      .dateTime; //range calendar 1 month past from now
  final DateTime dateTimeFuture =
      Jiffy(DateTime.now().toUtc()).add(months: 6).dateTime; //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BackgroundContainer(
          text: 'Calender'.tr,
          isArrowBack: 0,
          widget: SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  child: controller.obx(
                    (data) => GetBuilder<AppointmentController>(
                      builder: (controller) => TableCalendar(
                        headerStyle: HeaderStyle(
                          titleCentered: true,
                          formatButtonDecoration: BoxDecoration(
                            color: Color(0xFF1b4170),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          formatButtonTextStyle: TextStyle(color: Colors.white),
                          formatButtonShowsNext: false,
                        ),
                        focusedDay: controller.selectedDay.value,
                        firstDay: dateTimePast,
                        lastDay: dateTimeFuture,
                        eventLoader: controller.getEventsfromDay,
                        selectedDayPredicate: (day) {
                          return isSameDay(controller.selectedDay.value, day);
                        },
                        onDaySelected: (selectedDay, focusedDay) {
                          controller.selectedDay.value = selectedDay;
                          controller.focusDay.value = focusedDay;
                          controller.updateEventList(selectedDay);
                        },
                        onFormatChanged: (format) {
                          controller.calendarFormat = format;
                        },
                        onPageChanged: (foucusDay) {},
                        calendarStyle: CalendarStyle(
                            canMarkersOverflow: true,
                            todayTextStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                color: Colors.white)),
                        calendarBuilders: CalendarBuilders(
                          selectedBuilder: (context, date, events) => Container(
                              margin: const EdgeInsets.all(4.0),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Color(0xFF76e6da),
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Text(
                                date.day.toString(),
                                style: TextStyle(color: Colors.white),
                              )),
                          todayBuilder: (context, date, events) => Container(
                            margin: const EdgeInsets.all(4.0),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Text(
                              date.day.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text("Expired appointments will not be shown"),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 300),
                  child: GetBuilder<AppointmentController>(
                    builder: (_) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _.eventSelectedDay.length,
                        itemBuilder: (context, index) {
                          return Card(
                            color: _.eventSelectedDay[index].available == true
                                ? Colors.white
                                : Colors.green[300],
                            child: ListTile(
                              title: _.eventSelectedDay[index].available == true
                                  ? Text(
                                      "Time Slot at ".tr +
                                          DateFormat("hh:mm a").format(_
                                              .eventSelectedDay[index]
                                              .timeSlot!),
                                    )
                                  : Text(
                                      "Time Slot at ".tr +
                                          DateFormat("hh:mm a").format(_
                                              .eventSelectedDay[index]
                                              .timeSlot!) +
                                          " to " +
                                          "${_.eventSelectedDay[index].bookedDuration} minutes" +
                                          ' has been Appointment'.tr,
                                    ),
                              subtitle: Text(
                                DateFormat("EEEE, dd MMMM, yyyy").format(
                                    _.eventSelectedDay[index].timeSlot!),
                              ),
                              trailing: _.eventSelectedDay[index].available ==
                                      true
                                  ? IconButton(
                                      onPressed: () =>
                                          controller.deleteOneTimeSlot(
                                              _.eventSelectedDay[index]),
                                      icon: Icon(Icons.delete))
                                  : IconButton(
                                      icon: Icon(
                                          Icons.check_circle_outline_outlined),
                                      onPressed: () {
                                        /*   controller.dashboardController
                                            .selectedIndex = 2;*/
                                        Get.toNamed('/order-detail',
                                            arguments:
                                                _.eventSelectedDay[index]);
                                      },
                                    ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Get.toNamed('/add-timeslot', arguments: [
              {
                'date': controller.selectedDay.value,
                'allTimeSlots': controller.timeSlots,
              }
            ]);
          },
          label: Text('Add Timeslot'.tr),
          icon: Icon(Icons.add),
          backgroundColor: Color(0xFF1b4170),
        ));
  }
}
