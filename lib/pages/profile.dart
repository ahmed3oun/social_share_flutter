import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_share/models/user.dart';
import 'package:social_share/pages/edit_profile.dart';
import 'package:social_share/pages/home.dart';
import 'package:social_share/pages/timeline.dart';
import 'package:social_share/widgets/header.dart';

import 'package:cached_network_image/cached_network_image.dart';

final usersRef = FirebaseFirestore.instance.collection('users');
final postsRef = FirebaseFirestore.instance.collection('posts');

class Profile extends StatefulWidget {
  String? profileId;

  Profile({
    required String? profileId,
  }) {
    this.profileId = profileId;
  }
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  //var user = await usersRef.where(profileId).get() ;
  final String currentUserId = currentUser!.id!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, isAppTitle: true, titleText: "Profile"),
      body: ListView(
        children: <Widget>[buildProfileHeader()],
      ),
    );
  }

  buildProfileHeader() {
    return FutureBuilder(
      future: usersRef.where(widget.profileId).get(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return circularProgress();
        }
        print("************************************");
        print(snapshot.data!.docs.first['id']);
        //User user = User.fromDocument(snapshot.data!.docs.first);
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 40.0,
                    backgroundColor: Colors.grey,
                    backgroundImage: CachedNetworkImageProvider(
                      snapshot
                          .data!.docs.first['photoUrl'], /* user.photoUrl! */
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            buildCountColumn("posts", 0),
                            //Text("posts : 0"),
                            buildCountColumn("followers", 0),
                            //Text("followers : 0"),
                            buildCountColumn("following", 0),
                            //Text("following : 0"),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            //buildProfileButton(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(top: 12.0),
                child: Text(
                  /* user.username! */ snapshot.data!.docs.first['username'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  /* user.displayName! */ snapshot
                      .data!.docs.first['displayName'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(top: 2.0),
                child: Text(
                  /* user.bio! */ snapshot.data!.docs.first['bio'],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Column buildCountColumn(String label, int count) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          count.toString(),
          style: const TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
        ),
        Container(
          margin: EdgeInsets.only(top: 4.0),
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 15.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  buildProfileButton() {
    bool isProfileOwner = currentUserId == widget.profileId;

    if (isProfileOwner) {
      //return buildButton(text: "Edit Profile", function: editProfile);
    }
  }

  /* editProfile() {
    
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditProfile(currentUserId: currentUserId)));
  } */

  /* Container buildButton({required String text, required Function function}) {
    return Container(
      padding: EdgeInsets.only(top: 2.0),
      child: FlatButton(
        onPressed: function,
        child: Container(
          width: 250.0,
          height: 27.0,
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.blue,
            border: Border.all(
              color: Colors.blue,
            ),
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    );
  } */
}
