import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/src/cart_feature/models/cart_model.dart';
import 'package:my_app/src/cart_feature/models/product_model.dart';

  final CartChangeNotifierProvider = ChangeNotifierProvider<CartMvvm>((ref) => CartMvvm.instance);

class CartMvvm extends ChangeNotifier {
  //region singleton
  static CartMvvm? _instance;

  static CartMvvm get instance {
    if (_instance == null) {
      _instance = CartMvvm._();
    }
    return _instance!;
  }

  CartMvvm._() {
    _init();
  }

  //endregion

  bool _cartLoading = true;

  bool get cartLoading => _cartLoading;

  bool _cartLoaded = false;

  bool get cartLoaded => _cartLoaded;

  late CartModel _cart;

  CartModel get cart => _cart;

  Future<void> _init() async {
    //sumilate call API
    await Future.delayed(Duration(seconds: 2));
    _cartLoading = false;
    // initalize data
    _cart = CartModel();
    _cartLoaded = true;
    notifyListeners();
  }

  void addProduct(Product product) {
    try {
      _cart = CartModel(products: List.from(_cart.products)..add(product));
      notifyListeners();
    } catch (ex) {
      print(ex.toString());
    }
  }

  void removeProduct(Product product) {
    try {
      _cart = CartModel(products: List.from(_cart.products)..remove(product));
      notifyListeners();
    } catch (ex) {
      print(ex.toString());
    }
  }
}
