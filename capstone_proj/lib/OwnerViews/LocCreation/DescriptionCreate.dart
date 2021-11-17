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

class NewLocDesc extends StatelessWidget {
  final Loc loc;
  NewLocDesc({Key key, @required this.loc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _titleController = new TextEditingController();

    _titleController.text = loc.description;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("Add Property- Description"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: AutoSizeText(
                "Enter a brief description of your property",
                style: new TextStyle(fontSize: 25.0),
                maxLines: 1,
              )),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: TextField(
              controller: _titleController,
              autofocus: true,
            ),
          ),
          ElevatedButton(
            child: Text("Continue"),
            onPressed: () {
              loc.description = _titleController.text;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewLocPrice(loc: loc)),
              );
            },
          ),
        ],
      ),
    );
  }
}
