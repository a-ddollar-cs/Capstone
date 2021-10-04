import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:capstone_proj/widgets/c_dial.dart';


class FirstView extends StatelessWidget{

  final primaryColor = const Color(0xFFF44F36);

  @override
  Widget build(BuildContext context) {

    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: _width,
        height: _height,
        color: primaryColor,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              SizedBox(height: _height * 0.10,),
              AutoSizeText(
                "Welcome",
                style: TextStyle(
                    fontSize: 44,
                    color: Colors.white
                ),
              ),
              SizedBox(height: _height * 0.10,),
              AutoSizeText(
                "Find land to hunt!",
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 35,
                    color: Colors.white
                ),
              ),
              SizedBox(height: _height * 0.15,),
              RaisedButton(
                  color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0, bottom: 15.0, left: 30.0, right: 30.0),
                  child: Text("Get Started", style: TextStyle(fontSize: 28, fontWeight: FontWeight.w300),),
                ),
                onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => CustomDialog(
                            title: "Create an account or log in.",
                            desc: "Accounts are a secure way to keep track of your land or hunts.",
                            primarytext: "Create an Account",
                            primaryRoute: "/signup",
                            sectext: "Login",
                            secRoute: "/login",
                        )
                    );
                },
              )
            ]
          )
        ),
      ),
    );
  }
}