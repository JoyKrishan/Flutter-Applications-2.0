import 'package:flutter/cupertino.dart';
import 'package:shop_app/providers/cart.dart';

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

  void addOrderItem({required List<CartItem> cartItems, required price}) {
    _items.insert(
        0,
        OrderItem(
            id: DateTime.now().toString(),
            items: cartItems,
            dtime: DateTime.now(),
            price: price));
    print(_items);
    notifyListeners();
  }
}
