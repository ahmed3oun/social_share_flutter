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

  void submit() {
    _formKey.currentState?.save();
    Navigator.pop(context, username);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          header(context, isAppTitle: true, titleText: "Set up your profile"),
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
                        child: TextFormField(
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
