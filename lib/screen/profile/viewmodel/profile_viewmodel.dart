import 'package:flutter/material.dart';
import 'package:ggame/res/string_src.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileViewModel extends ChangeNotifier {
  String _name = '';
  String get name => _name;

  List<String> _list = [];
  List<String> get listInterest => _list;

  setName(String name) async {
    var sharedPref = await SharedPreferences.getInstance();
    if (name.isNotEmpty) {
      sharedPref.setString(SharedPrefs.name, name);
      _name = name;
      notifyListeners();
    }
  }

  setSelectedCategory(String category) {
    if (_list.contains(category)) {
      _list.remove(category);
    } else {
      _list.add(category);
    }
    notifyListeners();
  }

  setListInterest(List<String> list) async {
    var sharedPref = await SharedPreferences.getInstance();
    sharedPref.setStringList(SharedPrefs.listCategory, list);
    notifyListeners();
  }

  void getProfile() async {
    var sharedPref = await SharedPreferences.getInstance();
    var name = sharedPref.getString(SharedPrefs.name) ?? '';
    var list = sharedPref.getStringList(SharedPrefs.listCategory) ?? [];
    if (!list.contains('All')) {
      list.insert(0, 'All');
    }
    _name = name;
    _list = list;
    notifyListeners();
  }

  deleteProfile() async {
    var sharedPref = await SharedPreferences.getInstance();
    sharedPref.remove(SharedPrefs.name);
    sharedPref.remove(SharedPrefs.listCategory);
    notifyListeners();
  }
}
