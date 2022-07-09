import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/http_exception.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourite;

  Product({
    required this.id,
    required this.description,
    required this.title,
    required this.price,
    required this.imageUrl,
    this.isFavourite = false,
  });

  //utilizing optimistic updating
  Future<void> toggleIsFavourite(String token, String userID) async {
    final patchUrl =
        'https://shop-app-af1f4-default-rtdb.firebaseio.com/userFavourites/$userID/$id.json?auth=$token';
    bool? existingFav = isFavourite;
    isFavourite = !isFavourite;
    notifyListeners();
    final response =
        await http.put(Uri.parse(patchUrl), body: json.encode(isFavourite));
    if (response.statusCode > 300) {
      isFavourite = existingFav;
      existingFav = null;
      notifyListeners();
      print(response.body);
      throw HttpException("Could not add to Favourites");
    }
    existingFav = null;
  }
}
