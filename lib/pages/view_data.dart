import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:toastification/toastification.dart';
import 'package:todo/Model/services.dart';
import 'package:todo/Model/todo.dart';
import 'HomePage.dart';

class ViewData extends StatefulWidget {
  const ViewData({super.key, required this.document, required this.id});

  final Todo document;
  final String id;

  @override
  State<ViewData> createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  TextEditingController _timeController = TextEditingController();
  late String type;
  late String category;
  bool edit = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String title = widget.document.title == null
        ? "Hey There"
        : widget.document.title.toString();

    _titleController = TextEditingController(text: title);
    _descriptionController =
        TextEditingController(text: widget.document.description);
    type = widget.document.task.toString();
    category = widget.document.category.toString();
    _timeController.text = widget.document.time.toString();
  }

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            edit = !edit;
                          });
                        },
                        icon: Icon(
                          Icons.edit,
                          color: edit ? Colors.green : Colors.white,
                          size: 28,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          //delete
                          {
                            int? id = widget.document.id;
                            Datahandler x = new Datahandler();
                            await x.deleteToDo(id!);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()));
                            toastification.show(
                              backgroundColor:
                                  Color.fromARGB(255, 255, 184, 32),
                              icon: Icon(Icons.delete_forever),
                              pauseOnHover: true,
                              showProgressBar: true,
                              elevation: 10,
                              context: context,
                              title: 'Deleted',
                              autoCloseDuration: const Duration(seconds: 3),
                            );
                          }
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 28,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      edit ? "Edit" : "View",
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
                    title(),
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
                    description(),
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
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    label("Time"),
                    SizedBox(
                      height: 10,
                    ),
                    timeInput("", _timeController),
                    SizedBox(
                      height: 50,
                    ),
                    edit ? button() : Container(),
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

  Widget button() {
    return InkWell(
      onTap: () async {
        String date = DateFormat('MM/dd/yyyy')
            .format(DateTime.parse(_timeController.text))
            .toString();
        Datahandler x = new Datahandler();
        Todo o = new Todo();
        o.id = widget.document.id;
        o.title = _titleController.text;
        o.task = type;
        o.category = category;
        o.description = _descriptionController.text;
        o.time = _timeController.text;
        o.date = date;
        await x.updateToDo(o);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
        toastification.show(
          backgroundColor: Color.fromARGB(255, 255, 184, 32),
          icon: Icon(Icons.delete_forever),
          pauseOnHover: true,
          showProgressBar: true,
          elevation: 10,
          context: context,
          title: 'Successfully fixed',
          autoCloseDuration: const Duration(seconds: 3),
        );
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
            "Chỉnh sửa",
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

  Widget taskSelect(String label, int color) {
    return InkWell(
      onTap: edit
          ? () {
              setState(() {
                type = label;
              });
            }
          : null,
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
      onTap: edit
          ? () {
              setState(() {
                category = label;
              });
            }
          : null,
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

  Widget title() {
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Color(0xff2a2e3d), borderRadius: BorderRadius.circular(15)),
      child: TextFormField(
        controller: _titleController,
        enabled: edit,
        style: TextStyle(color: Colors.grey, fontSize: 17),
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Enter title...",
            hintStyle: TextStyle(
                color: Colors.grey, fontSize: 17, fontFamily: "outfit"),
            contentPadding: EdgeInsets.only(left: 20, right: 20)),
      ),
    );
  }

  Widget description() {
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Color(0xff2a2e3d), borderRadius: BorderRadius.circular(15)),
      child: TextFormField(
        controller: _descriptionController,
        enabled: edit,
        style: TextStyle(color: Colors.grey, fontSize: 17),
        maxLines: null,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Enter description",
            hintStyle: TextStyle(
                color: Colors.grey, fontSize: 17, fontFamily: "outfit"),
            contentPadding: EdgeInsets.only(left: 20, right: 20)),
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

  Widget timeInput(String labelText, TextEditingController controller) {
    return Container(
      width: MediaQuery.of(context).size.width - 70,
      height: 55,
      child: TextFormField(
        enabled: edit,
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

                  controller.text = dateTime.toString();
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
