part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class CartDataStoreEvent extends CartEvent {
  final int cardId;
  final String productTitle;
  final int productPrice;
  final int productQuantity;
  final int productTotalAmount;
  final String productThumbnail;

  CartDataStoreEvent(this.cardId, this.productTitle, this.productPrice,
      this.productQuantity, this.productTotalAmount, this.productThumbnail);
}

class CartDataFetchEvent extends CartEvent {}

class CartDataRemoveEvent extends CartEvent {
  final String productTitle;

  CartDataRemoveEvent(this.productTitle);
}

class CartDataConfirmEvent extends CartEvent {}
