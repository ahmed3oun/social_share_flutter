//import 'package:cloud_firestore_web/cloud_firestore_web.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social_share/widgets/header.dart';

final CollectionReference usersRef =
    FirebaseFirestore.instance.collection("users");

class Timeline extends StatefulWidget {
  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  List<dynamic> users = [];

  @override
  void initState() {
    Firebase.initializeApp().then((r) {
      getUsers();
    });
    super.initState();
  }

  void getUsers() async {
    /* usersRef.get().then((snapshot) {
      snapshot.docs.forEach((element) {
        if (element.exists) {
          print("***************");   
          print(element.id);
          print(element.data());

          print("***************");
        } else {
          print("documents does'nt exists ");
        }
      });
    }); */
    QuerySnapshot snapshot =
        // await usersRef.where("isAdmin", isEqualTo: true).get();
        await usersRef
            .where("postsCount", isGreaterThanOrEqualTo: 2)
            .where("isAdmin", isEqualTo: true)
            .get();

    setState(() {
      users = snapshot.docs;
    });

    /* snapshot.docs.forEach((element) {
      print("****************");
      print(element.id);
      print(element.data());
      print("****************"); 
    });*/
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: header(context, isAppTitle: false),
      body: Container(
        /* child: ListView(
          children: users
              .map((e) => Text(e["username"] + " " + e['postsCount']))
              .toList(),
        ) ,*/
        //child: FutureBuilder(
        child: StreamBuilder(
          //future: usersRef.get(),
          stream: usersRef.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return circularProgress();
            }
            final List<Text> children = snapshot.data!.docs
                .map((e) =>
                    Text(e["username"] + " " + e['postsCount'].toString()))
                .toList();

            return Container(
              child: ListView(
                children: children,
              ),
            );
          },
        ),
      ),
    );
  }
}

Container circularProgress() {
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.only(top: 10.0),
    child: const CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(Colors.purple),
    ),
  );
}

Container linearProgress() {
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.only(top: 10.0),
    child: const LinearProgressIndicator(
      valueColor: AlwaysStoppedAnimation(Colors.purple),
    ),
  );
}
