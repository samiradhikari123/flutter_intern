part of 'user_details_bloc.dart';

@immutable
sealed class UserDetailsState {}

final class UserDetailsInitial extends UserDetailsState {}

final class UserDetailLoadingState extends UserDetailsState {}

final class UserDetailFetchState extends UserDetailsState {}

final class UserDetailFetchSuccessState extends UserDetailsState {
  final LoginModel? username;
  final LoginModel? image;

  UserDetailFetchSuccessState({this.username, this.image});
}

final class UserDetailFetchErrorState extends UserDetailsState {
  final String? error;

  UserDetailFetchErrorState({this.error});
}
