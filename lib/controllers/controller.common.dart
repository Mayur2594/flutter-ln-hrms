import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommonController extends GetxController {
  Future<void> saveDetailsInSharedPref(keyname, data) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      switch (data.runtimeType) {
        case int:
          {
            prefs.setString(keyname, data.toString().trim());
          }
        case String:
          {
            prefs.setString(keyname, data.toString().trim());
          }
        default:
          {
            prefs.setString(keyname, json.encode(data).toString().trim());
          }
      }
    } catch (ex) {
      print('Exception in saveDetailsInSharedPref $ex');
    }
  }

  Future<String?> getDetailsFromSharedPref(keyname) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var value = prefs.getString(keyname);
      if (value != null) {
        return value;
      }
      return "";
    } catch (ex) {
      print("Exception in getDetailsFromSharedPref ${ex}");
      return "";
    }
  }
}
