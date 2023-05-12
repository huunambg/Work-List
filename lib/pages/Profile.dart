import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ndialog/ndialog.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';
import 'package:todo/pages/HomePage.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? _image;
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    _loadImageFromPrefs();
  }

  // Hàm chọn ảnh từ thư viện
  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final appDir = await getApplicationDocumentsDirectory();
      final fileName = 'avatar.png';
      final imageFile = File('${appDir.path}/$fileName');
      await imageFile.writeAsBytes(await pickedFile.readAsBytes());
      setState(() {
        _image = imageFile;
        _imagePath = imageFile.path;
      });
      _saveImageToPrefs(_imagePath!);
    }
  }

  // Hàm lưu đường dẫn đến ảnh vào SharedPreferences
  Future<void> _saveImageToPrefs(String path) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('imagePath', path);
  }

  // Hàm đọc đường dẫn đến ảnh từ SharedPreferences
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
      appBar: AppBar(
        backgroundColor: Colors.black87,
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
            icon: Icon(Icons.arrow_back)),
      ),
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 60,
                    child: Container(
                      height: 120,
                      width: 120,
                      child: (_image == null
                          ? Text('')
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.file(
                                _image!,
                                fit: BoxFit.cover,
                              ))),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buttonUpdate(),
                      IconButton(
                        onPressed: () {
                          // Hiển thị cửa sổ chọn ảnh,
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return SafeArea(
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                      ListTile(
                                        leading: Icon(Icons.photo_library,
                                            color: Colors.orange),
                                        title: Text(
                                          'Select photo from gallery',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: "Outfit",
                                              color: Colors.black87),
                                        ),
                                        onTap: () async {
                                          await _pickImage(ImageSource.gallery);
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Profile()));
                                          toastification.show(
                                              backgroundColor: Color.fromARGB(
                                                  255, 25, 220, 255),
                                              icon: Icon(Icons
                                                  .question_answer_rounded),
                                              pauseOnHover: true,
                                              showProgressBar: true,
                                              elevation: 10,
                                              context: context,
                                              title:
                                                  'New photo updated, please exit the app and re-enter to show it',
                                              autoCloseDuration:
                                                  const Duration(seconds: 3));
                                          await _loadImageFromPrefs();
                                          setState(() {});
                                        },
                                      )
                                    ]));
                              });
                        },
                        icon: Icon(
                          Icons.add_a_photo,
                          color: Colors.teal,
                          size: 30,
                        ),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 60,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()));
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 40),
                        height: 50,
                        child: Row(
                          children: [
                            Icon(
                              Icons.work,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            Text(
                              "Workflow",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: "outfit",
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        height: 50,
                        margin: EdgeInsets.only(left: 40),
                        child: Row(
                          children: [
                            Icon(
                              Icons.settings,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            Text(
                              "Setting",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: "outfit",
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsets.only(left: 40),
                        height: 50,
                        child: Row(
                          children: [
                            Icon(
                              Icons.support_agent,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            Text(
                              "Support",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: "outfit",
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsets.only(left: 40),
                        height: 50,
                        child: Row(
                          children: [
                            Icon(
                              Icons.share,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            Text(
                              "Share",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: "outfit",
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        NDialog(
                          dialogStyle: DialogStyle(titleDivider: true),
                          title: Text("Hi you!"),
                          content: Text("Do you want to exit the application?"),
                          actions: <Widget>[
                            TextButton(
                                child: Text("Okay"),
                                onPressed: () => SystemNavigator.pop()),
                            TextButton(
                                child: Text("Back"),
                                onPressed: () => Navigator.pop(context)),
                          ],
                        ).show(context);
                      },
                      child: Container(
                        height: 50,
                        margin: EdgeInsets.only(left: 40),
                        child: Row(
                          children: [
                            Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            Text(
                              "Exit",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: "outfit",
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              Container(
                height: 210,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    buttonLogOut(),
                    SizedBox(
                      height: 40,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buttonUpdate() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        height: 45,
        width: MediaQuery.of(context).size.width - 150,
        margin: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(colors: [
              Color(0xff8a32f1),
              Color(0xffad32f9),
            ])),
        child: Center(
          child: Text(
            "Update",
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

  Widget buttonLogOut() {
    return InkWell(
      onTap: () async {
        // Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: (builder) => SignInPage()));
      },
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width - 60,
        margin: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(colors: [
              Color(0xFF79D2F5),
              Color(0xFF28A9E7),
            ])),
        child: Center(
          child: Text(
            "Đăng xuất",
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
}
