import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_task/models/Users.dart';
import 'package:flutter_task/screen/subs.dart';
import './login.dart';
import './sign_up.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_task/network_utils/api.dart';
import 'package:flutter_task/network_utils/services.dart';

import 'admins.dart';

class BottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // padding: EdgeInsets.zero,
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Connected User name',
              style: TextStyle(fontSize: 21, color: Colors.orange[900]),
            ),
          ),
          Divider(
            color: Colors.grey[400],
          ),
          // Padding(
          //   padding: EdgeInsets.all(16),
          //   child: Text(
          //     'Related users',
          //     style: TextStyle(
          //         fontWeight: FontWeight.w400,
          //         // fontSize: 19,
          //         color: Colors.black),
          //   ),
          // ),
          ListTile(
            title: Text('Related users'),
            leading: Icon(Icons.account_box),
          ),
          ListTile(
            title: Text('Admins List'),
            leading: Icon(Icons.account_circle),
            contentPadding: EdgeInsets.fromLTRB(30, 1, 16, 1),
            onTap: () {
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => Admins()));
            },
          ),
          ListTile(
            title: Text('Subordonates List'),
            leading: Icon(Icons.account_circle),
            contentPadding: EdgeInsets.fromLTRB(30, 1, 16, 1),
            onTap: () {
              Navigator.push(
                  context, new MaterialPageRoute(builder: (context) => Subs()));
            },
          ),
        ],
      ),
    );
  }
}
