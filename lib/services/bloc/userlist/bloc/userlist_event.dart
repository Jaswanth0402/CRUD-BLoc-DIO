part of 'userlist_bloc.dart';

@immutable
abstract class UserlistEvent {}

class UserInitialFetchEvent extends UserlistEvent{

}

class UserDeleteEvent extends UserlistEvent{
   final String id;

  UserDeleteEvent({required this.id});

}
class UserEditEvent extends UserlistEvent{
  final User user;

  UserEditEvent({required this.user});
  
}
class CreateUserNavigateEvent extends UserlistEvent{

}