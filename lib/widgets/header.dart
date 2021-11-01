import 'package:flutter/material.dart';

AppBar header(context, {bool isAppTitle = false, String titleText = ""}) {
  return AppBar(
    title: Text(
      isAppTitle ? titleText : "In Share",
      style: const TextStyle(
        color: Colors.white,
        fontFamily: "Signatra",
        fontSize: 50.0,
      ),
    ),
    centerTitle: true,
    backgroundColor: Theme.of(context).accentColor,
  );
}
