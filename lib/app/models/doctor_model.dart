import 'dart:core';

import 'package:hallo_doctor_doctor_app/app/models/doctor_category.dart';

class Doctor {
  Doctor({
    required this.doctorId,
    required this.doctorName,
    required this.doctorPhone,
    required this.doctorPicture,
    required this.certificateUrl,
    required this.doctorPrice,
    required this.doctorShortBiography,
    required this.doctorCategory,
    required this.doctorHospital,
    required this.doctorBalance,
    required this.accountStatus,
    required this.isOnline,
  });

  static const String _doctorId = 'doctorId';
  static const String _doctorName = 'doctorName';
  static const String _doctorPhone = 'doctorPhone';
  static const String _doctorPicture = 'doctorPicture';
  static const String _certificateUrl = 'certificateUrl';
  static const String _doctorPrice = 'doctorBasePrice';
  static const String _doctorShortBiography = 'doctorBiography';
  static const String _doctorCategory = 'doctorCategory';
  static const String _doctorHospital = 'doctorHospital';
  static const String _doctorBalance = 'balance';
  static const String _accountStatus = 'accountStatus';
  static const String _isOnline = 'isOnline';

  String? doctorId;
  String? doctorName;
  String? doctorPhone;
  String? doctorPicture;
  String? certificateUrl;
  int? doctorPrice;
  String? doctorShortBiography;
  DoctorCategory? doctorCategory;
  String? doctorHospital;
  double? doctorBalance;
  String? accountStatus;
  bool? isOnline;

  factory Doctor.fromJson(Map<String, dynamic> data) {
    return Doctor(
      doctorId: data[_doctorId],
      doctorName: data[_doctorName],
      doctorPhone: data[_doctorPhone],
      doctorPicture: data[_doctorPicture],
      certificateUrl: data[_certificateUrl],
      doctorPrice: data[_doctorPrice],
      doctorShortBiography: data[_doctorShortBiography],
      doctorCategory: DoctorCategory.fromJson(data[_doctorCategory]),
      doctorHospital: data[_doctorHospital],
      doctorBalance: double.parse(((data[_doctorBalance]) ?? 0.0).toString()),
      accountStatus: data[_accountStatus],
      isOnline: data[_isOnline],
    );
  }
}
