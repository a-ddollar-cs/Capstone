import 'package:capstone_proj/OwnerViews/OwnerDetails.dart';
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

class OwnerPosts extends StatelessWidget {
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
    yield* FirebaseFirestore.instance.collection('Locations').snapshots();
  }

  Widget buildLocCard(BuildContext context, DocumentSnapshot location) {
    final loc = Loc.fromSnapshot(location);

    return new Container(
      child: Card(
        child: InkWell(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Image.network(location['picUrl']),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                  ),
                  child: Row(children: <Widget>[
                    Text(
                      location['title'],
                      style: new TextStyle(fontSize: 25.0),
                    ),
                    Spacer(),
                    Text(
                      "\$${location['price'].toString()}0/day",
                      style: new TextStyle(fontSize: 18.0),
                    ),
                  ]),
                ),

                // Padding(
                //     padding: const EdgeInsets.only(top: 8.0, bottom: 6.0),
                //     child: Row(children: <Widget>[
                //       Column(
                //         children: <Widget>[
                //           Text(
                //             "Description:",
                //             style: new TextStyle(fontSize: 18.0),
                //           ),
                //           Container(
                //             child: AutoSizeText(location['description'], style: new TextStyle(fontSize: 15.0),maxLines: 3,),
                //           ),
                //
                //         ],
                //       ),
                //       Spacer(),
                //       //Icon(Icons.house),
                //     ])),

                //id for debugging remove later
                //Text(loc.id),
              ],
            ),
          ),
          onTap: () {
            print(location['title']);

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => OwnerDetails(loc: loc)));
          },
        ),
      ),
    );
  }
}
