import 'package:flutter/material.dart';

class CartItem {
  final String name;
  final double price;

  CartItem(this.name, this.price);
}

class CartModel extends ChangeNotifier {
  List<CartItem> _items = [];

  List<CartItem> get items => _items;

  double get totalPrice =>
      _items.fold(0.0, (total, item) => total + item.price);

  void addItem(CartItem item) {
    _items.add(item);
    notifyListeners();
  }

  void removeItem(CartItem item) {
    _items.remove(item);
    notifyListeners();
  }
}