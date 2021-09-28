part of 'cart_bloc.dart';

@immutable
abstract class CartState extends Equatable {
  const CartState();
}


class CartLoading extends CartState {
  const CartLoading();

  @override
  List<Object?> get props => [];

}

class CartLoaded extends CartState {
  final CartModel cart;

  const CartLoaded({this.cart = const CartModel()});

  @override
  List<Object?> get props => [cart];
}

class CartError extends CartState {
  final String error;

  const CartError(this.error);

  @override
  List<Object?> get props => [error];
}
