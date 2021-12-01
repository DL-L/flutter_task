import 'dart:convert';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task/models/Users.dart';
import 'package:flutter_task/screen/bottom_nav.dart';
import 'package:flutter_task/screen/subs.dart';
import './login.dart';
import './sign_up.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_task/network_utils/api.dart';
import 'package:flutter_task/network_utils/services.dart';
import 'bottom_nav.dart';
import 'package:community_material_icon/community_material_icon.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController deadlineController = TextEditingController();

  bool _loading = false;

  @override
  void initState() {
    super.initState();
    // _loading = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_loading ? 'Loading...' : 'Add Task'),
        backgroundColor: Colors.orange[900],
      ),
      backgroundColor: Colors.orange[50],
      body: Stack(
        children: [
          //required fields to add a Task
          Positioned(
              top: 70,
              child: Container(
                  padding: EdgeInsets.all(20),
                  height: 405,
                  width: MediaQuery.of(context).size.width - 40,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 15,
                            spreadRadius: 5),
                      ]),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Create a New Task',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.brown[900]),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 3),
                              height: 2,
                              width: 130,
                              color: Colors.orange,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          buildTextField(CommunityMaterialIcons.account_outline,
                              'Sunordonnate', false, true, false, false),
                          buildTextField(
                              CommunityMaterialIcons.text_box_check_outline,
                              'Title',
                              false,
                              false,
                              false,
                              false),
                          buildTextField(CommunityMaterialIcons.text_account,
                              'Description', false, false, true, true),
                          buildTextField(CommunityMaterialIcons.clock_alert,
                              'deadline', true, false, false, false),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: FlatButton(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: 8, bottom: 8, left: 10, right: 10),
                                  child: Text(
                                    'Send Task',
                                    textDirection: TextDirection.ltr,
                                    style: TextStyle(
                                      color: Colors.brown[900],
                                      fontSize: 15.0,
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                                color: Colors.orange,
                                disabledColor: Colors.orangeAccent,
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(20.0)),
                                onPressed: _loading ? null : _addTask),
                          ),
                        ],
                      ),
                    )
                  ])))
        ],
        //Trick to The add button
      ),
    );
  }

  Widget buildTextField(IconData icon, String hintText, bool isDate,
      bool isNumber, bool isMultiline, bool hasMultiline) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextField(
          keyboardType: isDate
              ? TextInputType.datetime
              : (isNumber
                  ? TextInputType.phone
                  : (isMultiline
                      ? TextInputType.multiline
                      : TextInputType.text)),
          maxLines: hasMultiline ? 3 : 1,
          controller: isDate
              ? deadlineController
              : (isNumber
                  ? phoneController
                  : (isMultiline ? descriptionController : titleController)),
          decoration: InputDecoration(
              prefixIcon: Icon(
                icon,
                color: Colors.orange,
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.orangeAccent,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(35.0))),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.orangeAccent,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(35.0))),
              contentPadding: EdgeInsets.all(10),
              hintText: hintText,
              hintStyle: TextStyle(fontSize: 14, color: Colors.grey))),
    );
  }

  void _addTask() async {
    setState(() {
      _loading = true;
    });

    var data = {
      'sub_user': phoneController.text,
      'title': titleController.text,
      'description': descriptionController.text,
      'deadline': deadlineController.text
    };

    // print(jsonEncode(data));
    var res = await Network().postData(data, '/tasks');
    print(res.data);

    setState(() {
      _loading = false;
    });
  }
}
