import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/home_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppState(),
      child: const MainApp()
    )
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => MainAppState();
}

class MainAppState extends State<MainApp> {

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    appState.init();
    var colorSchemeSeed = appState.colorSchemeSeed;
    var colorSchemeBrightness = appState.colorSchemeBrightness;
    appState.refreshTheme();

    return MaterialApp(
      title:"HTTP Cats",
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Color(colorSchemeSeed), brightness: colorSchemeBrightness),
      ),
      home: const HomePage()
    );
  }
}

class AppState extends ChangeNotifier {
  SharedPreferences? pref;
  final String keyTheme = 'theme';
  final String keySeed = 'seed_color';
  
  int colorSchemeSeed = 0xff0099ff;
  Brightness colorSchemeBrightness = Brightness.dark; 
  
  void init() async {
    pref ??= await SharedPreferences.getInstance();
  }

  void refreshTheme() async {
    colorSchemeSeed = await pref?.getInt(keySeed) ?? colorSchemeSeed;
    var theme = await pref?.getString(keyTheme);
    if (theme != null) {
      switch (theme) {
        case 'light': {
          colorSchemeBrightness = Brightness.light;
          break;
        }
        case 'dark': {
          colorSchemeBrightness = Brightness.dark;
          break;
        }
        default: {
            // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('MF SOMETHING HAPPENED')));
          break;
        }
      }
    }
      
    notifyListeners();
  }  
}