import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:toastification/toastification.dart';
import 'package:todo/Model/services.dart';
import 'package:todo/Model/todo.dart';
import 'HomePage.dart';
import 'package:intl/intl.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  String time = "";
  String type = "";
  String category = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xff1d1e26),
            Color(0xff252041),
          ]),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (builder) => HomePage()));
                },
                icon: Icon(
                  CupertinoIcons.arrow_left,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Create",
                      style: TextStyle(
                          fontSize: 33,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Outfit",
                          letterSpacing: 2),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Work",
                      style: TextStyle(
                          fontSize: 33,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Outfit",
                          letterSpacing: 2),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    label("Title"),
                    SizedBox(
                      height: 12,
                    ),
                    inputText("Enter title...", 55, _titleController),
                    SizedBox(
                      height: 30,
                    ),
                    label("Type of work"),
                    SizedBox(
                      height: 12,
                    ),
                    Wrap(
                      runSpacing: 10,
                      children: [
                        taskSelect("Important", 0xffff6d6e),
                        SizedBox(
                          width: 20,
                        ),
                        taskSelect("Entertainment", 0xff2bc8d9),
                        SizedBox(
                          width: 20,
                        ),
                        taskSelect("Study", 0xfff29732),
                        SizedBox(
                          width: 20,
                        ),
                        taskSelect("Activity", 0xff6557ff),
                        SizedBox(
                          width: 20,
                        ),
                        taskSelect("Program", 0xff234ebd),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    label("Description"),
                    SizedBox(
                      height: 12,
                    ),
                    inputText(
                        "Enter description...", 150, _descriptionController),
                    SizedBox(
                      height: 25,
                    ),
                    label("Category"),
                    SizedBox(
                      height: 12,
                    ),
                    Wrap(
                      runSpacing: 10,
                      children: [
                        categorySelect("Eat and drink", 0xffff6d6e),
                        SizedBox(
                          width: 20,
                        ),
                        categorySelect("Exercise", 0xfff29732),
                        SizedBox(
                          width: 20,
                        ),
                        categorySelect("Work", 0xff6557ff),
                        SizedBox(
                          width: 20,
                        ),
                        categorySelect("Design", 0xff234ebd),
                        SizedBox(
                          width: 20,
                        ),
                        categorySelect("Travel", 0xff2bc8d9),
                        SizedBox(
                          width: 20,
                        ),
                        categorySelect("Walk", 0xffff6d6e),
                        SizedBox(
                          width: 20,
                        ),
                        categorySelect("Read book", 0xfff29732),
                        SizedBox(
                          width: 20,
                        ),
                        categorySelect("Draw", 0xff6557ff),
                        SizedBox(
                          width: 20,
                        ),
                        categorySelect("Code", 0xff234ebd),
                        SizedBox(
                          width: 20,
                        ),
                        categorySelect("Relax", 0xffff6d6e),
                        SizedBox(
                          width: 20,
                        ),
                        categorySelect("Music", 0xff2bc8d9),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    label("Time"),
                    SizedBox(
                      height: 10,
                    ),
                    timeInput("", _timeController, time),
                    SizedBox(
                      height: 50,
                    ),
                    buttonAdd(),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buttonTime() {
    return InkWell(
      onTap: () async {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 40,
            width: MediaQuery.of(context).size.width / 2,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 121, 210, 245),
                  Color.fromARGB(255, 40, 145, 231),
                ])),
            child: Center(
              child: Text(
                "Add time",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: "outfit",
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buttonAdd() {
    return InkWell(
      onTap: () async {
        if (_timeController.text == "" ||
            _titleController.text == "" ||
            type == "" ||
            category == "" ||
            _descriptionController.text == ""||time=="") {
          toastification.show(
              backgroundColor: Color.fromARGB(255, 230, 41, 41),
              icon: Icon(Icons.check_box),
              pauseOnHover: true,
              showProgressBar: true,
              elevation: 10,
              context: context,
              title: 'Please check the data!',
              autoCloseDuration: const Duration(seconds: 3));
        }else{
   time = _timeController.text;
        ;
        String date = DateFormat('MM/dd/yyyy')
            .format(DateTime.parse(_timeController.text))
            .toString();
        Datahandler x = new Datahandler();
        Todo T = new Todo();
        T.title = _titleController.text;
        T.task = type;
        T.category = category;
        T.description = _descriptionController.text;
        T.time = time;
        T.date = date;
        await x.insertToDo(T);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
        toastification.show(
            backgroundColor: Color.fromARGB(255, 247, 122, 64),
            icon: Icon(Icons.check_box),
            pauseOnHover: true,
            showProgressBar: true,
            elevation: 10,
            context: context,
            title: 'Added  ${_titleController.text}',
            autoCloseDuration: const Duration(seconds: 3));
        }

     
      },
      child: Container(
        height: 56,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(colors: [
              Color(0xff8a32f1),
              Color(0xffad32f9),
            ])),
        child: Center(
          child: Text(
            "Add",
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: "outfit",
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget inputText(String text, double _height, var _inputController) {
    return Container(
      height: _height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Color(0xff2a2e3d), borderRadius: BorderRadius.circular(15)),
      child: TextFormField(
        controller: _inputController,
        style: TextStyle(color: Colors.grey, fontSize: 17),
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "$text",
            hintStyle: TextStyle(
                color: Colors.grey, fontSize: 17, fontFamily: "outfit"),
            contentPadding: EdgeInsets.only(left: 20, right: 20)),
      ),
    );
  }

  Widget taskSelect(String label, int color) {
    return InkWell(
      onTap: () {
        setState(() {
          type = label;
        });
      },
      child: Chip(
        backgroundColor: type == label ? Colors.white : Color(color),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        label: Text(
          label,
          style: TextStyle(
              color: type == label ? Colors.black : Colors.white,
              fontSize: 15,
              fontFamily: "outfit",
              fontWeight: FontWeight.w600),
        ),
        labelPadding: EdgeInsets.symmetric(horizontal: 17, vertical: 3.8),
      ),
    );
  }

  Widget categorySelect(String label, int color) {
    return InkWell(
      onTap: () {
        setState(() {
          category = label;
        });
      },
      child: Chip(
        backgroundColor: category == label ? Colors.white : Color(color),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        label: Text(
          label,
          style: TextStyle(
              color: category == label ? Colors.black : Colors.white,
              fontSize: 15,
              fontFamily: "outfit",
              fontWeight: FontWeight.w600),
        ),
        labelPadding: EdgeInsets.symmetric(horizontal: 17, vertical: 3.8),
      ),
    );
  }

  Widget label(String label) {
    return Text(
      label,
      style: TextStyle(
          fontSize: 16.5,
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontFamily: "Outfit",
          letterSpacing: 0.2),
    );
  }

  Widget timeInput(
      String labelText, TextEditingController controller, String time) {
    return Container(
      width: MediaQuery.of(context).size.width - 70,
      height: 55,
      child: TextFormField(
        controller: controller,
        readOnly: true,
        style:
            TextStyle(fontSize: 17, color: Colors.white, fontFamily: "Outfit"),
        decoration: InputDecoration(
            suffixIcon: IconButton(
                onPressed: () async {
                  DateTime? dateTime = await showOmniDateTimePicker(
                    type: OmniDateTimePickerType.dateAndTime,
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate:
                        DateTime(1600).subtract(const Duration(days: 3652)),
                    lastDate: DateTime.now().add(
                      const Duration(days: 3652),
                    ),
                    is24HourMode: false,
                    isShowSeconds: false,
                    minutesInterval: 1,
                    secondsInterval: 1,
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    constraints: const BoxConstraints(
                      maxWidth: 350,
                      maxHeight: 650,
                    ),
                    transitionBuilder: (context, anim1, anim2, child) {
                      return FadeTransition(
                        opacity: anim1.drive(
                          Tween(
                            begin: 0,
                            end: 1,
                          ),
                        ),
                        child: child,
                      );
                    },
                    transitionDuration: const Duration(milliseconds: 200),
                    barrierDismissible: true,
                    selectableDayPredicate: (dateTime) {
                      // Disable 25th Feb 2023
                      if (dateTime == DateTime(2023, 2, 25)) {
                        return false;
                      } else {
                        return true;
                      }
                    },
                  );

                  if (dateTime != null) {
                    controller.text = dateTime.toString();
                  }
                },
                icon: Icon(
                  Icons.alarm,
                  color: Colors.yellowAccent,
                )),
            labelStyle: TextStyle(
                fontSize: 17, color: Colors.white, fontFamily: "Outfit"),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  width: 1.5,
                  color: Colors.amber,
                )),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  width: 1,
                  color: Colors.grey,
                ))),
      ),
    );
  }
}
