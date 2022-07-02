import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:shop_app/models/http_exception.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:http/http.dart' as http;

class OrderItem {
  final String id;
  final List<CartItem> items;
  final DateTime dtime;
  final double price;

  OrderItem(
      {required this.id,
      required this.items,
      required this.dtime,
      required this.price});
}

class Order with ChangeNotifier {
  List<OrderItem> _items = [];

  List<OrderItem> get items {
    return [..._items];
  }

  Future<void> setAndFetchOrders() async {
    const getOrdersUrl =
        'https://shop-app-af1f4-default-rtdb.firebaseio.com/orders.json';
    final response = await http.get(Uri.parse(getOrdersUrl));
    if (response.statusCode > 300) {
      throw HttpException("Could not refresh previous orders");
    }
    List<OrderItem> loadedOrders = [];
    print(json.decode(response.body));
    final extractedData = (json.decode(response.body) as Map<String, dynamic>)
        .forEach((key, data) {
      loadedOrders.add(OrderItem(
          id: key,
          items: (data['items'] as List<dynamic>)
              .map((cartItem) => CartItem(
                  id: cartItem['id'],
                  title: cartItem['title'],
                  price: cartItem['price'],
                  quantity: cartItem['quantity']))
              .toList(),
          dtime: DateTime.parse(data['dtime']),
          price: double.parse(data['total'])));

      _items = loadedOrders.reversed.toList();
    });
  }

  Future<void> addOrderItem(
      {required List<CartItem> cartItems, required String price}) async {
    const addOrderUrl =
        'https://shop-app-af1f4-default-rtdb.firebaseio.com/orders.json';
    final timestamp = DateTime.now();
    try {
      final response = await http.post(Uri.parse(addOrderUrl),
          body: json.encode({
            "items": cartItems
                .map((ci) => {
                      "id": ci.id,
                      "title": ci.title,
                      "quantity": ci.quantity,
                      "price": ci.price
                    })
                .toList(),
            "total": price,
            "dtime": timestamp.toIso8601String()
          }));

      _items.insert(
          0,
          OrderItem(
              id: json.decode(response.body)['name'],
              items: cartItems,
              dtime: timestamp,
              price: double.parse(price)));
      print(_items);
    } catch (err) {
      print(err.toString() + "Here");
      rethrow;
    }
    notifyListeners();
  }
}
