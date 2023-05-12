import 'dart:io';
import 'package:toastification/toastification.dart';
import 'package:flutter/material.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/Custom/TodoCard.dart';
import 'package:todo/Model/services.dart';
import 'package:todo/Model/todo.dart';
import 'package:todo/pages/AddTodo.dart';
import 'package:todo/pages/Profile.dart';
import 'package:todo/pages/view_data.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl.dart';
import 'package:date_format/date_format.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:ndialog/ndialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Datahandler handler;
  var id = "";
  String formattedDate =
      DateFormat('EEEE, MM/dd/yyyy', 'en_US').format(DateTime.now());
  String formattedDate2 =
      DateFormat('EEEE, MM/dd/yyyy', 'en_US').format(DateTime.now());
  String? date = DateFormat('MM/dd/yyyy', 'en_US').format(DateTime.now());
  String? date2 = DateFormat('MM/dd/yyyy', 'en_US').format(DateTime.now());
  File? _image;
  String? _imagePath;
  bool check = false;
  List<Select> selected = [];

  @override
  void initState() {
    super.initState();
    _loadImageFromPrefs();
    this.handler = Datahandler();
    this.handler.initializeDBToDo().whenComplete(() async {
      setState(() {});
      print(date2);
    });
  }

  Future<void> _loadImageFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final path = prefs.getString('imagePath');
    if (path != null) {
      setState(() {
        _imagePath = path;
        _image = File(path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black87,
        title: Text(
          formattedDate == formattedDate2 ? " Today" : "",
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: "Outfit"),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              setState(() {
                check = !check;
                if (check == true) {
                  setState(() {
                    date = null;
                  });

                  toastification.show(
                      backgroundColor: Color.fromARGB(255, 47, 247, 73),
                      icon: Icon(Icons.calendar_today),
                      pauseOnHover: true,
                      showProgressBar: true,
                      elevation: 10,
                      context: context,
                      title: 'Show all day',
                      autoCloseDuration: const Duration(seconds: 3));
                } else {
                  setState(() {
                    date = date2;
                    formattedDate == formattedDate2;
                  });
                  toastification.show(
                      backgroundColor: Color.fromARGB(255, 47, 247, 73),
                      icon: Icon(Icons.calendar_today),
                      pauseOnHover: true,
                      showProgressBar: true,
                      elevation: 10,
                      context: context,
                      title: 'Show only day ',
                      autoCloseDuration: const Duration(seconds: 3));
                }
              });
            },
            icon: Icon(Icons.list_alt,
                color: check == true
                    ? Color.fromARGB(255, 164, 214, 255)
                    : Colors.white),
          ),
          IconButton(
              onPressed: () async {
                DateTime? dateTime = await showOmniDateTimePicker(
                  type: OmniDateTimePickerType.date,
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
                  setState(() {
                    date = DateFormat('MM/dd/yyyy').format(dateTime).toString();
                    date2 =
                        DateFormat('MM/dd/yyyy').format(dateTime).toString();
                    formattedDate = DateFormat('EEEE, MM/dd/yyyy', 'en_US')
                        .format(dateTime);
                  });
                  toastification.show(
                      backgroundColor: Color.fromARGB(255, 47, 247, 73),
                      icon: Icon(Icons.calendar_today),
                      pauseOnHover: true,
                      showProgressBar: true,
                      elevation: 10,
                      context: context,
                      title: 'Display date $date2',
                      autoCloseDuration: const Duration(seconds: 3));
                }
              },
              icon: Icon(Icons.calendar_month)),
          InkWell(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (builder) => Profile()));
              setState(() {
                _image = _image;
              });
            },
            child: CircleAvatar(
              radius: 60,
              child: Container(
                height: 55,
                width: 55,
                child: (_image == null
                    ? Text('')
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.file(
                          _image!,
                          fit: BoxFit.cover,
                        ),
                      )),
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 22),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "$formattedDate",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff8a32f1),
                        fontFamily: "Outfit"),
                  ),
                ],
              ),
            ),
          ),
          preferredSize: Size.fromHeight(35),
        ),
      ),
      bottomNavigationBar:
          BottomNavigationBar(backgroundColor: Colors.black87, items: [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 32,
              color: Colors.white,
            ),
            label: ""),
        BottomNavigationBarItem(
            icon: InkWell(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (builder) => AddTodoPage()));
              },
              child: Container(
                height: 52,
                width: 52,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                        colors: [Colors.indigoAccent, Colors.purple])),
                child: Icon(
                  Icons.add,
                  size: 32,
                  color: Colors.white,
                ),
              ),
            ),
            label: ""),
        BottomNavigationBarItem(
            icon: InkWell(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (builder) => Profile()));
              },
              child: Icon(
                Icons.settings,
                size: 32,
                color: Colors.white,
              ),
            ),
            label: "")
      ]),
      body: FutureBuilder(
          future: date != date2
              ? this.handler.retrieveToDo()
              : this.handler.retrieveToDoHomNay(date!),
          builder: (BuildContext context, AsyncSnapshot<List<Todo>> snapshot) {
            if (snapshot.hasData) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    IconData iconData;
                    Color iconColor;
                    switch (snapshot.data![index].category) {
                      case "Work":
                        iconData = Icons.work_outline;
                        iconColor = Colors.red;
                        break;
                      case "Exercise":
                        iconData = Icons.run_circle_outlined;
                        iconColor = Colors.purple;
                        break;
                      case "Eat and drink":
                        iconData = Icons.food_bank_outlined;
                        iconColor = Colors.yellow;
                        break;
                      case "Design":
                        iconData = Icons.design_services;
                        iconColor = Colors.green;
                        break;
                      case "Travel":
                        iconData = Icons.map;
                        iconColor = Colors.blue;
                        break;
                      case "Music":
                        iconData = Icons.music_note_outlined;
                        iconColor = Colors.orange;
                        break;
                      case "Read book":
                        iconData = Icons.book;
                        iconColor = Colors.brown;
                        break;
                      case "Walk":
                        iconData = Icons.directions_walk;
                        iconColor = Colors.green;
                        break;
                      case "Draw":
                        iconData = Icons.design_services_rounded;
                        iconColor = Colors.orange;
                        break;
                      case "Code":
                        iconData = Icons.code;
                        iconColor = Colors.pink;
                        break;
                      case "Relax":
                        iconData = Icons.play_circle;
                        iconColor = Colors.grey;
                        break;
                      default:
                        iconData = Icons.run_circle_outlined;
                        iconColor = Colors.red;
                    }

                    return InkWell(
                      onLongPress: () async {
                        NDialog(
                          dialogStyle: DialogStyle(titleDivider: true),
                          title: Text("${snapshot.data![index].title}"),
                          content: Text("Please choose function?"),
                          actions: <Widget>[
                            TextButton(
                                child: Text("Delete"),
                                onPressed: () async {
                                  int? id = snapshot.data![index].id;
                                  Datahandler x = new Datahandler();
                                  await x.deleteToDo(id!);
                                  setState(() {});
                                  toastification.show(
                                    backgroundColor:
                                        Color.fromARGB(255, 255, 184, 32),
                                    icon: Icon(Icons.delete_forever),
                                    pauseOnHover: true,
                                    showProgressBar: true,
                                    elevation: 10,
                                    context: context,
                                    title:
                                        'Deleted ${snapshot.data![index].title}',
                                    autoCloseDuration:
                                        const Duration(seconds: 3),
                                  );
                                  Navigator.pop(context);
                                }),
                            TextButton(
                                child: Text("Back"),
                                onPressed: () => Navigator.pop(context)),
                          ],
                        ).show(context);
                      },
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (builder) => ViewData(
                              document: snapshot.data![index],
                              id: snapshot.data![index].id.toString(),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.only(bottom: 10),
                        child: TodoCard(
                          title: snapshot.data![index].title == null
                              ? "Hey There"
                              : snapshot.data![index].title.toString(),
                          iconBgColor: Colors.white,
                          iconData: iconData,
                          iconColor: iconColor,
                          time:
                              "${DateFormat('HH:mm', 'vi_VN').format(DateTime.parse(snapshot.data![index].time.toString())).toString()}",
                          index: index,
                          onChange: (onChange),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  void onChange(int index) {
    setState(() {
      selected[index].checkValue = !selected[index].checkValue;
      print(selected[index].checkValue);
    });
  }
}

class Select {
  String id;
  bool checkValue = false;
  Select({required this.id, required this.checkValue});
}
