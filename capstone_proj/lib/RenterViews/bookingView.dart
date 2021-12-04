import 'package:capstone_proj/Models/Booking.dart';
import 'package:flutter/material.dart';
import 'package:capstone_proj/OwnerViews/LocCreation/ImageUpload.dart';
import 'package:capstone_proj/sign_up_view.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:capstone_proj/widgets/provider_widget.dart';
import 'package:capstone_proj/services/auth_service.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:capstone_proj/Home.dart';
import 'package:capstone_proj/profile_view.dart';
import 'package:english_words/english_words.dart';
import 'package:capstone_proj/Models/Loc.dart';
import 'package:capstone_proj/OwnerViews/LocCreation/PriceCreate.dart';
import 'dart:async';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;

// ignore: must_be_immutable
class BookingView extends StatelessWidget {
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(Duration(days: 7));

  Booking book = new Booking();
  final Loc loc;
  BookingView({Key key, @required this.loc}) : super(key: key);
  final db = FirebaseFirestore.instance;

  Future displayDatePicker(BuildContext context) async {
    final List<DateTime> picked = await DateRagePicker.showDatePicker(
        context: context,
        initialFirstDate: startDate,
        initialLastDate: endDate,
        firstDate: new DateTime(DateTime.now().year - 50),
        lastDate: new DateTime(DateTime.now().year + 50));
    if (picked != null && picked.length == 2) {
        startDate = picked[0];
        endDate = picked[1];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("Schedule a Visit"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: AutoSizeText(
                "Click Button Below to Register for a time",
                style: new TextStyle(fontSize: 25.0),
                maxLines: 1,
              )),
          ElevatedButton(
            child: Text("Book"),
            onPressed: () async {

              await displayDatePicker(context);

              //update booking
              book.startTime = startDate;
              book.endTime = endDate;
              book.locTitle = loc.title;
              book.price = loc.price;
              book.rules = loc.rules;
              book.picUrl = loc.picUrl;
              book.contactInfo = loc.contactInfo;
              book.description = loc.description;
              book.ownerId = loc.ownerId;
              book.locId = loc.id;

              final String uid = await Provider.of(context).auth.getCurrentID();

              //add to firebase, nav away
              await db
                  .collection("userData")
                  .doc(book.ownerId)
                  .collection("myBookings")
                  .add(book.toJson());

              await db
                  .collection("userData")
                  .doc(uid)
                  .collection("myBookings")
                  .add(book.toJson());

              Navigator.of(context).popUntil((route) => route.isFirst);

            },
          ),
        ],
      ),
    );
  }


}