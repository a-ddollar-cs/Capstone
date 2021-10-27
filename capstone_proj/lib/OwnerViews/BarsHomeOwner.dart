import 'package:capstone_proj/sign_up_view.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:capstone_proj/widgets/provider_widget.dart';
import 'package:capstone_proj/services/auth_service.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:capstone_proj/Home.dart';
import 'package:capstone_proj/profile_view.dart';



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
    HomeTab(),
    ExplorePage(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("LandBuddy"),
        actions: <Widget> [
        ],
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.landscape_sharp),
              label: "My Property",
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.person),
              label: "Profile",
            ),
          ]
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
