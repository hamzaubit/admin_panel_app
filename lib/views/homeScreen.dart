import 'package:admin_panel_app/widgets/siceConfig.dart';
import 'package:admin_panel_app/widgets/widgets.dart';
import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'addCategories.dart';
import 'inputScreen.dart';

class homeScreen extends StatefulWidget {
  @override
  _homeScreenState createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Admin Panel"),
        backgroundColor: Color(0xff021524),
      ),
      body: AnimatedBackground(
        behaviour: RandomParticleBehaviour(),
        vsync: this,
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => addCategories()));
              },
              child: myQuoteTile("Adding Categories"),
            ),
            GestureDetector(
              onTap: (){
               Navigator.push(context, MaterialPageRoute(builder: (context) => CsvToList("Quotes")));
              },
              child: myQuoteTile("Adding Quotes"),
            ),
            GestureDetector(
              onTap: (){
                //Navigator.push(context, MaterialPageRoute(builder: (context) => CsvToList("Audios")));
              },
              child: myQuoteTile("Adding Audios"),
            ),
            GestureDetector(
              onTap: (){
                //Navigator.push(context, MaterialPageRoute(builder: (context) => CsvToList("Videos")));
              },
              child: myQuoteTile("Adding Videos"),
            ),
          ],
        ),
      ),
    );
  }
}
