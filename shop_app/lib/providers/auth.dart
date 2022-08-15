import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/models/http_exception.dart';

const String API_key = "AIzaSyCeUwBRJNtqdBq71UN7NpJ-iLwWmf5bHI8";

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userID;
  Timer? _authTimer;

  bool get isAuth {
    if (token != null) {
      return true;
    } else {
      return false;
    }
  }

  String? get token {
    if (_token != null &&
        _expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now())) {
      return _token;
    }
    return null;
  }

  String? get userID {
    return _userID;
  }

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final authenticateURL =
        "https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=$API_key";
    try {
      final response = await http.post(Uri.parse(authenticateURL),
          body: json.encode({
            "email": email,
            "password": password,
            "returnSecureToken": true
          }));
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData["idToken"];
      _userID = responseData["localId"];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData["expiresIn"])));
      _autoLogout();
      notifyListeners(); // Login or SignUp complete
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        "token": _token,
        "userId": _userID,
        "expiryDate": _expiryDate!.toIso8601String()
      });
      prefs.setString("userData", userData);
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<bool> tryAutoLogin() async {
    print("Tried Auto login");
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey("userData")) {
      print("Tried Auto login 2");
      return false;
    }
    final extractedUserData = json.decode(prefs.getString("userData")!);
    final expiryDate =
        DateTime.parse(extractedUserData["expiryDate"] as String);
    if (expiryDate.isBefore(DateTime.now())) {
      print("Hi");
      return false;
    }

    _userID = extractedUserData["userId"];
    _token = extractedUserData["token"];
    _expiryDate = DateTime.parse(extractedUserData["expiryDate"]);
    print("Tried Auto login 3");
    _autoLogout();
    notifyListeners();
    return true;
  }

  Future<void> signup({required String email, required String password}) async {
    return _authenticate(email, password, "signUp");
  }

  Future<void> logIn({required String email, required String password}) async {
    return _authenticate(email, password, "signInWithPassword");
  }

  void logout() {
    _token = null;
    _userID = null;
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer!.cancel();
    }
    SharedPreferences.getInstance().then((prefs) => prefs.remove("userData"));
    notifyListeners();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer!.cancel();
    }
    int timeToExpiry = _expiryDate!.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }
}
