import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/http_exception.dart';

import 'product.dart';

class Products with ChangeNotifier {
  final List<Product> _items;
  final String _token;
  final String userID;

  Products(this._token, this._items, this.userID);

  List<Product> get getItems {
    return [..._items];
  }

  Future<void> loadProductFromServer([filterByUser = false]) async {
    final filterQuery =
        filterByUser ? 'orderBy="creatorID"&equalTo="$userID"' : '';
    final getUrl =
        'https://shop-app-af1f4-default-rtdb.firebaseio.com/products.json?auth=$_token&$filterQuery';
    final favUrl =
        'https://shop-app-af1f4-default-rtdb.firebaseio.com/userFavourites/$userID.json?auth=$_token';
    try {
      final response = await http.get(Uri.parse(getUrl));
      final favResponse = await http.get(Uri.parse(favUrl));
      final result = json.decode(response.body) as Map<String, dynamic>;
      final favResult = json.decode(favResponse.body);
      _items.clear();
      result.forEach((prodID, item) {
        //_items.clear();
        _items.add(Product(
            id: prodID,
            description: item['descriptiom'],
            title: item['title'],
            price: item['price'],
            isFavourite: favResult == null ? false : favResult[prodID] ?? false,
            imageUrl: item['imageUrl']));
      });
    } catch (error) {
      //print("hi");
      print(error);
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  Future<void> addNewProduct(Product prodData) async {
    final url =
        'https://shop-app-af1f4-default-rtdb.firebaseio.com/products?auth=${_token}';
    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            "creatorID": userID,
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

  Future<void> updateProduct(String prodID, Product updatedProduct) async {
    int prodIdx = _items.indexWhere((product) => prodID == product.id);
    final url =
        'https://shop-app-af1f4-default-rtdb.firebaseio.com/products/$prodID.json?auth=${_token}';
    // sanity check
    if (prodIdx >= 0) {
      final response = await http.patch(Uri.parse(url),
          body: json.encode({
            'title': updatedProduct.title,
            'price': updatedProduct.price,
            'descriptiom': updatedProduct.description,
            'imageUrl': updatedProduct.imageUrl
          }));
      //print(response.body);
      _items[prodIdx] = updatedProduct;
      notifyListeners();
    }
  }

  //utilizing optimistic updating
  Future<void> deleteProduct(String prodID) async {
    final deleteUrl =
        'https://shop-app-af1f4-default-rtdb.firebaseio.com/products/$prodID.json?auth=${_token}';
    final prodIdx = _items.indexWhere((prod) => prod.id == prodID);
    Product? existingProd = _items[prodIdx];
    _items.removeAt(prodIdx);
    notifyListeners();
    final response = await http.delete(Uri.parse(deleteUrl));
    if (response.statusCode > 300) {
      _items.insert(prodIdx, existingProd);
      notifyListeners();
      existingProd = null;
      throw HttpException("Could not delete the product");
    }
    existingProd = null;
  }
}
