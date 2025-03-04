part of 'order_bloc.dart';

@immutable
abstract class OrderEvent {}

class GetAllOrdersEvent extends OrderEvent {
  final Map<String, dynamic> params;
  GetAllOrdersEvent({required this.params});
}

class AddOrderEvent extends OrderEvent {
  final Map<String, dynamic> orderDetails;
  AddOrderEvent({required this.orderDetails});
}

class EditOrderEvent extends OrderEvent {
  final int orderId;
  final Map<String, dynamic> orderDetails;
  EditOrderEvent({required this.orderId, required this.orderDetails});
}

class DeleteOrderEvent extends OrderEvent {
  final int orderId;
  DeleteOrderEvent({required this.orderId});
}
