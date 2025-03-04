part of 'shop_bloc.dart';

@immutable
abstract class ShopState {}

class ShopInitialState extends ShopState {}

class ShopLoadingState extends ShopState {}

class ShopGetSuccessState extends ShopState {
  final List<Map<String, dynamic>> shops;
  ShopGetSuccessState({required this.shops});
}

class ShopSuccessState extends ShopState {}

class ShopFailureState extends ShopState {
  final String message;
  ShopFailureState({this.message = apiErrorMessage});
}
