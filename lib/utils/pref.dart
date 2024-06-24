import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


class SharedPref {
// Save data to local storage
//   static saveProfileToLocalStorage(CustomerProfile profile) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setString('customerProfile', jsonEncode(profile.toJson()));
//   }
//   static saveProviderProfileToLocalStorage(ProviderGetProfileModel profile) async {
//     log("shared  == ${profile.username}");
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setString('providerProfile', jsonEncode(profile.toJson()));
//   }

  static readObject(String key) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.get(key) != null) {
      return prefs.get(key);
    } else {
      return null;
    }
  }

  static readString(String key) async {
    final value = await readObject(key);
    return value ?? '';
  }

  static readInt(String key) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.get(key) != null) {
      return prefs.get(key);
    } else {
      return 0;
    }
  }

  static saveObject(String key, value) async {
    await saveString(key, json.encode(value));
  }

  static saveString(String key, value) async {
    print("value: " + value);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static saveInt(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, value);
  }

  static resetData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static saveStatus(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }
}
