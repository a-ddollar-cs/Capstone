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
import 'package:capstone_proj/OwnerViews/LocCreation/RulesCreate.dart';

class NewLocPrice extends StatelessWidget {
  final Loc loc;
  NewLocPrice({Key key, @required this.loc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _titleController = new TextEditingController();

    _titleController.text = loc.price.toString();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("Add Property- Price"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(left: 90.0),
              child: Text(
                "Enter a Price per day",
                style: new TextStyle(fontSize: 25.0),
              )),
          Padding(
              padding:
                  const EdgeInsets.only(left: 90.0, top: 20.0, bottom: 20.0),
              child: Wrap(
                //orientation: Orientation.horizontal,
                children: <Widget>[
                  Text(
                    "\$",
                    style: new TextStyle(fontSize: 30.0),
                  ),
                  //Spacer(),
                  Container(
                    width: 100,
                    child: TextField(
                      controller: _titleController,
                      autofocus: true,
                    ),
                  ),
                ],
              )),
          Padding(
            padding: const EdgeInsets.only(left: 90.0, bottom: 20.0),
            child: ElevatedButton(
              child: Text("Continue"),
              onPressed: () {
                String temp = _titleController.text;
                loc.price = double.parse(temp);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NewLocRules(loc: loc)),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
