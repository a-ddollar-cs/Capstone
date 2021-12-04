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

class CalDetails extends StatelessWidget {
  final Booking book;
  CalDetails({Key key, @required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                title: Text('Booking Details'),
                backgroundColor: Colors.deepOrange,
                expandedHeight: 300.0,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(book.picUrl, fit: BoxFit.cover),
                ),
              ),
              SliverFixedExtentList(
                  itemExtent: 100.00,
                  delegate: SliverChildListDelegate([
                    AutoSizeText(
                      book.locTitle,
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
                      "Booked From:",
                      style: TextStyle(
                        fontSize: 30,
                        decorationStyle: TextDecorationStyle.wavy,
                      ),
                    ),

                    Text(
                      "${DateFormat('MM/dd/yyyy').format(book.startTime).toString()} - ${DateFormat('MM/dd/yyyy').format(book.endTime).toString()}",
                      style: new TextStyle(fontSize: 20.0),
                    ),
                    AutoSizeText(
                      "Description",
                      style: TextStyle(
                        fontSize: 30,
                        decorationStyle: TextDecorationStyle.wavy,
                      ),
                    ),
                    AutoSizeText(
                      book.description,
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
                      "\$ ${book.price.toString()}0/day",
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
                      book.rules,
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
                      book.contactInfo,
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
        ],
      ),
    );
  }
}