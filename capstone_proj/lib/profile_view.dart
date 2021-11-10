import 'package:flutter/material.dart';
import 'package:capstone_proj/widgets/provider_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:capstone_proj/services/auth_service.dart';
import 'package:capstone_proj/Models/User.dart';
import 'package:capstone_proj/main.dart';


class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {

  final primaryColor = const Color(0xFFEED9CD);

  User user = User("");
  TextEditingController _userBioController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[

          FutureBuilder(
              future: Provider
                  .of(context)
                  .auth
                  .getUser(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Container(
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.10,),
                        Icon(Icons.filter_hdr_outlined, size: 75,),
                        AutoSizeText(
                          "Name: ${snapshot.data.displayName}",
                          style: TextStyle(
                            fontSize: 35,
                          ),
                        ),
                        SizedBox(height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.10,),
                        AutoSizeText(
                          "Email: ${snapshot.data.email}",
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 35,
                          ),
                        ),
                        SizedBox(height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.10,),

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            primary: Colors.white,
                          ),
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Log out", style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.deepOrange),)
                          ),
                          onPressed: () async {
                            try {
                              AuthService auth = Provider
                                  .of(context)
                                  .auth;
                              await auth.Signout();
                              print("Signed Out");
                            } catch (e) {
                              print(e);
                            }
                          },
                        ),

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            primary: Colors.white,
                          ),
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Edit User", style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.deepOrange),)
                          ),
                          onPressed:() {
                            _userEditBottomSheet(context);
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

  _getProfileData() async {
    final uid = await Provider.of(context).auth.getCurrentID();
    await Provider.of(context).db.collection('userData').doc(uid).get().then((result) {
      user.bio = result.data['bio'];
      user.owner = result.data['owner'];
      print("Got data!)");
    });

  }

  void _userEditBottomSheet(BuildContext context)
  {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          height: MediaQuery.of(context).size.height * .50,
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 15.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text("Update Profile"),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.cancel),
                      color: Colors.orange,
                      iconSize: 25,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
                // Row(
                //   children: [
                //     Expanded(
                //       child: Padding(
                //         padding: const EdgeInsets.only(right: 15.0),
                //         child: TextField(
                //           controller: _userBioController,
                //           decoration: InputDecoration(
                //             helperText: "Bio",
                //           ),
                //         ),
                //       ),
                //     )
                //   ],
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        primary: Colors.white,
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Tap to become an owner", style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w300,
                              color: Colors.deepOrange),)
                      ),
                      onPressed:() async {
                        user.owner = true; //save to view

                        //save to firebase
                        final uid = await Provider.of(context).auth.getCurrentID();

                        await Provider.of(context).db.collection('userData').doc(uid).set(user.toJson());

                        Navigator.of(context).pop();
                        HomeController();
                      },
                    ),
                  ],
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      primary: Colors.white,
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Tap to become an renter", style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w300,
                            color: Colors.deepOrange),)
                    ),
                    onPressed:() async {
                      user.owner = false; //save to view

                      //save to firebase
                      final uid = await Provider.of(context).auth.getCurrentID();

                      await Provider.of(context).db.collection('userData').doc(uid).set(user.toJson());

                      Navigator.of(context).pop();
                      HomeController();
                    },
                  ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}