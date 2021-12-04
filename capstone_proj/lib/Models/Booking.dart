import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class Booking {
  String locTitle;
  double price;
  String rules;
  String bookingId = UniqueKey().toString();
  String picUrl;
  String contactInfo;
  String description;
  String ownerId;
  String locId;
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now();

  //calendar stuff here

  Booking();

  Map<String, dynamic> toJson() => {
        'locTitle': locTitle,
        'locId': locId,
        'price': price,
        'rules' : rules,
        'bookingId' : bookingId,
        'picUrl' : picUrl,
        'contactInfo' : contactInfo,
        'description' : description,
        'ownerId' : ownerId,
        'startTime' : startTime,
        'endTime' : endTime,
      };


  Booking.fromSnapshot(DocumentSnapshot snapshot)
      : locTitle = snapshot['locTitle'],
        price = snapshot['price'],
        rules = snapshot['rules'],
        locId = snapshot['locId'],
        picUrl = snapshot['picUrl'],
        contactInfo = snapshot['contactInfo'],
        description = snapshot['description'],
        bookingId = snapshot['bookingId'],
        startTime = snapshot['startTime'].toDate(),
        endTime = snapshot['endTime'].toDate(),
        ownerId = snapshot['ownerId'];



}
