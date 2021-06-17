//import 'dart:html';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/Shared/constants.dart';
import 'package:flutter_projects/screens/HomeScreen.dart' as Page;
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
  // String get _email => _emailController.text;
  // String get _password => _passwordController.text;

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

  final AuthBase _auth = Auth();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String error = '';
  bool loading = false;

  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("YSF IT Solutions"),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.orange,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: 'Welcome to YSF IT Solutions',
                      style: TextStyle(
                          fontSize: 24.0,
                          height: 2,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange))
            ),
              SizedBox(height: 12.0),
              Image.asset(
                //image that will appear on login screen
                "assets/login.jpg",
                height: 250,
              ),
              Text(
                  //appears at top of login screen to indicate to users that this is the login page
                "Login",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color:  Colors.orange,
                    fontSize: 32,
                  ),
                ),
                SizedBox(height: 10),
              Form(
                key: _formKey,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 18.0,
                    ),
                    // TODO : Implement fields
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (String input) {
                        if (input.isEmpty) {
                          return 'Please enter an Email';
                        }

                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(input)) {
                          return 'Invalid Email';
                        }

                        return null;
                      },
                      onSaved: (input) => _email = input,
                      decoration: textInputDecoration.copyWith(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.mail_outline),
                      ),
                    ),
                    SizedBox(
                      height: 18.0,
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: textInputDecoration.copyWith(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.password),
                      ),
                      validator: (val) => val.length < 6 ? 'Password needs to be at least 6 characters' : null,
                      // onChanged: (val) {
                      //   setState(() => _password = val);
                      // },
                      onSaved: (input) => _password = input,
                    ),
                    SizedBox(
                      height: 18.0,
                    ),
                    SizedBox(
                      width: 105,
                      height: 50,
                      child: new RaisedButton(
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.account_circle_outlined),
                            Text(" Sign in", style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(16),
                          ),
                        ),
                        color: Colors.orange,
                        textColor: Colors.white,
                        onPressed: signIn,
                      ),
                    ),
                    SizedBox(
                      height: 18.0,
                    ),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                  ],
                ),

                //   child: Text(
                //     "Login",
                //     style: TextStyle(color: Colors.white, fontSize: 16),
                //   ),
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.all(
                //       Radius.circular(16),
                //     ),
                //   ),

              //   Text(
              //   //appears at top of login screen to indicate to users that this is the login page
              // "Login",
              //   style: TextStyle(
              //     fontWeight: FontWeight.bold,
              //     color:  Colors.orange,
              //     fontSize: 32,
              //   ),
              // ),
              // SizedBox(height: 12),
              //   AppTextField(
              //     //username field on login form
              //     controller: _emailController,
              //     hint: "Email or Username",
              //     icon: FlutterIcons.account_circle,
              //     helpContent: Text(
              //       "Forgot?",
              //       style: TextStyle(fontSize: 16, color:  Colors.orange),
              //     ),
              //     helpOnTap: () {},
              //   ),
              // SizedBox(height: 12),
              // AppTextField(
              //   //password field on login screen
              //   obscure: true,
              //   controller: _passwordController,
              //   hint: "Password",
              //   icon: FlutterIcons.add,
              //   helpContent: Text(
              //     "",
              //     style: TextStyle(fontSize: 16, color: Themes.colorPrimary),
              //   ),
              //   helpOnTap: () {},
              // ),
              // SizedBox(height: 12),
              // FlatButton(
              //   //login button
              //   color:  Colors.orange,
              //   padding: EdgeInsets.all(16),
              //   child: Text(
              //     "Login",
              //     style: TextStyle(color: Colors.white, fontSize: 16),
              //   ),
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.all(
              //       Radius.circular(16),
              //     ),
              //   ),
              //   onPressed: () {
              //     _submit();
              //   },
              //
              // ),
              // SizedBox(height: 24),
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
              ),
              ],
          ),
        ));
  }

  Future<void> signIn() async{
    // TODO : validated fields
    final formState = _formKey.currentState;

    if(formState.validate()){
      // TODO : Sign in to firebase
      formState.save();

      try{
        UserCredential user = await FirebaseAuth.instance.
        signInWithEmailAndPassword(email: _email, password: _password);
        setState(() => loading = true);

        // TODO : Navigate to home
        Navigator.push(context, MaterialPageRoute(builder: (context) => Page.HomeScreen()));

      }catch(e){
        print(e.toString());
      }

    }else{
      loading = false;
      error = 'Authentication Failed';
    }
  }

}
