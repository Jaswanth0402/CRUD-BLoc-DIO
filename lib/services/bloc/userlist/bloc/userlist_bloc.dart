import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:state_manage/services/modals/response.dart';
import 'package:state_manage/services/modals/user.dart';
import 'package:state_manage/services/repositories/user_repo.dart';

part 'userlist_event.dart';
part 'userlist_state.dart';

class UserlistBloc extends Bloc<UserlistEvent, UserlistState> {
  UserlistBloc() : super(UserlistInitial()) {
   on<UserInitialFetchEvent>(userInitialFetchEvent);
   on<UserDeleteEvent>(userDeleteEvent);
   on<UserEditEvent>(userEditEvent);
   on<CreateUserNavigateEvent>(createUserNavigateEvent);
  }

  FutureOr<void> userInitialFetchEvent(UserInitialFetchEvent event, Emitter<UserlistState> emit) async{
    emit(UserFetchingLoadingState());
    List<User> users = await UserMethods.getuser();    
    emit(UserFetchingSuccessState(users:users));  
  
  }

  FutureOr<void> userDeleteEvent(UserDeleteEvent event, Emitter<UserlistState> emit)async {
    // emit(UserDeletingState());
    print('data delete');
   var res = await UserMethods.deleteuser(id:event.id);
    // if(res.code==200){
      add(UserInitialFetchEvent());
    // }
    
    // emit(UserDeletedState(message:res.message.toString()));
  }

  FutureOr<void> userEditEvent(UserEditEvent event, Emitter<UserlistState> emit) async{
     emit(UserUpdatingActionState(user: event.user));
  }

  FutureOr<void> createUserNavigateEvent(CreateUserNavigateEvent event, Emitter<UserlistState> emit) {
    emit(CreateUserActionState());
  }
}
