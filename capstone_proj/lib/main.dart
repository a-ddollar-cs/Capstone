import 'package:capstone_proj/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:capstone_proj/Splash_Page.dart';
import 'package:capstone_proj/BarsHome.dart';
import 'package:capstone_proj/sign_up_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:capstone_proj/widgets/provider_widget.dart';


//navigation, firebase initialization, tells us if user is
//signed in, routes accordingly
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context)
  {
    return Provider(
      auth: AuthService(),
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
    final AuthService auth = Provider.of(context).auth;
    return StreamBuilder(
      stream: auth.onAuthStateChanged,
        builder: (context, AsyncSnapshot<String> snapshot ) {
        if(snapshot.connectionState == ConnectionState.active) {
          final bool signedIn = snapshot.hasData;
          return signedIn ? HomePage() : FirstView();
        }
        return CircularProgressIndicator();
        },
    );
  }
}



