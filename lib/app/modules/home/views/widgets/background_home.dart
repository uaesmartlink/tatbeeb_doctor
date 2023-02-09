import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_doctor_app/app/modules/home/views/widgets/switch.dart';
import '../../controllers/home_controller.dart';

class BackgroundHome extends StatelessWidget{

  final Widget widget1;
  final Widget widget2;
  final String text;
  final HomeController controller;

  const BackgroundHome({Key? key,required this.widget1,required this.widget2,required this.text, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          SafeArea(
            child: Container(
              height:MediaQuery.of(context).size.height/5.5,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  gradient:const LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [
                        Color(0xFF76e6da),
                        Color(0xFF1b4170),
                      ]
                  )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hello '.tr + text,
                          style: TextStyle(
                            color: Color(0xFFfafafa),
                            fontSize: 22,
                          )
                      ),
                      Text('Welcome Back!'.tr,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold
                          )
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  SwitchExample(controller),
                  widget1
                ],
              ),
            ),
          ),
          Positioned(
              left: 0,
              top: MediaQuery.of(context).size.height/5.3,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft:Radius.circular(35),
                    topRight:Radius.circular(35),
                  ),
                ),
                child: widget2,
              )
          ),
        ],
      ),
    );
  }
}