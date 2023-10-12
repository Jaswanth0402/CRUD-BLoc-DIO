part of 'userlist_bloc.dart';

@immutable
abstract class UserlistState {}

abstract class UserListActionState extends UserlistState{}

final class UserlistInitial extends UserlistState {}

class UserFetchingLoadingState extends UserlistState{

}
class UserFetchingSuccessState extends UserlistState{

 final List<User> users;
  UserFetchingSuccessState({
    required this.users,
  });
}

class UserDeletingState extends UserlistState{

}
class UserDeletedState extends UserlistState{
 final String message;

  UserDeletedState({required this.message});

}

class UserUpdatingActionState extends UserListActionState{
  final User user;

  UserUpdatingActionState({required this.user});
}
class CreateUserActionState extends UserListActionState{
 
}
