part of 'user_bloc.dart';

@immutable
abstract class UserState {}

abstract class UserActionState extends UserState{}

final class UserInitial extends UserState {}

class UserSavingState extends UserState{

}
// ignore: must_be_immutable
class UserSavedState extends UserState{
  final String? message;

  UserSavedState({required this.message });

  
}
// ignore: must_be_immutable
class UserSaveErrorState extends UserState{
 final String? message;

  UserSaveErrorState({required this.message });
  
}

class ListUserNavigateActionState extends UserActionState{
  
}
class UserUpdatingState extends UserState{

}
// ignore: must_be_immutable
class UserUpdatedState extends UserState{
  final String? message;

  UserUpdatedState({required this.message });

  
}
// ignore: must_be_immutable
class UserUpdateErrorState extends UserState{
 final String? message;

  UserUpdateErrorState({required this.message });
  
}
