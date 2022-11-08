import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_doctor_app/app/modules/widgets/empty_list_widget.dart';
import '../../widgets/background_container.dart';
import '../controllers/order_controller.dart';
import 'package:intl/intl.dart';

class OrderView extends GetView<OrderController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BackgroundContainer(
          text: 'Appointment'.tr,
          isArrowBack: 0,
          isPadding: 0,
          widget: controller.obx(
            (listOrder) => ListView.builder(
              padding: const EdgeInsets.all(20),
              shrinkWrap: true,
              itemCount: listOrder!.length,
              itemBuilder: (builder, index) {
                return Container(
                  margin: const EdgeInsets.only(top:10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 40,
                        )
                      ]
                  ),
                  child: ListTile(
                    onTap: () {
                      Get.toNamed('/order-detail', arguments: listOrder[index]);
                    },
                    leading: CircleAvatar(
                        backgroundImage: listOrder[index]
                                .bookByWho!
                                .photoUrl!
                                .isNotEmpty
                            ? NetworkImage(
                                listOrder[index].bookByWho!.photoUrl!)
                            : AssetImage('assets/images/default-profile.png')
                                as ImageProvider),
                    title: Text('Appointment with '.tr +
                        listOrder[index].bookByWho!.displayName!),
                    subtitle: Text(
                      'at '.tr +
                          DateFormat('EEEE, dd, MMMM')
                              .format(listOrder[index].purchaseTime!),
                    ),
                    trailing: Wrap(
                      spacing: 5,
                      children: [Icon(Icons.arrow_forward_ios)],
                    ),
                  ),
                );
              },
            ),
            onEmpty: Center(child: EmptyList(msg: 'no order'.tr)),
          ),
        ));
  }
}
