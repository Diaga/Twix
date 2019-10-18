import 'package:flutter/material.dart';

class GroupScreen extends StatefulWidget {
  @override
  _GroupScreenState createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ThemeData.light().scaffoldBackgroundColor,
        title: Text(
          'Group name',
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: Search());
            },
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          MemberCard(),
          MemberCard(),
          MemberCard(),
          MemberCard(),
          MemberCard(),
          MemberCard(),
          MemberCard(),
          MemberCard(),
          MemberCard(),
          MemberCard(),
        ],
      ),
    );
  }
}

class MemberCard extends StatelessWidget {
  const MemberCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(),
      title: Text('Member Name'),
      subtitle: Text('Member email'),
    );
  }
}

class Search extends SearchDelegate<String> {
  // This List is to just test the search functionality
  final membersList = [
    ("Indian rupee"),
    ("United States dollar"),
    ("Australian dollar"),
    ("Euro"),
    ("British pound"),
    ("Yemeni rial"),
    ("Japanese yen"),
    ("Hong Kong dollar"),
    ("Hong Kong dollar"),
    ("British pound"),
    ("Yemeni rial")
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            query = "";
          },)
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final resultList =
        membersList.where((p) => p.toLowerCase().contains(query)).toList();
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          onTap: (){
            print('Added');
          },
          title: Text(resultList[index]),
        );
      },
      itemCount: resultList.length,
    );
  }
}
