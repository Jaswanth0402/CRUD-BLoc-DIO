part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

// ignore: must_be_immutable
class CreateUserEvent extends UserEvent {
  String name;
  String email;
  String mobileno;

  CreateUserEvent({required this.name,required this.email,required this.mobileno});

}
class ListUserNavigateEvent extends UserEvent{

}
class UpdateUserEvent extends UserEvent {
  User user;

  UpdateUserEvent({ required this.user});

}


