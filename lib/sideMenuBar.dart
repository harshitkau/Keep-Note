import 'package:flutter/material.dart';
import 'package:keep_note/archiv.dart';
import 'package:keep_note/color.dart';
import 'package:keep_note/home.dart';
import 'package:keep_note/pin_note.dart';
import 'package:keep_note/settings.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(color: bgColor),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 16, horizontal: 25),
                child: Text(
                  "Keep Notes",
                  style: TextStyle(
                      color: white, fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ),
              Divider(
                color: white.withOpacity(0.3),
              ),
              _SectioOne(),
              SizedBox(
                height: 5,
              ),
              _Sectionfour(),
              SizedBox(
                height: 5,
              ),
              _SectioTwo(),
              SizedBox(
                height: 5,
              ),
              _SectioSetting(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _SectioOne() {
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: TextButton(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(Colors.orangeAccent.withOpacity(0.3)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(50),
                  bottomRight: Radius.circular(50)),
            ))),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Home()));
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Row(
            children: [
              Icon(
                Icons.lightbulb_outline,
                size: 27,
                color: white.withOpacity(0.7),
              ),
              SizedBox(width: 27),
              Text(
                "Notes",
                style: TextStyle(color: white.withOpacity(0.7), fontSize: 18),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _SectioTwo() {
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: TextButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(50), bottomRight: Radius.circular(50)),
        ))),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ArchiveView()));
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Row(
            children: [
              Icon(
                Icons.archive_outlined,
                size: 27,
                color: white.withOpacity(0.7),
              ),
              SizedBox(width: 27),
              Text(
                "Archive",
                style: TextStyle(color: white.withOpacity(0.7), fontSize: 18),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _Sectionfour() {
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: TextButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(50), bottomRight: Radius.circular(50)),
        ))),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => PinNotes()));
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Row(
            children: [
              Icon(
                Icons.push_pin_outlined,
                size: 27,
                color: white.withOpacity(0.7),
              ),
              SizedBox(width: 27),
              Text(
                "Pin",
                style: TextStyle(color: white.withOpacity(0.7), fontSize: 18),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _SectioSetting() {
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: TextButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(50), bottomRight: Radius.circular(50)),
        ))),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Settings()));
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Row(
            // crossAxisAlignment: ,
            children: [
              Icon(
                Icons.settings_outlined,
                size: 27,
                color: white.withOpacity(0.7),
              ),
              SizedBox(width: 27),
              Text(
                "Settings",
                style: TextStyle(color: white.withOpacity(0.7), fontSize: 18),
              )
            ],
          ),
        ),
      ),
    );
  }
}
