part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

class CartDataFetchingLoadingState extends CartState {}

class CartDataFetchingErrorState extends CartState {
  final String error;

  CartDataFetchingErrorState(this.error);
}

class CartDataStoreSuccessState extends CartState {
  final String successMessage;

  CartDataStoreSuccessState(this.successMessage);
}

class CartDataFetchSuccessState extends CartState {
  final List<CartModel> carts;

  CartDataFetchSuccessState(this.carts);
}
