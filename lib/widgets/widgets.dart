import 'package:admin_panel_app/widgets/siceConfig.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

myDecoration(String hintText){
  return InputDecoration(
    fillColor: Color(0xff021524),
    filled: true,
    border: OutlineInputBorder(
        borderSide: BorderSide(
            color: Colors.white, width: 0.5),
        borderRadius:
        BorderRadius.all(Radius.circular(30))),
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: Colors.white, width: 0.5),
        borderRadius:
        BorderRadius.all(Radius.circular(30))),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: Colors.white, width: 0.5),
        borderRadius:
        BorderRadius.all(Radius.circular(30))),
    hintText: hintText,
    hintStyle: GoogleFonts.poppins(
        color: Colors.white,
        fontSize:
        SizeConfig.blockSizeHorizontal! * 3.5),
  );
}

myQuoteTile(String quoteText){
  return Padding(
    padding: const EdgeInsets.only(left: 10,right: 10,top: 6,bottom: 6),
    child: Container(
      height: SizeConfig.blockSizeVertical! * 8,
      decoration: BoxDecoration(
          color: Color(0xff021524),
          border: Border.all(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Center(
        child: Text(
          quoteText,
          style: GoogleFonts.poppins(
              fontSize: SizeConfig.blockSizeHorizontal! * 5,
              color: Colors.white),
        ),
      ),
    ),
  );
}