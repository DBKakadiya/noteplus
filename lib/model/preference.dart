import 'package:noteplus_demo/resources/resources.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference{
    Future<void> storeValue(key,value) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  getColor(key) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? color = prefs.getString(key) ?? colorOrange.toString();
    return color;
  }

  getImage(key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? image = prefs.getString(key) ?? imgBlank;
    return image;
  }
}