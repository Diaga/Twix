import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:moor_flutter/moor_flutter.dart' hide Column;
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:twix/Database/database.dart';
import 'package:twix/Api/api.dart';
import 'package:twix/Palette/palette.dart';
import 'package:twix/Screens/home_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginState();
}

class LoginState extends State<Login> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool showSpinner = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<TwixDB>(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SafeArea(
          child: ListView(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height * 0.20,
                    child: Center(
                      child: Image(
                        image: AssetImage('images/splash_image.png',),
                        height: 100,
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Text(
                            'Welcome!',
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Text(
                            'Sign up to continue...',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.35,
                    child: Column(
                      children: <Widget>[
                        _buildTextField('Name', nameController,false),
                        _buildTextField('Email', emailController,false),
                        _buildTextField('Password', passwordController,true),
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.all(15),
                    child: FlatButton(
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(3.0),
                          side: BorderSide(color: Colors.white)),
                      color: Color.fromRGBO(249, 157, 33, 100),
                      onPressed: () async {
                        setState(() {
                          showSpinner = true;
                        });
                        if (Connect.getConnection) {
                          if (_validateFields()) {
                            if (await (_actionSignUp(database))) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(),
                                ),
                              );
                            }
                          } else {
                            final snackBar = SnackBar(
                                content: Text(
                                    'Please fill the above fields correctly!'));
                            Scaffold.of(context).showSnackBar(snackBar);
                          }
                        } else {
                          final snackBar = SnackBar(
                              content: Text(
                                  'You must be connected to the internet to proceed!'));
                          Scaffold.of(context).showSnackBar(snackBar);
                        }
                      },
                      child: Text(
                        'SIGN UP',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, bool obscureText) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
      child: TextField(
        obscureText: obscureText,
        controller: controller,
        decoration: InputDecoration(
          labelText: label,

        ),
      ),
    );
  }

  Future<bool> _actionSignUp(TwixDB database) async {
    final String id = Uuid().v4();
    final response = await Api.createUser(
        id, nameController.text, emailController.text, passwordController.text);
    final responseToken =
        await Api.getToken(emailController.text, passwordController.text);
    final bool result =
        response.statusCode == 201 && responseToken.statusCode == 200;
    if (result) {
      String authToken = jsonDecode(responseToken.body)['token'];
      await database.userDao.insertUser(UserTableCompanion(
          id: Value(id),
          name: Value(nameController.text),
          email: Value(emailController.text),
          password: Value(passwordController.text),
          token: Value(authToken)));
      Api.setAuthToken(authToken);
    }
    return result;
  }

  bool _validateFields() {
    if (nameController.text.isNotEmpty) if (emailController
        .text.isNotEmpty) if (passwordController.text.isNotEmpty) return true;
    return false;
  }
}
