import 'dart:convert';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task/models/Users.dart';
import 'package:flutter_task/screen/add_task.dart';
import 'package:flutter_task/screen/addtask.dart';
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
    AddTaskPage(),
    Todo(),
    SentTasks(),
  ];

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      Icon(
        Icons.person,
        size: 30,
      ),
      Icon(
        Icons.person_outline_outlined,
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
      color: Colors.purpleAccent,
      child: SafeArea(
        top: false,
        child: Scaffold(
          // bottomNavigationBar: BottomNav(),
          body: screens[index],
          bottomNavigationBar: Theme(
            data: Theme.of(context)
                .copyWith(iconTheme: IconThemeData(color: Colors.black)),
            child: CurvedNavigationBar(
              key: navigationKey,
              items: items,
              height: 60,
              index: index,
              onTap: (index) => setState(() => this.index = index),
              backgroundColor: Colors.white,
              color: Colors.deepPurple,
              buttonBackgroundColor: Colors.purpleAccent,
              animationDuration: Duration(milliseconds: 300),
            ),
          ),
        ),
      ),
    );
  }
}
