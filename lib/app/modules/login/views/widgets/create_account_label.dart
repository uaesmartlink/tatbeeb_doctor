import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_doctor_app/app/styles/styles.dart';

Widget createAccountLabel(VoidCallback onTap) {
  return InkWell(
    onTap: onTap,
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      padding: EdgeInsets.all(15),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Don\'t have an account ?'.tr,
            style: TextStyle(color:Colors.white,fontSize: 18, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            'Register'.tr,
            style: TextStyle(
                color: Color(0xFF125a9a),
                fontSize: 18,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    ),
  );
}
