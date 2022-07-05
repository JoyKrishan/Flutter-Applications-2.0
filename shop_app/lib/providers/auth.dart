import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

const String API_key = "AIzaSyCeUwBRJNtqdBq71UN7NpJ-iLwWmf5bHI8";

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userID;

  Future<void> signup({required String email, required String password}) async {
    const signUpUrl =
        "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$API_key";
    final response = await http.post(Uri.parse(signUpUrl),
        body: json.encode(
            {"email": email, "password": password, "returnSecureToken": true}));
    print(response.body);
  }

  Future<void> logIn({required String email, required String password}) async {
    const loginUrl =
        "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$API_key";
    final response = await http.post(Uri.parse(loginUrl),
        body: json.encode(
            {"email": email, "password": password, "returnSecureToken": true}));

    print(response.body);
  }
}
