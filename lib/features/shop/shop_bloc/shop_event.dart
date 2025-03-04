part of 'shop_bloc.dart';

@immutable
abstract class ShopEvent {}

class GetAllShopsEvent extends ShopEvent {
  final Map<String, dynamic> params;
  GetAllShopsEvent({required this.params});
}

class AddShopEvent extends ShopEvent {
  final Map<String, dynamic> shopDetails;
  AddShopEvent({required this.shopDetails});
}

class EditShopEvent extends ShopEvent {
  final int shopId;
  final Map<String, dynamic> shopDetails;
  EditShopEvent({required this.shopId, required this.shopDetails});
}

class DeleteShopEvent extends ShopEvent {
  final int shopId;
  DeleteShopEvent({required this.shopId});
}
