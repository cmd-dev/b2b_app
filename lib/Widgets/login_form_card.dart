import 'package:b2b_app/Models/User.dart';
import 'package:b2b_app/Shared/app_style.dart';
import 'package:b2b_app/Shared/load_main_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class FormCard extends StatefulWidget {
  FormCard(this.isSignIn, {
    Key key,
  }) : super(key: key);
  final bool isSignIn;

  @override
  _FormCardState createState() => _FormCardState();
}

class _FormCardState extends State<FormCard> {
  bool isDoneEditing1 = false;
  String pass = '';

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();

    User user = Provider.of<User>(context);

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, 15.0),
                blurRadius: 15.0),
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, -10.0),
                blurRadius: 10.0),
          ]),
      child: Card(
//        elevation: 0.5,
        child: AnimatedSwitcher(
          transitionBuilder: (child, animation) {
            final offsetAnimation =
            Tween<Offset>(begin: Offset(0.0, -0.3), end: Offset(0.0, 0.02))
                .animate(animation);
            return ClipRect(
              clipBehavior: Clip.antiAlias,
              child: SlideTransition(
                position: offsetAnimation,
                child: child,
              ),
            );
          },
          duration: Duration(milliseconds: 400),
          child: widget.isSignIn
              ? Form(
            key: formKey,
            child: Column(
              key: UniqueKey(),
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                    top: 20,
                    bottom: 10,
                    left: 10,
                  ),
                  child: Text('Username:',
                      style: AppStyle.loginPageHeadingStyle),
                ),
                Container(
                  height: 40,
                  child: TextFormField(
                    validator: (v) {
                      if (user.userName != null && user.userName == v)
                        user.setUserStat(true);
                      if (v.isEmpty) return 'Username cannot be Empty!';

                      if (!user.isValidUser) return 'Wrong Username';
                      return null;
                    },
//                      onSaved: (v) {
//                        user.setUserName(v);
//                        setState(() {
//                          isDoneEditing1 = !isDoneEditing1;
//                        });
//                      },
//              suffix: Icon(
//                Icons.check_circle_outline,
//                color: isDoneEditing ? Colors.green : Colors.red,
//              ),
//              suffixMode: OverlayVisibilityMode.always,

                    decoration: InputDecoration(
                        labelText: 'Enter your Username',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.green,
                          ),
                        )),
//              clearButtonMode: isDoneEditing
//                  ? OverlayVisibilityMode.never
//                  : OverlayVisibilityMode.editing,
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(
                      top: 20,
                      bottom: 10,
                      left: 10,
                    ),
                    child: Text(
                      'Password:',
                      style: AppStyle.loginPageHeadingStyle,
                    )),
                Container(
                  height: 40,
                  child: TextFormField(
                      validator: (v) {
                        if (user.password != null && user.password == v)
                          user.setPassStat(true);

                        if (v.isEmpty)
                          return 'Password cannot be Empty!';
                        if (!user.isValidPass && !user.isValidUser)
                          return 'Wrong Username and Password combination!';
                        if (!user.isValidPass) return 'Wrong Password';

                        return null;
                      },
//                        onSaved: (v) {},
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: 'Enter your Password',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.green,
                              )))),
                ),
                InkWell(
                    child: Container(
                        margin: EdgeInsets.only(left: 200, top: 40),
                        width: 100,
                        height: 50,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Color(0xFF17ead9),
                              Color(0xFF6078ea)
                            ]),
                            borderRadius: BorderRadius.circular(6.0),
                            boxShadow: [
                              BoxShadow(
                                  color:
                                  Color(0xFF6078ea).withOpacity(.3),
                                  offset: Offset(0.0, 8.0),
                                  blurRadius: 8.0)
                            ]),
                        child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                                onTap: () {
                                  final form = formKey.currentState;
                                  if (form.validate()) {
                                    form.save();
                                    Scaffold.of(context).showSnackBar(
                                        SnackBar(
                                            content:
                                            Text('Logging in')));
                                    loadMainPage(context);
                                  }
                                },
                                child: Center(
                                    child: Text('Log in',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Lato',
                                            fontSize: 18,
                                            letterSpacing: 1.0))))))),
              ],
            ),
          )
              : Form(
            key: formKey,
            child: Column(
              key: UniqueKey(),
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                    top: 5,
                    bottom: 10,
                    left: 10,
                  ),
                  child: Text(
                    'Email-ID:',
                    style: AppStyle.loginPageHeadingStyle,
                  ),
                ),
                Container(
                  height: 35,
                  child: TextFormField(
                      validator: (v) {
                        if (v.isEmpty) return 'E-mail cannot be Empty!';
                        return null;
                      },
                      onSaved: (v) {
                        user.setEmail(v);
                      },
                      decoration: InputDecoration(
                          labelText: 'Enter a E-mail address',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.green,
                              )))),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 15,
                    bottom: 10,
                    left: 10,
                  ),
                  child: Text(
                    'Username:',
                    style: AppStyle.loginPageHeadingStyle,
                  ),
                ),
                Container(
                  height: 35,
                  child: TextFormField(
                      validator: (v) {
                        if (v.isEmpty) return 'Username cannot be Empty!';
                        return null;
                      },
                      onSaved: (v) {
                        user.setUserName(v);
                      },
                      decoration: InputDecoration(
                          labelText: 'Enter a Username',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.green,
                              )))),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 15,
                    bottom: 10,
                    left: 10,
                  ),
                  child: Text(
                    'Password:',
                    style: AppStyle.loginPageHeadingStyle,
                  ),
                ),
                Container(
                  height: 55,
                  child: StatefulBuilder(
                      builder: (context, setState) =>
                          TextFormField(
                              validator: (v) {
                                if (v.isEmpty)
                                  return 'Password cannot be Empty!';
                                if (pass.length < 8)
                                  return 'Must be at least 8 characters long';
                                return null;
                              },
                              onSaved: (v) {
                                user.setPassword(v);
                              },
                              obscureText: true,
                              onChanged: (v) {
                                setState(() {
                                  pass = v;
                                });
                              },
                              decoration: InputDecoration(
                                  counterText: pass == null
                                      ? '0'
                                      : pass.length.toString(),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: pass.length <= 7
                                            ? Colors.red
                                            : Colors.green,
                                      )),
                                  labelText:
                                  'Enter a Password (Alphanumeric)',
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.green,
                                      ))))),
                ),
                InkWell(
                    child: Container(
                        margin: EdgeInsets.only(left: 200, top: 10),
                        width: 100,
                        height: 50,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Color(0xFF17ead9),
                              Color(0xFF6078ea)
                            ]),
                            borderRadius: BorderRadius.circular(6.0),
                            boxShadow: [
                              BoxShadow(
                                  color:
                                  Color(0xFF6078ea).withOpacity(.3),
                                  offset: Offset(0.0, 8.0),
                                  blurRadius: 8.0)
                            ]),
                        child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                                onTap: () {
                                  final form = formKey.currentState;
                                  if (form.validate()) {
                                    form.save();
                                    Scaffold.of(context).showSnackBar(
                                        SnackBar(
                                            content:
                                            Text('Registering..')));
                                  }
                                },
                                child: Center(
                                    child: Text('Sign Up',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Lato",
                                            fontSize: 18,
                                            letterSpacing: 1.0)))))))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
