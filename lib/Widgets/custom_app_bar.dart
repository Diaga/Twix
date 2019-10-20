import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twix/Database/database.dart';

class CustomAppBar extends PreferredSize {
  final double height;
  final Color color;

  CustomAppBar({this.height, this.color});

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<TwixDB>(context);
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      height: height,
      color: color,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
              child: Padding(
            child: CircleAvatar(
              backgroundColor: color,
              backgroundImage: AssetImage('images/splash_image.png'),
            ),
            padding: const EdgeInsets.all(5.0),
          )),
          Expanded(
            flex: 5,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: _buildUserProfile(database)),
          ),
          Expanded(
            child: Material(
              child: InkWell(
                onTap: () {},
                child: Icon(Icons.search),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);

  StreamBuilder<UserTableData> _buildUserProfile(TwixDB database) {
    return StreamBuilder(
      stream: database.userDao.watchLoggedInUser(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.active ||
            snapshot.connectionState == ConnectionState.done) if (!snapshot
                .hasError &&
            snapshot.data != null) {
          User.name = snapshot.data.name;
          User.email = snapshot.data.email;
          return _buildUserNameAndEmail(User.name, User.email);
        }
        return _buildUserNameAndEmail(User.name, User.email);
      },
    );
  }

  Widget _buildUserNameAndEmail(String name, String email) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          name,
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        Text(
          email,
          style: TextStyle(color: Colors.black),
        ),
      ],
    );
  }
}

class User {
  static String name = '';
  static String email = '';
}
