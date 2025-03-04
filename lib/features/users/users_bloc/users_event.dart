part of 'users_bloc.dart';

@immutable
abstract class UsersEvent {}

class GetAllUsersEvent extends UsersEvent {
  final Map<String, dynamic> params;

  GetAllUsersEvent({required this.params});
}
