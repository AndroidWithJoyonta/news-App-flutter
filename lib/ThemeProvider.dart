import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier{

  bool _isDarkMode = false;
  bool getThemeValue() => _isDarkMode;


  ThemeProvider(){
    loadthemeShaf();
  }

  void updateThemeMode({required bool value}){
    _isDarkMode =value;
    notifyListeners();
    saveThemeShaf();
  }

  void loadthemeShaf() async{


    SharedPreferences prefes = await SharedPreferences.getInstance();
    _isDarkMode = await prefes.getBool('isDark') ?? false;
    notifyListeners();
  }

  void saveThemeShaf() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkMode = await prefs.setBool('isDark',  _isDarkMode);

  }


}