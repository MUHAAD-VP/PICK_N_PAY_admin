part of 'order_bloc.dart';

@immutable
abstract class OrderState {}

class OrderInitialState extends OrderState {}

class OrderLoadingState extends OrderState {}

class OrderGetSuccessState extends OrderState {
  final List<Map<String, dynamic>> orders;
  OrderGetSuccessState({required this.orders});
}

class OrderSuccessState extends OrderState {}

class OrderFailureState extends OrderState {
  final String message;
  OrderFailureState({this.message = apiErrorMessage});
}
