import 'package:flutter/material.dart';
import 'package:noteplus_demo/presentation/home_screen.dart';
import 'package:noteplus_demo/presentation/sync_screen.dart';
import 'package:noteplus_demo/presentation/theme_background_screen.dart';
import 'package:noteplus_demo/resources/resources.dart';

class DrawerData{
  final String icon;
  final String title;
  final String route;
  DrawerData(this.icon,this.title,this.route);
}

final drawerData = [
  DrawerData(icNotes, 'Notes', HomeScreen.routeName),
  DrawerData(icReminder, 'Reminders', HomeScreen.routeName),
  DrawerData(icArchive, 'Archive', HomeScreen.routeName),
  DrawerData(icTrash, 'Trash Can', HomeScreen.routeName),
  DrawerData(icThemeBG, 'theme & Background', ThemeBGScreen.routeName),
  DrawerData(icSyncAccount, 'Sync Account', SyncAccountScreen.routeName),
  DrawerData(icMores, 'Mores', HomeScreen.routeName),
  DrawerData(icHelp, 'Help', HomeScreen.routeName),
  DrawerData(icPrivacyPolicy, 'Privacy policy', HomeScreen.routeName),
];

class MyItem {
  final int id;
  final TextEditingController textFieldText;
  bool val;

  MyItem(this.id,this.textFieldText, {this.val = false});
}

class MoreVertData{
  final String title;
  final String route;

  MoreVertData(this.title,this.route);
}

final moreVertData = [
  MoreVertData('Check', HomeScreen.routeName),
  MoreVertData('Pin', HomeScreen.routeName),
  MoreVertData('Reminders', HomeScreen.routeName),
  MoreVertData('Archive', HomeScreen.routeName),
  MoreVertData('Delete', HomeScreen.routeName),
  MoreVertData('Colors', HomeScreen.routeName),
  MoreVertData('Make a copy', HomeScreen.routeName),
  MoreVertData('Share', HomeScreen.routeName),
];


class Theme{
  final Color bgColor;
  final Color checkColor;
  bool isCheck;

  Theme(this.bgColor,this.checkColor,this.isCheck);
}

final themeData = [
  Theme(colorOrange, colorRed, true),
  Theme(colorRed, colorYellow, false),
  Theme(colorGreen, colorPurple, false),
  Theme(colorBlue, colorCyan, false),
  Theme(colorPink, colorGreen, false),
  Theme(colorGrey, colorCyan, false),
  Theme(colorYellow, colorRed, false),
  Theme(colorCyan, colorGrey, false),
];


class Background{
  final String bgImage;
  bool isCheck;

  Background(this.bgImage,this.isCheck);
}

final bgImageData = [
  Background(imgBlank, true),
  Background(imgGrid1, false),
  Background(imgGrid2, false),
  Background(imgGrid3, false),
  Background(imgGrid4, false)
];