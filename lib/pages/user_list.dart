import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_manage/pages/user_form.dart';
import 'package:state_manage/services/bloc/userlist/bloc/userlist_bloc.dart';
import 'package:state_manage/services/modals/user.dart';

class UserLists extends StatefulWidget {
  const UserLists({super.key});

  @override
  State<UserLists> createState() => _UserListsState();
}

class _UserListsState extends State<UserLists> {

  final UserlistBloc userlistBloc =UserlistBloc();

 @override
  void initState() {
    userlistBloc.add(UserInitialFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("User List"),
        actions: [
              
              IconButton(
                  onPressed: () {
                    userlistBloc.add(CreateUserNavigateEvent());
                  },
                  icon: const Icon(Icons.add))
            ],
      ),
      body: BlocConsumer<UserlistBloc,UserlistState>(
        bloc: userlistBloc,
        listenWhen:(previous, current) => current is UserListActionState,
        buildWhen: (previous, current) => current is! UserListActionState,
        listener: (context, state) {
           if(state is UserUpdatingActionState){
           Navigator.push(
              context, MaterialPageRoute(builder: (context) =>  UserForm(user: state.user,)));
              
        }
         if(state is CreateUserActionState){
           Navigator.push(
              context, MaterialPageRoute(builder: (context) => UserForm()));
        }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case UserFetchingLoadingState:
              
              return const Center(
                  child: CircularProgressIndicator(),
                );
            case UserFetchingSuccessState:
            final result =state as UserFetchingSuccessState;
              return Container(
                color: Colors.grey.shade200,
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.all(16),
                child: ListView.builder(
                  itemCount: result.users.length,
                  itemBuilder: (context, index){
                    return  Card(
                      
                      child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                          ListTile(
                            title: Text("Name: ${result.users[index].name}"),
                            subtitle:Container(

                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Email: ${result.users[index].email}"),
                                  Text("Mobile No: ${result.users[index].mobileno}")
                                ],
                              ),
                            ) ,
                          ),
                            ButtonBar(
                            alignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: (){
                                  print(result.users[index]?.id.toString());
                                userlistBloc.add(UserEditEvent( user:User(id:result.users[index].id.toString(),name:result.users[index].name  , email: result.users[index].email, mobileno: result.users[index].mobileno)));
                                  
                                }, 
                                icon:const Icon(Icons.edit)),
                              IconButton(
                                onPressed: (){
                                     userlistBloc.add(UserDeleteEvent(id: result.users[index].id.toString()));
                                }, 
                                icon:const Icon(Icons.delete))
                            ],
                           ),
                         ], 
                          
                          
                      ),
                    );

                  }),
                   
              );
               default:
                return const SizedBox();
                                                                     
          }
          
        },
      ),
    );
  }
}// if(state is UserDeletingState){
                                  //    const CircularProgressIndicator();
                                  // }
                                  // else if(state is UserDeletedState){
                                  //   ScaffoldMessenger.of(context)
                                  //   .showSnackBar(const SnackBar(content: Text("Deleted "),));
                                  // }
                                  // else{
                                  //   const SizedBox(height:8);
                                  // }