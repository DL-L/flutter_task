import 'dart:convert';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task/models/Tasks.dart';
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

class SentTasks extends StatefulWidget {
  const SentTasks({Key? key}) : super(key: key);
  @override
  _SentTasksState createState() => _SentTasksState();
}

class _SentTasksState extends State<SentTasks> {
  List<Task> _tasks = [];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loading = true;
    _getSentTasks();
  }

  _getSentTasks() async {
    var res = await Network().getTaskData('/users/subs/tasks').then((tasks) {
      setState(() {
        _tasks = tasks;
        print(_tasks.length);
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
        title: Text(_loading ? 'Loading...' : 'Sent Tasks'),
        backgroundColor: Colors.orange[900],
      ),
      body: Container(
        color: Colors.orange[50],
        child: ListView.builder(
            itemCount: null == _tasks ? 0 : _tasks.length,
            itemBuilder: (context, index) {
              Task task = _tasks[index];
              return ListTile(
                title: Text(task.title),
                subtitle: Text(task.description),
              );
            }),
      ),
    );
  }
}
