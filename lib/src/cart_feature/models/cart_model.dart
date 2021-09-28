import 'package:equatable/equatable.dart';
import 'package:my_app/src/cart_feature/models/product_model.dart';


class CartModel extends Equatable {
  final List<Product> products;

  const CartModel({this.products = const <Product>[]});

  double get subTotal => products.fold(0, (total, current) => (total + current.price));

  double deliveryFee(double subTotal) {
    if (subTotal >= 30.0) {
      return 0.0;
    }
    return 10.0;
  }

  double total(subtotal, deliveryfee) {
    return subTotal + deliveryfee;
  }


  String get subTtoalString => subTotal.toStringAsFixed(2);
  String get deliveryFeeString => deliveryFee(subTotal).toStringAsFixed(2);
  String get totalString => total(subTotal, deliveryFee(subTotal)).toStringAsFixed(2);
  

  @override
  List<Object?> get props => [products];
}