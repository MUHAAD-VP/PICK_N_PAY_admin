part of 'users_bloc.dart';

@immutable
abstract class UsersState {}

class UsersInitialState extends UsersState {}

class UsersLoadingState extends UsersState {}

class UsersGetSuccessState extends UsersState {
  final List<Map<String, dynamic>> users;

  UsersGetSuccessState({required this.users});
}

class UsersSuccessState extends UsersState {}

class UsersFailureState extends UsersState {
  final String message;

  UsersFailureState({required this.message});
}
