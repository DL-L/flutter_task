import 'dart:convert';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task/models/Users.dart';
import 'package:flutter_task/screen/add_task.dart';
import 'package:flutter_task/screen/admins.dart';
import 'package:flutter_task/screen/bottom_nav.dart';
import 'package:flutter_task/screen/sent_tasks.dart';
import 'package:flutter_task/screen/subs.dart';
import 'package:flutter_task/screen/todo.dart';
import './login.dart';
import './sign_up.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_task/network_utils/api.dart';
import 'package:flutter_task/network_utils/services.dart';
import 'bottom_nav.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int index = 2;
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  final screens = [
    Admins(),
    Subs(),
    AddTask(),
    Todo(),
    SentTasks(),
  ];

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      Icon(
        Icons.account_box_outlined,
        size: 30,
      ),
      Icon(
        Icons.account_box,
        size: 30,
      ),
      Icon(
        Icons.add,
        size: 30,
      ),
      Icon(
        Icons.task_alt,
        size: 30,
      ),
      Icon(
        Icons.task,
        size: 30,
      ),
    ];

    return Container(
      color: Colors.orange[900],
      child: SafeArea(
        top: false,
        child: Scaffold(
          // bottomNavigationBar: BottomNav(),
          body: screens[index],
          bottomNavigationBar: Theme(
            data: Theme.of(context)
                .copyWith(iconTheme: IconThemeData(color: Colors.brown[900])),
            child: CurvedNavigationBar(
              key: navigationKey,
              items: items,
              height: 60,
              index: index,
              onTap: (index) => setState(() => this.index = index),
              backgroundColor: Colors.orange.shade50,
              color: Colors.orange.shade900,
              buttonBackgroundColor: Colors.orange,
              animationDuration: Duration(milliseconds: 300),
            ),
          ),
        ),
      ),
    );
  }
}
