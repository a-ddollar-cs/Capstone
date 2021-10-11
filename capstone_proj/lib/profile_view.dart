import 'package:flutter/material.dart';
import 'package:capstone_proj/widgets/provider_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:capstone_proj/services/auth_service.dart';


class ProfileView extends StatelessWidget {

  final primaryColor = const Color(0xFFEED9CD);

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          FutureBuilder(
            future: Provider.of(context).auth.getUser(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.done) {
                return Container(
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: MediaQuery.of(context).size.height * 0.10,),
                      AutoSizeText(
                      "Name: ${snapshot.data.displayName}",
                      style: TextStyle(
                          fontSize: 35,
                      ),
                      ),
                        SizedBox(height:  MediaQuery.of(context).size.height * 0.10,),
                        AutoSizeText(
                          "Email: ${snapshot.data.email}",
                          style: TextStyle(
                            fontSize: 35,
                          ),
                        ),
                        SizedBox(height:  MediaQuery.of(context).size.height * 0.10,),
              ElevatedButton(
              style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
              primary: Colors.white,
              ),
              child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Log out", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300, color: Colors.deepOrange),)
              ),
              onPressed: () async {
                try  {
                  AuthService auth = Provider.of(context).auth;
                  await auth.Signout();
                  print("Signed Out");
                } catch (e) {
                  print(e);
                }
              },
              ),
                      ],
                    ),
                );
              } else {
                return CircularProgressIndicator();
              }
            }
          )
        ],
      ),
    );
  }
}