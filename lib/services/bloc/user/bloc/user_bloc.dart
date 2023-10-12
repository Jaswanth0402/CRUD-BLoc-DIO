import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:state_manage/services/modals/user.dart';
import 'package:state_manage/services/repositories/user_repo.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on <CreateUserEvent>(createUserEvent);
    on<ListUserNavigateEvent>(listUserNavigateEvent);
    on<UpdateUserEvent>(updateUserEvent);
  }
   
 
  FutureOr<void> createUserEvent(CreateUserEvent event, Emitter<UserState> emit) async {
   
   

   var res=await UserMethods.adduser(email: event.email,name:event.name,mobileno: event.mobileno);
      print(res.message);
   if(res.code == null){
  emit(UserSavingState());
   }
   else if(res.code ==200){
   emit(UserSavedState(message: res.message));
   }
   else if(res.code ==400){
    emit(UserSaveErrorState(message: res.message));
   }
   else {
    return null;
   }
        
        
    }


  FutureOr<void> listUserNavigateEvent(ListUserNavigateEvent event, Emitter<UserState> emit) {
       emit(ListUserNavigateActionState());
  }

  FutureOr<void> updateUserEvent(UpdateUserEvent event, Emitter<UserState> emit)async {
    var res=await UserMethods.edituser( user:event.user);
      print(res.message);
   if(res.code == null){
  emit(UserUpdatingState());
   }
   else if(res.code! ==200){
   emit(UserUpdatedState(message: res.message));
   }
   else if(res.code! <=400){
    emit(UserUpdateErrorState(message: res.message));
   }
   else {
    return null;
   }
  }
}
