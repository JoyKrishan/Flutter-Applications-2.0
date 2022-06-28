import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'product.dart';

class Products with ChangeNotifier {
  final List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  List<Product> get getItems {
    return [..._items];
  }

  Future<void> addNewProduct(Product prodData) async {
    const url = 'https://shop-app-af1f4-default-rtdb.firebaseio.com/produ';
    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            "title": prodData.title,
            "descriptiom": prodData.description,
            "price": prodData.price,
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
