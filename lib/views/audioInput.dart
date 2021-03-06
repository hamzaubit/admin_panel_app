import 'dart:convert';
import 'dart:io';
import 'package:admin_panel_app/widgets/siceConfig.dart';
import 'package:admin_panel_app/widgets/widgets.dart';
import 'package:animated_background/animated_background.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show PlatformException, rootBundle;
import 'package:google_fonts/google_fonts.dart';

class audioInput extends StatefulWidget {
  String? title;

  audioInput(this.title);

  @override
  State<StatefulWidget> createState() {
    return audioInputState();
  }
}

class audioInputState extends State<audioInput> {
  late List<List<dynamic>> employeeData;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<PlatformFile>? _paths;
  String? _extension = "csv";
  FileType _pickingType = FileType.custom;
  bool loader = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController collection = new TextEditingController();
  bool errorText = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    employeeData = List<List<dynamic>>.empty(growable: true);
  }

  addDataToFirebase(String title , String thumbnail,String img,String url, String doc) async {
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection("Audios")
        .doc('1')
        .collection(collection.text)
        .doc()
      ..set({
        "title": title,
        "thumbnail": thumbnail,
        "img": img,
        "url": url,
      }).then((_) {
        print("success!");
      });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Adding ${widget.title}"),
          backgroundColor: Color(0xff021524),
        ),
        body: ListView(
          children: [
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      _openFileExplorer();
                    },
                    child: Container(
                        height: SizeConfig.blockSizeVertical! * 6,
                        width: SizeConfig.blockSizeHorizontal! * 45,
                        decoration: BoxDecoration(
                            color: Color(0xff021524),
                            borderRadius:
                            BorderRadius.all(Radius.circular(30))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            loader
                                ? Center(
                                child: CircularProgressIndicator(
                                  color: Color(0xff021524),
                                ))
                                : Text(
                              "Import File",
                              style: GoogleFonts.poppins(
                                  fontSize:
                                  SizeConfig.blockSizeHorizontal! * 4,
                                  color: Colors.white),
                            ),
                          ],
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      if (collection.text == "") {
                        setState(() {
                          errorText = true;
                        });
                      } else {
                        final snackBar = SnackBar(
                            backgroundColor: Color(0xff021524),
                            content: const Text(
                              'Data Added To The Firebase',
                              style: TextStyle(color: Colors.white),
                            ));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        setState(() {
                          errorText = false;
                          for(int i = 1 ; i < employeeData.length ; i++){
                            addDataToFirebase(employeeData[i][0].toString()
                                ,employeeData[i][1].toString(),
                                employeeData[i][2].toString(),
                                employeeData[i][3].toString(),
                                i.toString());
                          }
                          collection.clear();
                        });
                      }
                    },
                    child: Container(
                        height: SizeConfig.blockSizeVertical! * 6,
                        width: SizeConfig.blockSizeHorizontal! * 45,
                        decoration: BoxDecoration(
                            color: Color(0xff021524),
                            borderRadius:
                            BorderRadius.all(Radius.circular(30))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            loader
                                ? Center(
                                child: CircularProgressIndicator(
                                  color: Color(0xff021524),
                                ))
                                : Text(
                              "Post To Firebase",
                              style: GoogleFonts.poppins(
                                  fontSize:
                                  SizeConfig.blockSizeHorizontal! * 4,
                                  color: Colors.white),
                            ),
                          ],
                        )),
                  ),
                ),
              ],
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: SizeConfig.blockSizeVertical! * 3,
                  ),
                  Text(
                    "Add Category",
                    style: GoogleFonts.poppins(
                        fontSize: SizeConfig.blockSizeHorizontal! * 4.5,
                        color: Color(0xff021524)),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical! * 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: TextFormField(
                      controller: collection,
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: SizeConfig.blockSizeHorizontal! * 3.5),
                      cursorColor: Colors.white,
                      decoration: myDecoration('Add Collection Name'),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical! * 2,
                  ),
                  errorText
                      ? Text(
                    "Empty Text Field",
                    style: GoogleFonts.poppins(
                        fontSize: SizeConfig.blockSizeHorizontal! * 3.5,
                        color: Color(0xff021524)),
                  )
                      : SizedBox(),
                ],
              ),
            ),
            Container(
              height: SizeConfig.blockSizeVertical! * 60,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  itemCount: employeeData.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            employeeData[index][0].toString(),
                            style: GoogleFonts.poppins(
                                fontSize: SizeConfig.blockSizeHorizontal! * 4,
                                color: Color(0xff021524)),
                          ),
                          Text(
                            employeeData[index][1].toString(),
                            style: GoogleFonts.poppins(
                                fontSize: SizeConfig.blockSizeHorizontal! * 4,
                                color: Color(0xff021524)),
                          ),
                          Text(
                            employeeData[index][2].toString(),
                            style: GoogleFonts.poppins(
                                fontSize: SizeConfig.blockSizeHorizontal! * 4,
                                color: Color(0xff021524)),
                          ),
                          Text(
                            employeeData[index][3].toString(),
                            style: GoogleFonts.poppins(
                                fontSize: SizeConfig.blockSizeHorizontal! * 4,
                                color: Color(0xff021524)),
                          ),
                          Divider(
                            thickness: 4,
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  openFile(filepath) async {
    File f = new File(filepath);
    print("CSV to List");
    final input = f.openRead();
    final fields = await input
        .transform(utf8.decoder)
        .transform(new CsvToListConverter())
        .toList();
    print("My Data ${fields}");
    setState(() {
      employeeData = fields;
      print("Total Data Length : ${employeeData.length}");
    });
  }

  void _openFileExplorer() async {
    try {
      _paths = (await FilePicker.platform.pickFiles(
        type: _pickingType,
        allowMultiple: false,
        allowedExtensions: (_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll(' ', '').split(',')
            : null,
      ))
          ?.files;
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    } catch (ex) {
      print(ex);
    }
    if (!mounted) return;
    setState(() {
      openFile(_paths![0].path);
      print(_paths);
      print("File path ${_paths![0]}");
      print(_paths!.first.extension);
    });
  }
}