import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:social_share/models/user.dart';
import 'package:social_share/pages/timeline.dart';

class Search extends StatefulWidget {
  /* @override
  void initState(){
    Firebase.initializeApp().then((r) {
      getUsers();
    });
    super.initState();
  } */

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  var searchController = TextEditingController();
  Future<QuerySnapshot>? searchResultsFuture;
  List<UserResult> searchResult = [];

  //QuerySnapshot? searchResultsFuture;

  AppBar buildSearchField() {
    return AppBar(
        backgroundColor: Colors.white,
        title: TextFormField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: "Search for a user...",
            filled: true,
            prefixIcon: const Icon(
              Icons.account_box,
              size: 28.0,
            ),
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () => clearSearch(),
            ),
          ),
          onFieldSubmitted: handleSearch,
        ));
  }

  buildNoContent() {
    return Container(
      child: Center(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            SvgPicture.asset(
              'assets/images/search.svg',
              height: 300.0,
            ),
            const Text(
              "Find Users",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600,
                fontSize: 60.0,
              ),
            )
          ],
        ),
      ),
    );
  }

  handleSearch(String query) {
    //late Future<QuerySnapshot> users;
    Firebase.initializeApp().then((app) {
      /* users =
          usersRef /* .where("displayName", isGreaterThanOrEqualTo: query) */ .get(); */
      setState(() {
        searchResultsFuture =
            usersRef.where("displayName", isGreaterThanOrEqualTo: query).get();
      });
    });
  }

  clearSearch() {
    searchController.clear();
  }

  Widget buildSearchResult() {
    /* return FutureBuilder(
        future: /* usersRef.get() */ searchResultsFuture,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return circularProgress();
          }
          /* searchResultsFuture!.then((snapshot) {
            return snapshot.docs!
                .map((doc) => UserResult(User.fromDocument(doc)))
                .toList();
          }).then((searchResult) {
            return ListView(
              children: searchResult ,
            );
          }).catchError((err) {
            return ListView(
              children: [],
            );
            print(err);
          }); */
          List<UserResult> searchResult = [];

          snapshot.data!.docs.forEach((doc) {
            User user = User.fromDocument(doc);
            searchResult.add(UserResult(user));
          });

          return ListView(
            children: searchResult,
          );
        }); */

    //List<UserResult> userResults ;
    searchResultsFuture!
        .then((snapshot) => {
              snapshot.docs.forEach((doc) {
                User? user = User.fromDocument(doc);
                setState(() {
                  searchResult.add(UserResult(user!));
                });
              })
            })
        .catchError((err) =>
            print("********* :( ***** ecxeption when retreving data :  $err "));

    searchResult.map((e) => print(e.user.username));
    return ListView.builder(
      itemBuilder: (_context, _count) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 0.2,
            horizontal: 0.0,
          ),
          child: GestureDetector(
              onTap: () {
                print(searchResult[_count].user.username);
              },
              child: searchResult[_count]),
        );
      },
      itemCount: searchResult.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildSearchField(),
      body:
          searchResultsFuture == null ? buildNoContent() : buildSearchResult(),
      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
    );
  }
}

class UserResult extends StatelessWidget {
  UserResult(this.user);

  final User user;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor.withOpacity(1.5),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => print("tapped ..."),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(user.photoUrl!),
                backgroundColor: Colors.grey,
              ),
              title: Text(
                user.displayName!,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                user.username!,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
          const Divider(
            height: 2.0,
            color: Colors.white54,
          )
        ],
      ),
    );
  }
}
