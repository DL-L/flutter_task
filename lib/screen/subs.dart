import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_task/models/Users.dart';
import './login.dart';
import './sign_up.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_task/network_utils/api.dart';
import 'package:flutter_task/network_utils/services.dart';

class Subs extends StatefulWidget {
  const Subs({Key? key}) : super(key: key);
  @override
  _SubsState createState() => _SubsState();
}

class _SubsState extends State<Subs> {
  List<User> _users = [];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loading = true;
    _getSubs();
  }

  _getSubs() async {
    var res = await Network().getPublicData('/users/subs').then((users) {
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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('UserName'),
              accountEmail: Text('UserEmail'),
              decoration: BoxDecoration(color: Colors.orange[900]),
            ),
            ListTile(
              leading: Icon(Icons.account_box),
              title: Text('Related Users'),
              onTap: () => Subs(),
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(_loading ? 'Loading...' : 'subordinates list'),
        backgroundColor: Colors.orange[900],
      ),
      body: Container(
        color: Colors.white,
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
