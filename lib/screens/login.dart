//import 'dart:html';
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/screens/HomeScreen.dart' as Page;
import 'package:flutter_projects/screens/home.dart';
import 'package:flutter_projects/screens/register.dart';
import 'package:flutter_projects/services/auth.dart';
import 'package:flutter_projects/src/fluttericon.dart';
import 'package:flutter_projects/src/themes.dart';
import 'package:flutter_projects/src/widgets/app_textfield.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
  const LoginPage({
    @required Key key,
    @required this.auth,
  }) : super(key: key);
  final AuthBase auth;
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _submitted = false;
  bool _isLoading = false;
  String get _email => _emailController.text;
  String get _password => _passwordController.text;

  void _submit() async {
    print("submit Login called");
    setState(() {
      _submitted = true;
      _isLoading = true;
    });
    try {
      await widget.auth.signInWithEmailAndPassword(_email, _password);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Page.HomeScreen()),
      );

      print("login success");
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text("YSF IT Solutions"),
        backgroundColor: Colors.orange,),
        
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: ListView(
            children: [
              RichText(
                text: TextSpan(
                    text: 'Welcome To YSF IT Solutions',
                      style: TextStyle(
                          fontSize: 24.0,
                          height: 2,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange))
            ),
              SizedBox(height: 15.0),
              Image.asset(
                "assets/login.jpg", //image that will appear on login screen
                height: 250,
              ),
              Text(
                "Login", //appears at top of login screen to indicate to users that this is the login page
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color:  Colors.orange,
                  fontSize: 32,
                ),
              ),
              SizedBox(height: 12),
                AppTextField(
                  //username field on login form
                  controller: _emailController,
                  hint: "Email or Username",
                  icon: FlutterIcons.account_circle,
                  helpContent: Text(
                    "Forgot?",
                    style: TextStyle(fontSize: 16, color:  Colors.orange),
                  ),
                  helpOnTap: () {},
                ),
              SizedBox(height: 12),
              AppTextField(
                //password field on login screen
                obscure: true,
                controller: _passwordController,
                hint: "Password",
                icon: FlutterIcons.add,
                helpContent: Text(
                  "",
                  style: TextStyle(fontSize: 16, color: Themes.colorPrimary),
                ),
                helpOnTap: () {},
              ),
              SizedBox(height: 12),
              FlatButton(
                //login button
                color:  Colors.orange,
                padding: EdgeInsets.all(16),
                child: Text(
                  "Login",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
                onPressed: () {
                  _submit();
                },
               
              ),
              SizedBox(height: 24),
              /*Text.rich(
                TextSpan(text: "New to the YSF IT Solutions?", children: [
                  TextSpan(
                    text: "Register",
                    style: TextStyle(
                      color:  Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.of(context).push(MaterialPageRoute<void>(
                          builder: (context) => RegisterScreen(
                            auth: widget.auth,
                          ),
                        ));
                      },
                  )
                ]),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black),
              )*/
              ],
          ),
        ));
  }
}
