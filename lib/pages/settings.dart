import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:http_cats/main.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});
  
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  
  bool switchState = true;
  Color themeColor = const Color(0xff0099ff);

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    var pref = appState.pref;  
    switchState = Theme.of(context).brightness == Brightness.dark;
    themeColor = Theme.of(context).primaryColor;
    
    void onThemeChange(bool val) async {
      var theme = val ? 'dark' : 'light';
      await pref?.setString('theme', theme);
      appState.refreshTheme();
      setState(() {
        switchState = val;
      });
    }
    
    void onColorChange() {
      showDialog(
        context: context, 
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Color scheme seed'),
            content: SingleChildScrollView(
              child: MaterialPicker(
                pickerColor: themeColor, 
                onColorChanged: (Color color) {
                  pref?.setInt('seed_color', color.value);
                  appState.refreshTheme();
                }
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                }, 
                child: const Text('Ok')
              ) 
            ],
          );
        },
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: const Text(
              'Settings',
              style: TextStyle(fontSize: 36),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 30),
            height: 70,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Theme', style: TextStyle(fontSize: 18),),
                      Text('Light/Dark theme', style: TextStyle(fontSize: 12),)
                    ],
                  )
                ),
                Row(
                  children: [
                    Icon(switchState ? Icons.light_mode_outlined : Icons.light_mode),
                    Switch(value: switchState, onChanged: onThemeChange),
                    Icon(switchState ? Icons.dark_mode : Icons.dark_mode_outlined),
                  ],
                ),
              ],
            )
          ),
          SizedBox(
            height: 70,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Color scheme', style: TextStyle(fontSize: 18),),
                      Text('Pick a color scheme based on a single color', style: TextStyle(fontSize: 12),)
                    ],
                  ),
                ),
                ElevatedButton(onPressed: onColorChange, child: const Text('Pick a color'),),
              ],
            )
          )
        ],
      ),
    );
  }
}