import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:home_widget/home_widget.dart';
import 'package:noteplus_demo/presentation/home_screen.dart';
import 'package:noteplus_demo/presentation/notePad_screen.dart';
import 'package:noteplus_demo/presentation/search_screen.dart';
import 'package:noteplus_demo/presentation/splash_screen.dart';
import 'package:noteplus_demo/presentation/sync_screen.dart';
import 'package:noteplus_demo/presentation/theme_apply%20_screen.dart';
import 'package:noteplus_demo/presentation/theme_background_screen.dart';

import 'model/preference.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  AndroidInitializationSettings initializationSettingsAndroid =
  const AndroidInitializationSettings('app_icon');
  InitializationSettings initializationSettings =
  InitializationSettings(
      android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String? payload) async {
        if (payload != null) {
          debugPrint('notification payload: ' + payload);
        }
      });
  HomeWidget.registerBackgroundCallback(backgroundCallback);
  runApp(const MyApp());
}

Future<void> backgroundCallback(Uri? uri) async {
    String? _title;
    await HomeWidget.getWidgetData<String>('_title', defaultValue: '').then((value) {
      _title = value;
    });
    await HomeWidget.saveWidgetData<String>('_title', _title);
    await HomeWidget.updateWidget(name: 'MainActivity', iOSName: 'MainActivity');
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Color? _color;
  String? _image;


  _getColor()async{
    setState(() {});
    var color = await SharedPreference().getColor('color');
    String valueString = color.split('(0x')[1].split(')')[0]; // kind of hacky..
    int value = int.parse(valueString, radix: 16);
    setState(() {});
    _color = Color(value);
  }

  _getImage()async{
    setState(() {});
    var image = await SharedPreference().getImage('image');
    setState(() {});
    _image = image;
  }

  @override
  Widget build(BuildContext context) {
    _getColor();
    _getImage();
    return MaterialApp(
      title: 'Note Plus',
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      routes: {
        HomeScreen.routeName: (ctx) => const HomeScreen(),
        SyncAccountScreen.routeName: (ctx) => SyncAccountScreen(_color!,_image!),
        SearchScreen.routeName: (ctx) => SearchScreen(_color!,_image!),
        NotePadScreen.routeName: (ctx) => NotePadScreen(_color!,_image!),
        ThemeBGScreen.routeName: (ctx) => ThemeBGScreen(_color!),
        ApplyTheme.routeName: (ctx) => const ApplyTheme()
      },
    );
  }
}
