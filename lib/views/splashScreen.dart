import 'dart:async';

import 'package:admin_panel_app/widgets/siceConfig.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'loginPage.dart';

class splashScreen extends StatefulWidget {
  @override
  _splashScreenState createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {

  @override
  void initState() {
    Timer(Duration(seconds: 3),(){
      Navigator.push(context, MaterialPageRoute(builder: (context) => loginPage()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color(0xff021524),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: SizeConfig.blockSizeVertical! * 17,
              width: SizeConfig.blockSizeHorizontal! * 34,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/72px@3x.png',),fit: BoxFit.cover
                  )
              ),
            ),
            SizedBox(height: SizeConfig.blockSizeVertical! * 1,),
            Text(
              "Day To Fortune",
              style: GoogleFonts.poppins(
                  color:  Color(0xffeacc08),
                  fontSize: SizeConfig.blockSizeHorizontal! * 5.5),
            ),
          ],
        ),
      ),
    );
  }
}
