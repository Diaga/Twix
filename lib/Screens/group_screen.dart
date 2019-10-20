import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twix/Database/DAOs/group_user_dao.dart';

import 'package:twix/Database/database.dart';
import 'package:twix/Api/api.dart';
import 'package:http/http.dart';

class GroupScreen extends StatefulWidget {
  final GroupTableData group;

  const GroupScreen({Key key, this.group}) : super(key: key);

  @override
  _GroupScreenState createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<TwixDB>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ThemeData.light().scaffoldBackgroundColor,
        title: Text(
          widget.group.name,
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
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
      body: _buildGroupUserList(database),
    );
  }

  StreamBuilder<List<GroupWithUser>> _buildGroupUserList(TwixDB database) {
    return StreamBuilder(
        stream: database.groupUserDao.watchGroupUsersByGroupId(widget.group.id),
        builder: (BuildContext context,
            AsyncSnapshot<List<GroupWithUser>> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) if (!snapshot
              .hasError) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (_, index) {
                return MemberCard(
                    name: snapshot.data[index].user.name,
                    email: snapshot.data[index].user.email);
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}

class MemberCard extends StatelessWidget {
  final String name;
  final String email;

  const MemberCard({Key key, @required this.name, @required this.email})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(),
      title: Text(name),
      subtitle: Text(email),
    );
  }
}

class Search extends SearchDelegate<String> {

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      )
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
    return FutureBuilder(
        future: Api.getAllUsers(email: query),
        builder: (BuildContext context, AsyncSnapshot<Response> snapshot) {
          if (snapshot.connectionState == ConnectionState.active ||
              snapshot.connectionState == ConnectionState.done) {
            var data = jsonDecode(snapshot.data.body);
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return AddMemberList(
                  text: data[index]['email'],
                );
              },
              itemCount: data.length,
            );
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}

class AddMemberList extends StatefulWidget {
  final String text;

  AddMemberList({this.text});

  @override
  _AddMemberListState createState() => _AddMemberListState();
}

class _AddMemberListState extends State<AddMemberList> {
  IconData iconData;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: Icon(iconData),
      onTap: () {
        setState(() {
          if (iconData == null) {
            iconData = Icons.check;
          } else {
            iconData = null;
          }
        });
      },
      title: Text(widget.text),
    );
  }
}
