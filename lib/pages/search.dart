import 'package:flutter/material.dart';
import 'package:social_share/widgets/header.dart';
import 'package:flutter_svg/svg.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  AppBar buildSearchField() {
    return AppBar(
        backgroundColor: Colors.white,
        title: TextFormField(
          decoration: InputDecoration(
            hintText: "Search for a user...",
            filled: true,
            prefixIcon: const Icon(
              Icons.account_box,
              size: 28.0,
            ),
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () => print('cleared'),
            ),
          ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, isAppTitle: true, titleText: "Search"),
      body: Scaffold(
        appBar: buildSearchField(),
        body: buildNoContent(),
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
      ),
    );
  }
}
