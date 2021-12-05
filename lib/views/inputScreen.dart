import 'dart:convert';
import 'dart:io';
import 'package:admin_panel_app/widgets/siceConfig.dart';
import 'package:animated_background/animated_background.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class CsvToList extends StatefulWidget{

  String? title;
  CsvToList(this.title);

  @override
  State<StatefulWidget> createState() {

    return CsvToListState();
  }

}
class CsvToListState extends State<CsvToList> {
  late List<List<dynamic>> employeeData;

  //final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<PlatformFile>? _paths;
  String? _extension="csv";
  FileType _pickingType = FileType.custom;
  bool loader = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    employeeData  = List<List<dynamic>>.empty(growable: true);
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
            SizedBox(height: SizeConfig.blockSizeVertical! * 4,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: (){
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
                            loader ? Center(child: CircularProgressIndicator(color: Color(0xff021524),)) : Text(
                              "Import File",
                              style: GoogleFonts.poppins(
                                  fontSize: SizeConfig.blockSizeHorizontal! * 4,
                                  color: Colors.white),
                            ),
                          ],
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: (){
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
                            loader ? Center(child: CircularProgressIndicator(color: Color(0xff021524),)) : Text(
                              "Import To Firebase",
                              style: GoogleFonts.poppins(
                                  fontSize: SizeConfig.blockSizeHorizontal! * 4,
                                  color: Colors.white),
                            ),
                          ],
                        )),
                  ),
                ),
              ],
            ),
            Container(
            height: SizeConfig.blockSizeVertical! * 90,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: employeeData.length,
                  itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
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
                          Divider(thickness: 4,),
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
    final fields = await input.transform(utf8.decoder).transform(new CsvToListConverter()).toList();
    print(fields);
    setState(() {
      employeeData=fields;
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


/*
SizedBox(height: SizeConfig.blockSizeVertical! * 4,),
Row(
mainAxisAlignment: MainAxisAlignment.spaceEvenly,
children: [
Padding(
padding: const EdgeInsets.all(8.0),
child: GestureDetector(
onTap: (){
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
loader ? Center(child: CircularProgressIndicator(color: Color(0xff021524),)) : Text(
"Import File",
style: GoogleFonts.poppins(
fontSize: SizeConfig.blockSizeHorizontal! * 4,
color: Colors.white),
),
],
)),
),
),
Padding(
padding: const EdgeInsets.all(8.0),
child: GestureDetector(
onTap: (){
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
loader ? Center(child: CircularProgressIndicator(color: Color(0xff021524),)) : Text(
"Import To Firebase",
style: GoogleFonts.poppins(
fontSize: SizeConfig.blockSizeHorizontal! * 4,
color: Colors.white),
),
],
)),
),
),
],
),*/
