import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_doctor_app/app/modules/appointment/views/appointment_view.dart';
import 'package:hallo_doctor_doctor_app/app/modules/home/views/home_view.dart';
import 'package:hallo_doctor_doctor_app/app/modules/order/views/order_view.dart';
import 'package:hallo_doctor_doctor_app/app/modules/profile/views/profile_view.dart';
import 'package:hallo_doctor_doctor_app/app/styles/styles.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  final List<Widget> bodyContent = [
    HomeView(),
    AppointmentView(),
    OrderView(),
    ProfileView()
  ];
  void updateTabSelection(int index) {
    controller.selectedIndex = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => Center(
            child: IndexedStack(
                index: controller.selectedIndex, children: bodyContent),
          )),
      bottomNavigationBar: Obx(
        () => BottomAppBar(
          child: Container(
            margin: EdgeInsets.only(left: 12.0, right: 12.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  //update the bottom app bar view each time an item is clicked
                  onPressed: () {
                    updateTabSelection(0);
                  },
                  iconSize: 27,
                  icon: Icon(
                    Icons.home,
                    //darken the icon if it is selected or else give it a different color
                    color: controller.selectedIndex == 0
                        ? Color(0xFF1b4170)
                        : Colors.grey.shade400,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    controller.initTabAppointment();
                    updateTabSelection(1);
                  },
                  iconSize: 27.0,
                  icon: Icon(
                    Icons.calendar_today,
                    color: controller.selectedIndex == 1
                        ? Color(0xFF1b4170)
                        : Colors.grey.shade400,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    updateTabSelection(2);
                    controller.initTabOrder();
                  },
                  iconSize: 27.0,
                  icon: Icon(
                    Icons.format_list_bulleted,
                    color: controller.selectedIndex == 2
                        ? Color(0xFF1b4170)
                        : Colors.grey.shade400,
                  ),
                ),
               /* IconButton(
                  onPressed: () {
                    updateTabSelection(3);
                    //controller.initTabOrder();
                  },
                  iconSize: 27.0,
                  icon: Icon(
                    Icons.chat,
                    color: controller.selectedIndex == 3
                        ? Styles.primaryBlueColor
                        : Colors.grey.shade400,
                  ),
                ),*/
                IconButton(
                  onPressed: () {
                    updateTabSelection(3);
                  },
                  iconSize: 27.0,
                  icon: Icon(
                    Icons.person,
                    color: controller.selectedIndex == 3
                        ? Color(0xFF1b4170)
                        : Colors.grey.shade400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
