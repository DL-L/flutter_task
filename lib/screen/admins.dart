import 'dart:convert';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task/models/Users.dart';
import 'package:flutter_task/screen/add_task.dart';
import 'package:flutter_task/screen/bottom_nav.dart';
import 'package:flutter_task/screen/subs.dart';
import 'package:flutter_task/screen/todo.dart';
import 'package:flutter_task/screen/sent_tasks.dart';
import './login.dart';
import './sign_up.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_task/network_utils/api.dart';
import 'package:flutter_task/network_utils/services.dart';
import 'bottom_nav.dart';

class Admins extends StatefulWidget {
  const Admins({Key? key}) : super(key: key);
  @override
  _AdminsState createState() => _AdminsState();
}

class _AdminsState extends State<Admins> {
  List<User> _users = [];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loading = true;
    _getAdmins();
  }

  _getAdmins() async {
    var res = await Network().getPublicData('/users/admins').then((users) {
      setState(() {
        _users = users;
        print(_users.length);
        _loading = false;
      });
    });
    // print(res.length);
    // print(res[0]);
    return res;
    // var body = json.decode(res);
    // print(body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_loading ? 'Loading...' : 'Admins List'),
        backgroundColor: Colors.orange[900],
      ),
      body: Container(
        color: Colors.orange[50],
        child: ListView.builder(
            itemCount: null == _users ? 0 : _users.length,
            itemBuilder: (context, index) {
              User user = _users[index];
              return ListTile(
                title: Text(user.email),
                subtitle: Text(user.phoneNumber),
              );
            }),
      ),
    );
  }
}
