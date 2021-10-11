import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

//basic form with buttons, text
class CustomDialog extends StatelessWidget {

  final String title, desc, primarytext, primaryRoute, sectext, secRoute;

  CustomDialog({
    @required this.title,
    @required this.desc,
    @required this.primarytext,
    @required this.primaryRoute,
    this.sectext,
    this.secRoute
});

  static const double padding = 20.0;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(padding)
      ),
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(padding),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(padding),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 10.0,
                  offset: const Offset(0.0, 10.0),
                ),
              ]
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget> [
                SizedBox(height: 24.0),
                AutoSizeText(
                  title,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.deepOrange,
                    fontSize: 20.0,
                ),
                ),
                SizedBox(height: 24.0),
                AutoSizeText(
                  desc,
                  maxLines: 4,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black26,
                    fontSize:18.0,
                  ),
                ),
                SizedBox(height: 24.0),
                RaisedButton(
                  color: Colors.deepOrange,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                  child: AutoSizeText(
                    primarytext,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w200,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacementNamed(primaryRoute);
                  },
                ),
                SizedBox(height: 12.0),
                showSecButton(context)
              ],
            )
          )
        ]
      ),
    );
  }

  showSecButton(BuildContext context) {
    if(secRoute != null && sectext != null)
      {
        return FlatButton(
          child: AutoSizeText(
              sectext,
              maxLines: 1,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.deepOrange,
                fontWeight: FontWeight.w400,
              )
          ),
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacementNamed(secRoute);
          },
        );
      } else {
      return SizedBox(height: 10.0);
    }
    }

}