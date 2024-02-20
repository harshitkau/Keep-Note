import 'package:flutter/material.dart';
import 'package:keep_note/color.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0.0,
        title: Text("Settings"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(children: [
          Row(
            children: [
              Text(
                "Dark Mode",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              Spacer(),
              Transform.scale(
                scale: 1.2,
                child: Switch.adaptive(
                    value: value,
                    onChanged: (switchValue) {
                      setState(() {
                        this.value = switchValue;
                      });
                    }),
              )
            ],
          )
        ]),
      ),
    );
  }
}
