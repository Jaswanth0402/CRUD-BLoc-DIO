import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_manage/pages/user_list.dart';
import 'package:state_manage/services/bloc/user/bloc/user_bloc.dart';
import 'package:state_manage/services/function/validate.dart';
import 'package:state_manage/services/modals/user.dart';


class UserForm extends StatefulWidget {
  User? user;

  
   UserForm({super.key, this.user});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  
  final GlobalKey<FormState> _key = GlobalKey();
@override
  void initState() {
    super.initState();
    widget.user?.id != null?
  (
    id.value =TextEditingValue(text: widget.user!.id.toString()),
    name.value = TextEditingValue(text: widget.user!.name.toString()),
   mobileno.value = TextEditingValue(text: widget.user!.mobileno.toString()),
   email.value = TextEditingValue(text: widget.user!.email.toString())): '';
    
  }
  final id =TextEditingController();
  final name = TextEditingController();
  final email = TextEditingController();
  final mobileno = TextEditingController();

  final Validate validate = Validate();

  final UserBloc userBloc = UserBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      bloc: userBloc,
      listenWhen: (previous, current) => current is UserActionState,
      buildWhen: (previous, current) => current is! UserActionState,
      listener: (context, state) {
        if(state is ListUserNavigateActionState){
           Navigator.push(
              context, MaterialPageRoute(builder: (context) => const UserLists()));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("CRUD Operation"),
            actions: [
              
              IconButton(
                  onPressed: () {
                    userBloc.add(ListUserNavigateEvent());
                  },
                  icon: const Icon(Icons.list))
            ],
          ),
          body: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _key,
                child: Column(
                  children: [
                    widget.user?.id!=null?(
                    TextFormField(
                      controller: id,
                      decoration: const InputDecoration(
                          labelText: "id", border: OutlineInputBorder()),
                      
                      onSaved: (value) {
                        print(value);
                      },
                    )):(
                   const SizedBox(
                      height: 8,
                    )),
                     const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: name,
                      decoration: const InputDecoration(
                          labelText: "Name", border: OutlineInputBorder()),
                      validator: (value) => validate.namevalidate(value),
                      onSaved: (value) {
                        print(value);
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: email,
                      decoration: const InputDecoration(
                          labelText: "Email", border: OutlineInputBorder()),
                      validator: (value) => validate.emailvalidate(value),
                      onSaved: (value) {
                        print(value);
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: mobileno,
                      decoration: const InputDecoration(
                          labelText: "Mobile No", border: OutlineInputBorder()),
                      validator: (value) => validate.mobilevalidate(value),
                      onSaved: (value) {
                        print(value);
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    ElevatedButton(onPressed: (){
                      if(_key.currentState!.validate()){
                        _key.currentState!.save();
                        if(widget.user?.id==null){
                        
                        userBloc.add(CreateUserEvent(name:name.text,email:email.text,mobileno:mobileno.text));
                        _key.currentState!.reset();
                          name.text ='';
                          email.text='';
                          mobileno.text='';
                        if(state is UserSavingState){
                           const CircularProgressIndicator();
                        }
                        else if(state is UserSavedState){
                           ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message!)));
                          
                        }
                        else if(state is UserSaveErrorState){
                          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message!)));

                        }
                        else {
                           const SizedBox(height:8);
                        }}
                        else{
                          
                          userBloc.add(UpdateUserEvent(
                            user:User(id: widget.user?.id, name:name.text.toString(),email:email.text.toString(),mobileno:mobileno.text.toString())));
                            _key.currentState!.reset();
                            id.text='';
                          name.text ='';
                          email.text='';
                          mobileno.text='';
                          if(state is UserUpdatingState){
                           const CircularProgressIndicator();
                        }
                        else if(state is UserUpdatedState){
                           ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message!)));
                        }
                        else if(state is UserUpdateErrorState){
                          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message!)));

                        }
                        else {
                         const SizedBox(height:8);
                        };
 
                        };

                      }

                    }, child: widget.user?.id==null? const Text('Submit'):const Text('Update'))
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
