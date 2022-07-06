import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/http_exception.dart';

const String API_key = "AIzaSyCeUwBRJNtqdBq71UN7NpJ-iLwWmf5bHI8";

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userID;

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
        print("Here");
        throw HttpException(responseData['error']['message']);
      }
    } catch (err) {
      rethrow;
    }
  }

  Future<void> signup({required String email, required String password}) async {
    return _authenticate(email, password, "signUp");
  }

  Future<void> logIn({required String email, required String password}) async {
    return _authenticate(email, password, "signInWithPassword");
  }
}
