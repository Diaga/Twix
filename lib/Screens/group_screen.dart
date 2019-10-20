import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart';
import 'package:uuid/uuid.dart';
import 'package:moor_flutter/moor_flutter.dart' hide Column;

import 'package:twix/Database/database.dart';
import 'package:twix/Api/api.dart';
import 'package:twix/Database/DAOs/group_user_dao.dart';

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
              showSearch(
                  context: context, delegate: Search(group: widget.group));
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
          if (snapshot.connectionState == ConnectionState.active ||
              snapshot.connectionState ==
                  ConnectionState.done) if (!snapshot.hasError) {
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
  final GroupTableData group;

  Search({this.group});

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
            print(data);
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return AddMemberList(
                  user: UserTableData.fromJson(data[index]),
                  groupId: group.id,
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
  final UserTableData user;
  final String groupId;

  AddMemberList({this.user, this.groupId});

  @override
  _AddMemberListState createState() => _AddMemberListState();
}

class _AddMemberListState extends State<AddMemberList> {
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<TwixDB>(context);
    insertOrReplaceUser(database, widget.user);
    return _buildListTile(database);
  }

  insertOrReplaceUser(TwixDB database, UserTableData user) {
    database.userDao.insertUser(user);
  }

  StreamBuilder _buildListTile(TwixDB database) {
    return StreamBuilder(
      stream: database.userDao.watchUserByEmail(widget.user.email),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.active ||
            snapshot.connectionState == ConnectionState.done) {
          return MemberTile(groupId: widget.groupId, user: snapshot.data);
        }
        return Container();
      },
    );
  }
}

class MemberTile extends StatefulWidget {
  final UserTableData user;
  final String groupId;

  const MemberTile({Key key, this.user, this.groupId}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MemberTileState();
}

class MemberTileState extends State<MemberTile> {
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<TwixDB>(context);
    bool iconCheck = false;
    return FutureBuilder(
      future: database.groupUserDao
          .getGroupUserByGroupUserId(widget.user.id, widget.groupId),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.active ||
            snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data != null) iconCheck = true;
          return ListTile(
            trailing: iconCheck ? Icon(Icons.check) : null,
            title: Text(widget.user.email),
            onTap: () async {
              if (iconCheck) {
                Api.removeFromGroup(widget.groupId, widget.user.id);
                database.groupUserDao.deleteGroupUser(GroupUserTableCompanion(
                    userId: Value(widget.user.id),
                    groupId: Value(widget.groupId)));
              } else {
                Api.addToGroup(widget.groupId, widget.user.id);
                database.userDao.insertUser(widget.user);
                database.groupUserDao.insertGroupUser(GroupUserTableCompanion(
                    userId: Value(widget.user.id),
                    groupId: Value(widget.groupId)));
              }
              setState(() {});
            },
          );
        }
        return ListTile(
          trailing: CircularProgressIndicator(),
          title: Text(widget.user.email),
        );
      },
    );
  }
}
