import 'package:capstone_proj/CalendarView.dart';
import 'package:capstone_proj/RenterViews/postsRenterv1.dart';
import 'package:capstone_proj/sign_up_view.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:capstone_proj/widgets/provider_widget.dart';
import 'package:capstone_proj/services/auth_service.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:capstone_proj/Home.dart';
import 'package:capstone_proj/profile_view.dart';
import 'package:capstone_proj/OwnerViews/OwnerHomepage.dart';
import 'package:capstone_proj/OwnerViews/LocCreation/TitleCreate.dart';
import 'package:capstone_proj/Models/Loc.dart';
import 'package:capstone_proj/OwnerViews/OwnerMyproperties.dart';

class HomePageOwner extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeStateOwner();
  }
}

class _HomeStateOwner extends State<HomePageOwner> {
  int _currentIndex = 0;
  //left to right, what appaears when click tab
  final List<Widget> _children = [
    OwnerPosts(),
    OwnerMyProperties(),
    MyCalendar(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    final newLoc =
        new Loc(null, 0.0, null, null, "Not Provided", "Not Provided");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("LandBuddy"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            tooltip: 'Add a new property',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NewLocTitle(loc: newLoc)),
              );
            },
          )
        ],
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(
              Icons.home,
            ),
            label: "Home",
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.landscape_sharp),
            label: "My Property",
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.calendar_today),
            label: "Bookings",
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
