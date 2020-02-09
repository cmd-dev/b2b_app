import 'dart:async';

import 'package:b2b_app/Shared/app_style.dart';
import 'package:b2b_app/Shared/load_main_page.dart';
import 'package:b2b_app/Widgets/hr_line.dart';
import 'package:b2b_app/Widgets/login_form_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int currentTab;
  bool isSignIn = true;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomPadding: true,
//        backgroundColor: Colors.white,
        body: Theme(
          data: ThemeData(
              textTheme: TextTheme(
                body1: AppStyle.loginPageStyle,
                body2: AppStyle.loginPageStyle,
              )),
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Positioned(
                left: 180,
                top: -20,
                child: ClipOval(
                  clipBehavior: Clip.antiAlias,
                  child: Image.asset(
                    'images/texture_7.jpg',
                    height: 280,
                    fit: BoxFit.cover,
                    width: 300,
                  ),
                ),
              ),
              Positioned(
                top: 100,
                left: 0,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          width: 10,
                        ),
                        Icon(Icons.unfold_more),
                        Container(
                          width: 10,
                        ),
                        Text(
                          'B2B App',
                          style: AppStyle.loginPageStyle,
                        ),
                        Container(
                          width: 70,
                        ),
                        Container(
                          height: 50,
                          width: 200,
                          child: TabBar(
                            isScrollable: false,
                            onTap: (index) {
                              setState(() {
                                currentTab = index;
                                isSignIn = currentTab == 0;
                              });
                            },
                            indicatorSize: TabBarIndicatorSize.label,
                            unselectedLabelColor: Colors.grey,
                            labelColor: Colors.black,
                            indicatorColor: Colors.amber,
                            tabs: <Widget>[
                              Tab(
                                child: Text(
                                  'Sign In',
                                  style: AppStyle.loginPageStyle,
                                ),
//                              text: 'Sign In',
                              ),
                              Tab(
                                child: Text(
                                  'Sign Up',
                                  style: AppStyle.loginPageStyle,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    Container(
                      height: 100,
                    ),
                    Container(
                      height: 360,
                      width: 325,
                      child: FormCard(
                        isSignIn,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                  top: 180,
                  left: 20,
                  child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 1100),
                    reverseDuration: Duration(milliseconds: 200),
                    child: isSignIn
                        ? Text(
                      'Welcome Back',
                      key: ValueKey(1),
                      style: TextStyle(fontSize: 30, color: Colors.green),
                    )
                        : Text(
                      'Create an Account',
                      key: ValueKey(2),
                      style: TextStyle(fontSize: 30, color: Colors.green),
                    ),
                  )),
              Positioned(
                top: 680,
                child: Image.asset(
                  'images/city.png',
                ),
              ),
              Positioned(
                top: 620,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    horizontalLine(),
                    Text("Social Login",
                        style: TextStyle(
                            fontSize: 16.0, fontFamily: "Poppins-Medium")),
                    horizontalLine()
                  ],
                ),
              ),
              Positioned(
                top: 670,
                left: -17.5,
                child: Transform.scale(
                  scale: 0.8,
                  child: Builder(
                    builder: (ctx) =>
                        GoogleSignInButton(
                          onPressed: () {
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text('Signing in with Google'),
                            ));
                            Timer(Duration(seconds: 4), loadMainPage(context));
                          },
                          darkMode: true,
                        ),
                  ),
                ),
              ),
              Positioned(
                top: 670,
                left: 155,
                child: Transform.scale(
                  scale: 0.8,
                  child: Builder(
                    builder: (ctx) =>
                        FacebookSignInButton(onPressed: () {
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text('Signing in with Facebook'),
                          ));
                          Timer(Duration(seconds: 4), loadMainPage(context));
                        }),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
