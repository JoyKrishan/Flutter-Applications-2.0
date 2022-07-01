import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/http_exception.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;
  CartItem(
      {required this.id,
      required this.title,
      required this.price,
      required this.quantity});
}

class Cart with ChangeNotifier {
  // productId as key and CartItem as value
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get totalItem {
    return _items.length;
  }

  String get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total.toStringAsFixed(1);
  }

  Future<void> addItem(String productID, String title, double price) async {
    const cartPostUrl =
        'https://shop-app-af1f4-default-rtdb.firebaseio.com/carts.json';

    if (_items.containsKey(productID)) {
      final existingCartItem = _items[productID];
      final cartPatchUrl =
          'https://shop-app-af1f4-default-rtdb.firebaseio.com/carts/${existingCartItem!.id}';
      final response = await http.patch(Uri.parse(cartPatchUrl),
          body: json.encode({"quantity": existingCartItem.quantity + 1}));
      if (response.statusCode > 300) {
        throw HttpException("Could not add product to Cart");
      }
      _items.update(
          productID,
          (existingItem) => CartItem(
              id: existingItem.id,
              title: existingItem.title,
              price: existingItem.price,
              quantity: existingItem.quantity + 1));
    } else {
      _items.putIfAbsent(
          productID,
          () => CartItem(
              id: DateTime.now().toString(),
              title: title,
              price: price,
              quantity: 1));
    }
    notifyListeners();
  }

  void removeItem(productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(productId) {
    if (_items[productId]!.quantity > 1) {
      _items.update(
          productId,
          (exitingItem) => CartItem(
              id: exitingItem.id,
              title: exitingItem.title,
              price: exitingItem.price,
              quantity: exitingItem.quantity - 1));
    } else {
      _items.remove(productId);
      notifyListeners();
    }
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
