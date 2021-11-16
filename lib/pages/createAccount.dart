import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_share/widgets/header.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final _formKey = GlobalKey<FormState>();
  late String username;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void submit() {
    final form = _formKey.currentState;

    if (form!.validate()) {
      form!.save();
      // to show TOAST
      var snackBar = SnackBar(content: Text("Welcome $username"));
      // ignore: deprecated_member_use
      _scaffoldKey.currentState!.showSnackBar(snackBar);

      Timer(Duration(seconds: 2), () {
        Navigator.pop(context, username);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: header(context,
          isAppTitle: true,
          titleText: "Set up your profile",
          removeBackButton: true),
      body: ListView(
        children: [
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 25.0),
                  child: Center(
                    child: Text(
                      "Create a username",
                      style: TextStyle(fontSize: 25.0, fontFamily: 'Signatra'),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Container(
                    child: Form(
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.always,
                        child: TextFormField(
                          validator: (val) {
                            if (val!.trim().length < 3 || val!.isEmpty) {
                              return "Username too short";
                            } else if (val!.trim().length > 12) {
                              return "Username too long";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (val) => username = val!,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Username',
                            labelStyle: TextStyle(
                              fontSize: 15.0,
                            ),
                            hintText: "Must be at least 3 characters",
                          ),
                        )),
                  ),
                ), //Padding
                GestureDetector(
                  onTap: submit,
                  child: Container(
                    height: 40.0,
                    width: 350.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18.0),
                        gradient: const LinearGradient(
                            colors: [Colors.purple, Colors.teal],
                            begin: Alignment.topRight,
                            end: Alignment.topLeft)),
                    child: const Center(
                      child: Text(
                        "Submit",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
