import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_task/models/Users.dart';
import 'package:flutter_task/network_utils/api.dart';
import 'package:flutter_task/screen/sent_tasks.dart';
import 'package:flutter_task/widgets.dart/button.dart';
import 'package:flutter_task/widgets.dart/input_field.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController deadlineController = TextEditingController();

  DateTime _date = DateTime.now();
  String _selectedUser = 'None';
  List<User> _users = [];
  List<String> _username = [];

  _getSubs() async {
    var res = await Network().getPublicData('/users/subs').then((users) {
      setState(() {
        _users = users;
        print(_users.length);
        for (var i = 0; i < _users.length; i++) {
          print(_users[i]);
          _username.add(_users[i].phoneNumber);
        }
      });
    });
    // print(res.length);
    // print(res[0]);
    return _username;
    // var body = json.decode(res);
    // print(body);
  }

  _getUsersNames() {
    setState(() {
      for (var i = 0; i < _users.length; i++) {
        print(_users[i]);
        _username.add(_users[i].phoneNumber);
      }
    });
    print(_username);
    return _username;
  }

  @override
  void initState() {
    super.initState();
    _getSubs();
    _getUsersNames();
    _username;
  }

  // final _username1 = ['1', '2'];
  String? value;
  int _selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add Task',
              style: GoogleFonts.lato(
                  textStyle: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
            ),
            InputField(
              title: 'Title',
              hint: 'Enter your title',
              lines: 1,
              kbtype: TextInputType.text,
              controller: titleController,
            ),
            InputField(
              title: 'Description',
              hint: 'Enter your Description',
              lines: 5,
              kbtype: TextInputType.multiline,
              controller: descriptionController,
            ),
            InputField(
              title: 'Deadline',
              hint: DateFormat.yMd().format(_date),
              widget: IconButton(
                  onPressed: () {
                    _getDateFromUser();
                  },
                  icon: Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.blueGrey,
                  )),
              kbtype: TextInputType.datetime,
              controller: deadlineController,
            ),
            InputField(
                title: 'Subordonnate',
                hint: _selectedUser,
                controller: phoneController,
                widget: DropdownButton<String>(
                  value: value,
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.blueGrey,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  style: GoogleFonts.lato(
                      textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black)),
                  underline: Container(
                    height: 0,
                  ),
                  onChanged: (value) => setState(() {
                    this.value = value;
                    _selectedUser = value!;
                  }),
                  items: _username.map(buildMenuItem).toList(),
                )),
            SizedBox(
              height: 18,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _colorPalette(),
                Button(
                    label: 'Create Task',
                    onTap: () {
                      _addTask();
                      Get.to(SentTasks());
                    })
              ],
            ),
          ],
        )),
      ),
    );
  }

  Column _colorPalette() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Color',
          style: GoogleFonts.lato(
              textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black)),
        ),
        SizedBox(
          height: 8,
        ),
        Wrap(
          children: List<Widget>.generate(3, (int index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedColor = index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: index == 0
                      ? Colors.greenAccent
                      : index == 1
                          ? Colors.blueAccent
                          : Colors.purpleAccent,
                  child: _selectedColor == index
                      ? Icon(
                          Icons.done,
                          color: Colors.white,
                          size: 16,
                        )
                      : Container(),
                ),
              ),
            );
          }),
        )
      ],
    );
  }

  _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: GestureDetector(
        child: Icon(
          Icons.arrow_back_ios,
          size: 20,
          color: Colors.black,
        ),
      ),
    );
  }

  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2121));
    if (_pickerDate != null) {
      setState(() {
        _date = _pickerDate;
      });
    } else {
      print('its null');
    }
  }

  DropdownMenuItem<String> buildMenuItem(String user) => DropdownMenuItem(
        value: user,
        child: Text(
          user,
          style: GoogleFonts.lato(
              textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black)),
        ),
      );

  void _addTask() async {
    var data = {
      'sub_user': _selectedUser,
      'title': titleController.text,
      'description': descriptionController.text,
      'deadline': _date.toString()
    };
    print(data);
    // print(jsonEncode(data));
    var res = await Network().postData(data, '/tasks');
    print('dalal');
    print(res);
  }
}
