import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget titleApp() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      /*Image.asset(
        'assets/icons/ic_launcher.png',
        width: 45,
        height: 45,
      ),
      SizedBox(
        width: 10,
      ),*/
      RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: 'Tatbeeb for'.tr,
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
                color: Colors.white,),
            children: [
              TextSpan(
                text: ' Doctor'.tr,
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ]),
      ),
    ],
  );
}
