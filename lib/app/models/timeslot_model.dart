import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_model.dart';

class TimeSlot {
  TimeSlot(
      {this.timeSlotId,
      this.timeSlot,
      this.pastTimeSlot,
      this.duration,
      this.price,
        this.bookedAmount,
        this.bookedDuration,
      this.available,
      this.doctorid,
      this.bookByWho,
      this.purchaseTime,
      this.status,
      this.parentTimeslotId});
  static const String _timeSlotId = 'timeSlotId';
  static const String _timeSlot = 'timeSlot';
  static const String _duration = 'duration';
  static const String _price = 'price';
  static const String _bookedDuration = 'bookedDuration';
  static const String _bookedAmount = 'bookedAmount';
  static const String _available = 'available';
  static const String _doctorId = 'doctorId';
  static const String _bookByWho = 'bookByWho';
  static const String _purchaseTime = 'purchaseTime';
  static const String _status = 'status';
  static const String _pastTimeSlot = 'pastTimeSlot';
  static const String _repeatTimeSlot = 'repeatTimeSlot';
  static const String _parentTimeslotId = 'parentTimeslotId';

  String? timeSlotId;
  DateTime? timeSlot;
  DateTime? pastTimeSlot;
  int? duration;
  double? price;
  double? bookedAmount;
  int? bookedDuration;
  bool? available;
  String? doctorid;
  UserModel? bookByWho;
  DateTime? purchaseTime;
  String? status;
  List<DateTime>? repeatTimeSlot;
  String? parentTimeslotId;

  factory TimeSlot.fromJson(Map<String, dynamic> json) {
    return TimeSlot(
        timeSlotId: json[_timeSlotId] as String?,
        timeSlot: (json[_timeSlot] as Timestamp).toDate(),
        pastTimeSlot: json[_pastTimeSlot] != null
            ? (json[_pastTimeSlot] as Timestamp).toDate()
            : null,
        duration: json[_duration] as int?,
        price: double.parse(json[_price].toString()),
        bookedAmount: json[_bookedAmount] != null ? double.parse(json['price'].toString()) : 0.0,
        bookedDuration: json[_bookedDuration] as int?,
        available: json[_available] as bool?,
        doctorid: json[_doctorId] as String?,
        bookByWho: json[_bookByWho] != null
            ? UserModel.fromJson(json[_bookByWho] as Map<String, dynamic>)
            : null,
        purchaseTime: json[_purchaseTime] != null
            ? (json[_purchaseTime] as Timestamp).toDate()
            : null,
        status: json[_status] as String?,
        parentTimeslotId: json[_parentTimeslotId] as String,
    );
  }

  Map<String, dynamic> toMap(TimeSlot timeSlot) {
    if (timeSlot.timeSlot == null) {
      return {
        _duration: timeSlot.duration,
        _price: timeSlot.price,
        _bookedDuration: timeSlot.bookedDuration,
        _bookedAmount: timeSlot.bookedAmount,
        _available: timeSlot.available,
        _doctorId: timeSlot.doctorid,
        _parentTimeslotId: timeSlot.parentTimeslotId
      };
    } else {
      return {
        _timeSlot: Timestamp.fromDate(timeSlot.timeSlot!),
        _duration: timeSlot.duration,
        _price: timeSlot.price,
        _bookedDuration: timeSlot.bookedDuration,
        _bookedAmount: timeSlot.bookedAmount,
        _available: timeSlot.available,
        _doctorId: timeSlot.doctorid,
        _parentTimeslotId: timeSlot.parentTimeslotId
      };
    }
  }
}
