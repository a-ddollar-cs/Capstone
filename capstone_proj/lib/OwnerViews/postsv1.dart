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
  final List<Loc> locList = [
    Loc("Collins Lake Deer Camp", 35.00, "No Shooting past the cattle guard!"),
    Loc("Fuller Lake", 75.00, "Need 4WD to access after first snow"),
    Loc("Strawberry Valley", 40.00, "Beware of falling timber in the burn scars"),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new ListView.builder(
          itemCount: locList.length,
          itemBuilder: (BuildContext context, int index) =>
              buildLocCard(context, index)),
    );
  }

  Widget buildLocCard(BuildContext context, int index) {
    final loc = locList[index];
    return new Container(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child:
              Row(children: <Widget>[
                Text(loc.title, style: new TextStyle(fontSize: 20.0),),
                Spacer(),
                Text("\$${loc.price.toString()}0/day", style: new TextStyle(fontSize: 18.0),),
              ]),
              ),

              //need extra row?
              // Padding(
              //   padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              //   child: Row(children: <Widget>[
              //   Spacer(),
              // ]),
              // ),

              Padding(
                padding: const EdgeInsets.only(top: 80.0, bottom: 6.0),
                child: Row(children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text("Rules:", style: new TextStyle(fontSize: 18.0), ),
                      Text(locList[index].rules),
                    ],
                  ),
                  Spacer(),
                  Icon(Icons.house),
                ])


              ),

              //id for debugging remove later
              //Text(loc.id),
            ],
          ),
        ),
      ),
    );
  }
}
