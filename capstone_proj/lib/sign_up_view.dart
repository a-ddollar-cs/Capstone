import 'package:capstone_proj/main.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:capstone_proj/services/auth_service.dart';
import 'package:capstone_proj/widgets/provider_widget.dart';

final primaryColor = const Color(0xFFF44F36);

enum AuthFormType {signIn, signUp, reset}

class SignUpView extends StatefulWidget {
  final AuthFormType authFormType;

  SignUpView({Key key, @required this.authFormType}) : super(key: key);
  @override
  _SignUpViewState createState() => _SignUpViewState(authFormType: this.authFormType);

}

//create signUp stuff
class _SignUpViewState extends State<SignUpView> {

  //variables
  AuthFormType authFormType;
  _SignUpViewState({this.authFormType});

  final formKey = GlobalKey<FormState>();
  String _email, _password, _name, _error;

  //navigation if clicked wrong button
  void switchFormState(String state) {
    formKey.currentState.reset();

    if(state == "signUp"){
      setState(() {
        authFormType = AuthFormType.signUp;
      });
    } else {
      setState(() {
        authFormType = AuthFormType.signIn;
      });
    }

  }

  //check validations
  bool validate() {
    final form = formKey.currentState;
    form.save();

    if(form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }

  }


  //submit authentication to firebase
  void submit() async {
    if(validate()) {
      try {
        final auth = Provider.of(context).auth;
        if(authFormType == AuthFormType.signIn) {
          String uid = await auth.signInWithEmailAndPassword(_email, _password);
          print("Sign in success! uid: $uid");
          Navigator.of(context).pushReplacementNamed('/home');
        } else if (authFormType == AuthFormType.reset) {
          await auth.sendPasswordResetEmail(_email);
          print("Sent reset password email!");
          _error = "A password reset email has been sent";
          setState(() {
            authFormType = AuthFormType.signIn;
          });
        } else {
          String uid = await auth.createUserWithEmailAndPassword(_email, _password, _name);
          print("Sign up success! uid: $uid");
          Navigator.of(context).pushReplacementNamed('/home');
        }
      } catch (e) {
        setState(() {
          _error = e.message;
        });
        print (e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;


    //design
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
        color: primaryColor,
        height: _height,
        width: _width,
        child: SafeArea(
          child: Column(
            children: <Widget> [
              SizedBox(height: _height * 0.035),
              showAlert(),
              SizedBox(height: _height * 0.035),
              buildHeaderText(),
              SizedBox(height: _height * 0.07),
              Padding(
                padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: buildInputs() + buildButtons(),
                ),
              ),
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }

  //flags returned by firebase
  Widget showAlert() {
    if(_error != null) {
        return Container(
          color: Colors.green,
          width: double.infinity,
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(Icons.error_outline_sharp),
              ),
              Expanded(child: AutoSizeText(_error, maxLines: 3,),),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: IconButton(
                    onPressed: () {
                      setState(() {
                        _error = null;
                      });
                    },
                    icon: Icon(Icons.close)
                ),
              ),
            ],
          ),
        );
      }
    return SizedBox(height: 0,);
  }

  //logic for signup/signin views, reduce code duplication
  AutoSizeText buildHeaderText() {
    String _headerText;

    if(authFormType == AuthFormType.signUp) {
      _headerText = "Create New Account";
    } else if(authFormType == AuthFormType.reset) {
      _headerText = "Reset Password";
    } else {
      _headerText = "Sign In";
    }

    return AutoSizeText(
              _headerText,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 35,
                color: Colors.white,
              ),
            );
  }


 //sign up inputs list
List<Widget> buildInputs() {
    List<Widget> textFields  = [];

    //reset password
    if(authFormType == AuthFormType.reset) {
      textFields.add(
        TextFormField(
          validator: EmailValidator.validate,
          style: TextStyle(fontSize: 22.0),
          decoration: buildSignUpInputDecoration("Email"),
          onSaved: (value) => _email = value,
        ),
      );
      textFields.add(SizedBox(height: 20,));
      return textFields;
    }

    //if signUp, get more info
    else if(authFormType == AuthFormType.signUp) {
      textFields.add(
        TextFormField(
          validator: NameValidator.validate,
          style: TextStyle(fontSize: 22.0),
          decoration: buildSignUpInputDecoration("Name"),
          onSaved: (value) => _name = value,
        ),
      );
      textFields.add(SizedBox(height: 20,));
    }



    textFields.add(
      TextFormField(
        validator: EmailValidator.validate,
        style: TextStyle(fontSize: 22.0),
        decoration: buildSignUpInputDecoration("Email"),
        onSaved: (value) => _email = value,
      ),
    );

    textFields.add(SizedBox(height: 20,));

    textFields.add(
      TextFormField(
        validator: PasswordValidator.validate,
        style: TextStyle(fontSize: 22.0),
        decoration: buildSignUpInputDecoration("Password"),
        obscureText: true,
        onSaved: (value) => _password = value,
      ),
    );

    textFields.add(SizedBox(height: 20,));
    return textFields;

}

//form inputs
InputDecoration buildSignUpInputDecoration(String hint) {
  return InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        focusColor: Colors.white,
        errorStyle: TextStyle(color: Colors.white),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 0.0)),
        contentPadding: const EdgeInsets.only(left: 14.0, bottom: 10.0, top: 10.0),
      );
}

//pre auth nav buttons
List<Widget> buildButtons() {
    String _switchButton, _newFormState, _submitText;
    bool _showForgotPass = false;

    if(authFormType == AuthFormType.signIn) {
      _switchButton = "Create a new Account";
      _newFormState = "signUp";
      _submitText = "Sign In";
      _showForgotPass = true;
    } else if (authFormType == AuthFormType.reset) {
      _switchButton = "Return to Sign In";
      _newFormState = "signIn";
      _submitText = "Submit";
    } else {
      _switchButton = "Have an Account? Sign In";
      _newFormState = "signIn";
      _submitText = "Sign Up";
    }

    return [
      Container(
        width: MediaQuery.of(context).size.width * 0.7,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
              primary: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(_submitText, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300, color: primaryColor),)
            ),
          onPressed: submit,
        ),
      ),
      showForgotPass(_showForgotPass),
      TextButton(
          onPressed: () {
            switchFormState(_newFormState);
          }, //onPressed
          child: Text(_switchButton, style: TextStyle(color: Colors.white),),
      )
    ];
}

Widget showForgotPass(bool visibility) {
    return Visibility(
        child: TextButton(
            onPressed: () {
              setState(() {
                authFormType = AuthFormType.reset;
              });
            },
            child: Text("Forgot Password?", style: TextStyle(color: Colors.white),)
        ),
      visible: visibility,
    );
}

}