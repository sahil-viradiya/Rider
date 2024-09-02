import 'dart:convert';
import 'dart:developer';
import 'package:rider/constant/api_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static final String kAuthKey = Config.kAuth;

  static Future<void> setToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(kAuthKey, token);
    log("Token saved: $token");
  }

  static Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(kAuthKey);
    if (token == null || token.isEmpty) {
      log("No token found or token is empty.");
      return null;
    }
    log("Retrieved token: $token");
    return token;
  }

  static Future<Map<String, dynamic>?> readObject(String key) async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(key);
    if (jsonString != null) {
      try {
        // Decode the JSON string to a Map<String, dynamic>
        return jsonDecode(jsonString) as Map<String, dynamic>;
      } catch (e) {
        print('Error decoding JSON: $e');
        return null;
      }
    }
    return null; // Return null if the key does not exist
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
