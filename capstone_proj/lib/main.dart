import 'package:capstone_proj/OwnerViews/BarsHomeOwner.dart';
import 'package:capstone_proj/RenterViews/BarsHome.dart';
import 'package:capstone_proj/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:capstone_proj/Splash_Page.dart';
import 'package:capstone_proj/sign_up_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:capstone_proj/widgets/provider_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:capstone_proj/Models/User.dart';

//navigation, firebase initialization, tells us if user is
//signed in, routes accordingly
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  bool _isOwner = false;
  @override
  Widget build(BuildContext context)
  {
    return Provider(
      auth: AuthService(),
      db: FirebaseFirestore.instance,
      child: MaterialApp(
          title: "LandBuddy",
          theme: ThemeData(
            primarySwatch: Colors.green,
          ),
          //home: Home(),
          home: HomeController(),
          routes: <String, WidgetBuilder> {
            '/signUp': (BuildContext context) => SignUpView(authFormType: AuthFormType.signUp,),
            '/signIn': (BuildContext context) => SignUpView(authFormType: AuthFormType.signIn,),
            '/home': (BuildContext context) => HomeController(),
          },
      ),
    );
  }
}

//below is a checker for authentication so you don't have to login every time
class HomeController extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    User user = User("");
    Future<String> futureID;
    String uid;
    final AuthService auth = Provider.of(context).auth;

    futureID = auth.getCurrentID();

    futureID.then((value) {
      uid = value;
    });

    return StreamBuilder(
      stream: auth.onAuthStateChanged,
        builder: (context, AsyncSnapshot<String> snapshot ) {
        if(snapshot.connectionState == ConnectionState.active) {
          final bool signedIn = snapshot.hasData;
          return signedIn ? typeofUser(uid, context) : FirstView();
        }
        return CircularProgressIndicator();
        },
    );
  }

  StatefulWidget typeofUser(String uid, BuildContext context)
  {
    bool _initialized = false;
    FirebaseApp firebaseApp = null;

    Future<void> initializeFlutterFire() async {
      try {
        // Wait for Firebase to initialize and set `_initialized` state to true
        firebaseApp = await Firebase.initializeApp();
        _initialized = true;
      } catch(e) {
        print(e);
      }
    }

    initializeFlutterFire();

    Future<bool> readOwner() async {
      if (!_initialized) {
        await initializeFlutterFire();
      }

      FirebaseFirestore firestore = await FirebaseFirestore.instance;


      DocumentSnapshot value = await firestore
          .collection('userData')
          .doc(uid).get();

      Map<String, dynamic> data = value.data();

      return data['owner'];
    }

    bool isOwner;

    Future<void> getInfo() async {
      isOwner = await readOwner();
      print("calling inside async");
      print(isOwner);
    }

    return FutureBuilder(
      future: getInfo(),
      builder: (context, snapshot) {

          print("Owner Status:");
          print(isOwner);

          if(isOwner == true)
          {
            return HomePageOwner();
          }
          else
          {
            return HomePage();
          }

        // else {
        //   return CircularProgressIndicator();
        // }
      }
    );


}

}



