import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/cart/model/cart_model.dart';
import 'package:ecommerce_app/cart/repos/cart_repo.dart';
import 'package:flutter/material.dart';
// import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartEvent>((event, emit) {});

    on<CartDataStoreEvent>((event, emit) async {
      try {
        emit(CartDataFetchingLoadingState());
        String successMessage = await CartRepo.storeCartData(
            event.cardId,
            event.productTitle,
            event.productPrice,
            event.productQuantity,
            event.productTotalAmount,
            event.productThumbnail);
        emit(CartDataStoreSuccessState(successMessage));
      } catch (e) {
        emit(CartDataFetchingErrorState(e.toString()));
      }
    });
    on<CartDataFetchEvent>((event, emit) async {
      emit(CartDataFetchingLoadingState());
      List<CartModel> carts = await CartRepo.fetchCartData();
      emit(CartDataFetchSuccessState(carts));
    });

    on<CartDataRemoveEvent>((event, emit) async {
      emit(CartDataFetchingLoadingState());
      List<CartModel> carts = await CartRepo.deleteCartData(event.productTitle);
      emit(CartDataFetchSuccessState(carts));
    });

    on<CartDataConfirmEvent>((event, emit) async {
      emit(CartDataFetchingLoadingState());
      List<CartModel> carts = await CartRepo.confirmCartData();
      emit(CartDataFetchSuccessState(carts));
    });
  }
}
