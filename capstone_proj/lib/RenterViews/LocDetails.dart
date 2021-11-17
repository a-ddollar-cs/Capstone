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

class LocDetails extends StatelessWidget {
  final Loc loc;
  LocDetails({Key key, @required this.loc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                title: Text('Location Details'),
                backgroundColor: Colors.deepOrange,
                expandedHeight: 300.0,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(loc.picUrl, fit: BoxFit.cover),
                ),
              ),
              SliverFixedExtentList(
                  itemExtent: 100.00,
                  delegate: SliverChildListDelegate([
                    AutoSizeText(
                      loc.title,
                      style: TextStyle(
                        fontSize: 40,
                        decorationStyle: TextDecorationStyle.wavy,
                      ),
                    ),
                  ])),
              SliverFixedExtentList(
                  itemExtent: 50.00,
                  delegate: SliverChildListDelegate([
                    AutoSizeText(
                      "Description",
                      style: TextStyle(
                        fontSize: 30,
                        decorationStyle: TextDecorationStyle.wavy,
                      ),
                    ),
                    AutoSizeText(
                      loc.description,
                      style: TextStyle(
                        fontSize: 25,
                        decorationStyle: TextDecorationStyle.wavy,
                      ),
                    ),
                  ])),
              SliverFixedExtentList(
                  itemExtent: 75.00,
                  delegate: SliverChildListDelegate([
                    Text(''),
                  ])),
              SliverFixedExtentList(
                  itemExtent: 50.00,
                  delegate: SliverChildListDelegate([
                    AutoSizeText(
                      "Price",
                      style: TextStyle(
                        fontSize: 30,
                        decorationStyle: TextDecorationStyle.wavy,
                      ),
                    ),
                    AutoSizeText(
                      "\$ ${loc.price.toString()}0/day",
                      style: TextStyle(
                        fontSize: 25,
                        decorationStyle: TextDecorationStyle.wavy,
                      ),
                    ),
                  ])),
              SliverFixedExtentList(
                  itemExtent: 75.00,
                  delegate: SliverChildListDelegate([
                    Text(''),
                  ])),
              SliverFixedExtentList(
                  itemExtent: 50.00,
                  delegate: SliverChildListDelegate([
                    AutoSizeText(
                      "Rules",
                      style: TextStyle(
                        fontSize: 30,
                        decorationStyle: TextDecorationStyle.wavy,
                      ),
                    ),
                    AutoSizeText(
                      loc.rules,
                      style: TextStyle(
                        fontSize: 25,
                        decorationStyle: TextDecorationStyle.wavy,
                      ),
                    ),
                  ])),
              SliverFixedExtentList(
                  itemExtent: 75.00,
                  delegate: SliverChildListDelegate([
                    Text(''),
                  ])),
              SliverFixedExtentList(
                  itemExtent: 50.00,
                  delegate: SliverChildListDelegate([
                    AutoSizeText(
                      "Owner Contact Info",
                      style: TextStyle(
                        fontSize: 30,
                        decorationStyle: TextDecorationStyle.wavy,
                      ),
                    ),
                    AutoSizeText(
                      loc.contactInfo,
                      style: TextStyle(
                        fontSize: 25,
                        decorationStyle: TextDecorationStyle.wavy,
                      ),
                    ),
                  ])),
              SliverFixedExtentList(
                  itemExtent: 50.00,
                  delegate: SliverChildListDelegate([
                    Text(''),
                  ])),
            ],
          ),
          new Positioned(
            bottom: 75.0,
            right: 16.0,
            child: Row(
              children: <Widget>[
                Text("Book Now!  ", style: TextStyle(fontSize: 25,),),
                new FloatingActionButton(
                  onPressed: () {},
                  child: new Icon(Icons.calendar_today_outlined),
                ),
              ],
            )


          ),
        ],
      ),
    );
  }
}
