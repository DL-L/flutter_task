import 'package:flutter/material.dart';
import 'package:flutter_task/models/Tasks.dart';
import 'package:flutter_task/network_utils/api.dart';
import 'package:flutter_task/screen/addtask.dart';
import 'package:flutter_task/widgets.dart/button.dart';
import 'package:flutter_task/widgets.dart/task_tile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isOn = true;
  DateTime _selectedDate = DateTime.now();
  List<Task> _tasks = [];

  @override
  void initState() {
    super.initState();
    _getTodoList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        children: [
          _addTaskBar(),
          SizedBox(
            height: 8,
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // GestureDetector(onTap: () => null, child: Card(

                  // )),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.height / 11,
                    child: InkWell(
                      child: Container(
                        child: Center(
                            child: Text(
                          'To do Tasks',
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        )),
                        margin: EdgeInsets.only(left: 15),
                        decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20))),
                      ),
                      onTap: () => print('ok'),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.height / 11,
                    child: InkWell(
                      child: Container(
                        child: Center(
                            child: Text(
                          'Sent Tasks',
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        )),
                        margin: EdgeInsets.only(right: 15),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20)),
                            border: Border.all(color: Colors.black)),
                      ),
                      onTap: () => print('ok'),
                    ),
                  )
                ],
              ),
              _addDateBar(),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          _showTasks()
        ],
      ),
    );
  }

  _showTasks() {
    return Expanded(
      child: ListView.builder(
          itemCount: null == _tasks ? 0 : _tasks.length,
          itemBuilder: (context, index) {
            Task task = _tasks[index];
            return AnimationConfiguration.staggeredGrid(
                position: index,
                columnCount: 1,
                child: SlideAnimation(
                  child: FadeInAnimation(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => null,
                          child: TaskTile(task),
                        )
                      ],
                    ),
                  ),
                ));
            // return ListTile(
            //   title: Text(task.title),
            //   subtitle: Text(task.description),
            // );
          }),
    );
  }

  Container _addDateBar() {
    return Container(
      margin: const EdgeInsets.only(left: 15, top: 15),
      child: DatePicker(
        DateTime.now(),
        height: 80,
        width: 60,
        initialSelectedDate: DateTime.now(),
        selectionColor: Colors.purple,
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        // dayTextStyle: GoogleFonts.lato(
        //   textStyle: TextStyle(
        //       fontSize: 20,
        //       fontWeight: FontWeight.w600,
        //       color: Colors.grey),
        // ),
        // monthTextStyle: GoogleFonts.lato(
        //   textStyle: TextStyle(
        //       fontSize: 20,
        //       fontWeight: FontWeight.w600,
        //       color: Colors.grey),
        // ),
        onDateChange: (date) {
          _selectedDate = date;
        },
      ),
    );
  }

  _addTaskBar() {
    return Container(
      margin: EdgeInsets.only(right: 15, left: 15, top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: GoogleFonts.lato(
                    textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[400])),
              ),
              Text(
                "Today",
                style: GoogleFonts.lato(
                    textStyle: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
              )
            ]),
          ),
          Button(label: '+ Add Task', onTap: () => Get.to(AddTaskPage()))
        ],
      ),
    );
  }

  _appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: GestureDetector(
        onTap: () {},
        child: Icon(
          Icons.nightlight_round,
          size: 20,
          color: Colors.black,
        ),
      ),
      actions: [
        Icon(
          Icons.person,
          color: Colors.black,
          size: 20,
        ),
        SizedBox(
          width: 20,
        )
      ],
    );
  }

  _getTodoList() async {
    var res = await Network().getTaskData('/users/admins/tasks').then((tasks) {
      setState(() {
        _tasks = tasks;
        print(_tasks.length);
        // _loading = false;
      });
    });
    // print(res.length);
    // print(res[0]);
    return res;
    // var body = json.decode(res);
    // print(body);
  }
}
