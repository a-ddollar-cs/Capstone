import 'package:capstone_proj/CalDetails.dart';
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

class MyCalendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: StreamBuilder(
            stream: getUserPropStreamSnap(context),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              return new ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (BuildContext context, int index) =>
                      buildLocCard(context, snapshot.data.docs[index]));
            }));
  }

  Stream<QuerySnapshot> getUserPropStreamSnap(BuildContext context) async* {
    final uid = await Provider.of(context).auth.getCurrentID();

    yield* FirebaseFirestore.instance
        .collection('userData')
        .doc(uid)
        .collection('myBookings')
        .snapshots();
  }

  Widget buildLocCard(BuildContext context, DocumentSnapshot booking) {
    //final book = Booking.fromSnapshot(booking);

    var book = new Booking();
    book = Booking.fromSnapshot(booking);

    return new Container(
      child: Card(
        child: InkWell(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Image.network(booking.get('picUrl')),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                  ),
                  child: Row(children: <Widget>[
                    Text(
                      booking.get('locTitle'),
                      style: new TextStyle(fontSize: 25.0),
                    ),

                    Spacer(),
                    Text(
                        "${DateFormat('MM/dd/yyyy').format(booking['startTime'].toDate()).toString()} - ${DateFormat('MM/dd/yyyy').format(booking['endTime'].toDate()).toString()}",
                      style: new TextStyle(fontSize: 15.0),
                    ),
                  ]),
                ),


                //id for debugging remove later
                //Text(loc.id),
              ],
            ),
          ),
          onTap: () {

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CalDetails(book: book)));
          },
        ),
      ),
    );
  }
}
