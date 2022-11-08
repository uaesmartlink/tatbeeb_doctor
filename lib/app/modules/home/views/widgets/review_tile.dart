import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hallo_doctor_doctor_app/app/styles/styles.dart';

class ReviewTile extends StatelessWidget {
  const ReviewTile(
      {Key? key,
      required this.imgUrl,
      required this.name,
      required this.dateOrder})
      : super(key: key);
  final String imgUrl;
  final String name;
  final DateTime dateOrder;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      height: 68,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                color: Color(0x04000000),
                blurRadius: 10,
                spreadRadius: 10,
                offset: Offset(0.0, 8.0))
          ],
          color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox(
                width: 12,
              ),
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Styles.whiteGreyColor,
                  image: DecorationImage(
                    image: NetworkImage(imgUrl),
                  ),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Text(
                name,
                style: GoogleFonts.nunito(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
