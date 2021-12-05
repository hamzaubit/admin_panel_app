import 'package:admin_panel_app/widgets/siceConfig.dart';
import 'package:admin_panel_app/widgets/widgets.dart';
import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class addCategories extends StatefulWidget {
  @override
  _addCategoriesState createState() => _addCategoriesState();
}

class _addCategoriesState extends State<addCategories> with TickerProviderStateMixin {

  final _formKey = GlobalKey<FormState>();
  TextEditingController category = new TextEditingController();
  bool loader = false;
  bool errorText = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: AnimatedBackground(
        behaviour: RandomParticleBehaviour(),
        vsync: this,
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox( height: SizeConfig.blockSizeVertical! * 12,),
                  Text(
                    "Adding Category",
                    style: GoogleFonts.poppins(
                        fontSize: SizeConfig.blockSizeHorizontal! * 6.5,
                        color:  Color(0xff021524)),
                  ),
                  SizedBox( height: SizeConfig.blockSizeVertical! * 8,),
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: TextFormField(
                      controller: category,
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize:
                          SizeConfig.blockSizeHorizontal! * 3.5),
                      cursorColor: Colors.white,
                      decoration: myDecoration('Add Category Name'),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical! * 2,
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical! * 4,
                  ),
                  GestureDetector(
                    onTap: (){
                      if(category.text == ""){
                        setState(() {
                          errorText = true;
                        });
                      }
                      else{
                        setState(() {
                          errorText = false;
                          category.clear();
                          final snackBar = SnackBar(
                              backgroundColor: Color(0xff021524),
                              content: const Text('Category Added To The Firebase',style: TextStyle(color: Colors.white),
                              ));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        });
                      }
                    },
                    child: Container(
                        height: SizeConfig.blockSizeVertical! * 6,
                        width: SizeConfig.blockSizeHorizontal! * 40,
                        decoration: BoxDecoration(
                            color: Color(0xff021524),
                            borderRadius:
                            BorderRadius.all(Radius.circular(30))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            loader ? Center(child: CircularProgressIndicator(color: Color(0xff021524),)) : Text(
                              "Add",
                              style: GoogleFonts.poppins(
                                  fontSize: SizeConfig.blockSizeHorizontal! * 4,
                                  color: Colors.white),
                            ),
                          ],
                        )),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical! * 2,
                  ),
                  errorText ? Text(
                    "Empty Text Field",
                    style: GoogleFonts.poppins(
                        fontSize: SizeConfig.blockSizeHorizontal! * 3.5,
                        color:  Color(0xff021524)),
                  ) : SizedBox(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
