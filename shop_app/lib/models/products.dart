import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'product.dart';

class Products with ChangeNotifier {
  final List<Product> _items = [];

  List<Product> get getItems {
    return [..._items];
  }

  Future<void> loadProductFromServer() async {
    const getUrl =
        'https://shop-app-af1f4-default-rtdb.firebaseio.com/products.json';
    try {
      final response = await http.get(Uri.parse(getUrl));
      final result = json.decode(response.body) as Map<String, dynamic>;
      result.forEach((key, item) {
        _items.add(Product(
            id: key,
            description: item['descriptiom'],
            title: item['title'],
            price: item['price'],
            isFavourite: item['isFavourite'],
            imageUrl: item['imageUrl']));
      });
    } catch (error) {
      print("hi");
      print(error);
    } finally {
      notifyListeners();
    }
  }

  Future<void> addNewProduct(Product prodData) async {
    const url =
        'https://shop-app-af1f4-default-rtdb.firebaseio.com/products.json';
    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            "title": prodData.title,
            "descriptiom": prodData.description,
            "price": prodData.price,
            "imageUrl": prodData.imageUrl,
            "isFavourite": prodData.isFavourite
          }));
      Product newProd = Product(
          id: json.decode(response.body)['name'],
          description: prodData.description,
          title: prodData.title,
          price: prodData.price,
          imageUrl: prodData.imageUrl);
      _items.add(newProd);
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  List<Product> showFavouriteItems(bool filter) {
    return _items.where((item) => item.isFavourite == filter).toList();
  }

  Product getById(String id) {
    return _items.firstWhere((item) => item.id == id);
  }

  void updateProduct(String prodID, Product updatedProduct) {
    int prodIdx = _items.indexWhere((product) => prodID == product.id);
    _items[prodIdx] = updatedProduct;
    notifyListeners();
  }

  void deleteProduct(String prodID) {
    _items.removeWhere((product) => product.id == prodID);
    notifyListeners();
  }
}
