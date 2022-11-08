import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BackgroundContainer extends StatelessWidget{
  final Widget widget;
  final String text;
  final IconData? icon;
  final VoidCallback? onTap;
  final int? isArrowBack;
  final int? isPadding;
  const BackgroundContainer({Key? key,required this.widget,required this.text,this.icon,this.onTap,this.isArrowBack,this.isPadding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          SafeArea(
            child: Container(
              height:105,
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
                children: [
                  if(isArrowBack==null)InkWell(
                    onTap:(){
                      Get.back();
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(9)),
                      ),
                      child: Icon(Icons.arrow_back_ios, color: Color(0xFF1b4170),size: 15,),
                    ),
                  ),
                  Text(text,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500
                      )
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: onTap,
                    icon: Icon(icon,color: Colors.white,size: 30,),
                  )
                ],
              ),
            ),
          ),
          Positioned(
              left: 0,
              top: 111,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                padding: (isPadding==null)?EdgeInsets.only(left: 20, right: 20):null,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft:Radius.circular(35),
                    topRight:Radius.circular(35),
                  ),
                ),
                child: widget,
              )
          ),
        ],
      ),
    );
  }
}