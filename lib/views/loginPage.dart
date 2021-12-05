import 'dart:async';

import 'package:admin_panel_app/widgets/siceConfig.dart';
import 'package:admin_panel_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'homeScreen.dart';

class loginPage extends StatefulWidget {
  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  bool _passwordVisible = false;
  bool loader = false;
  bool errorText = false;
  bool invalidText = false;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox( height: SizeConfig.blockSizeVertical! * 12,),
            Text(
              "Day To Fortune",
              style: GoogleFonts.poppins(
                  fontSize: SizeConfig.blockSizeHorizontal! * 6.5,
                  color:  Color(0xff021524)),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 5,
            ),
            Center(
              child: Container(
                height: SizeConfig.blockSizeVertical! * 65,
                width: SizeConfig.blockSizeHorizontal! * 80,
                decoration: BoxDecoration(
                    color: Color(0xff021524),
                    border: Border.all(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Column(
                  children: [
                    SizedBox(
                      height: SizeConfig.blockSizeVertical! * 4,
                    ),
                    Container(
                      height: SizeConfig.blockSizeVertical! * 12,
                      width: SizeConfig.blockSizeHorizontal! * 24,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage('assets/images/72px@3x.png'),
                      )),
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical! * 2.5,
                    ),
                    Text(
                      "Sign In",
                      style: GoogleFonts.poppins(
                          fontSize: SizeConfig.blockSizeHorizontal! * 5.5,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical! * 3,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: TextFormField(
                              controller: email,
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize:
                                      SizeConfig.blockSizeHorizontal! * 3.5),
                              cursorColor: Colors.white,
                              decoration: myDecoration('E-mail Address'),
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.blockSizeVertical! * 2,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: TextFormField(
                                controller: password,
                                obscureText: !_passwordVisible,
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: SizeConfig.blockSizeHorizontal! * 3.5),
                                cursorColor: Colors.white,
                                decoration: myDecoration('Password'),
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.blockSizeVertical! * 4,
                          ),
                          GestureDetector(
                            onTap: (){
                              if(email.text == "" || password.text == ""){
                                setState(() {
                                  errorText = true;
                                });
                              }
                              else if(email.text == "dtf" && password.text == "12345"){
                                setState(() {
                                  loader = true;
                                  invalidText = false;
                                  errorText = false;
                                });
                                Timer(Duration(seconds: 2),(){
                                  setState(() {
                                    loader = false;
                                  });
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => homeScreen()));
                                });
                              }
                              else{
                                setState(() {
                                  invalidText = true;
                                  errorText = false;
                                });
                              }
                            },
                            child: Container(
                                height: SizeConfig.blockSizeVertical! * 6,
                                width: SizeConfig.blockSizeHorizontal! * 40,
                                decoration: BoxDecoration(
                                    color: Colors.yellow,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    loader ? Center(child: CircularProgressIndicator(color: Color(0xff021524),)) : Text(
                                      "Login",
                                      style: GoogleFonts.poppins(
                                          fontSize: SizeConfig.blockSizeHorizontal! * 4,
                                          color: Colors.black),
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
                                color: Colors.yellow),
                          ) : SizedBox(),
                          invalidText ? Text(
                            "Invalid Email or Password",
                            style: GoogleFonts.poppins(
                                fontSize: SizeConfig.blockSizeHorizontal! * 3.5,
                                color: Colors.yellow),
                          ) : SizedBox(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
