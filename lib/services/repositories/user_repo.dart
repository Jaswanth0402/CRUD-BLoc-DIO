
import 'dart:math';

import 'package:state_manage/services/modals/response.dart';
import 'package:dio/dio.dart';
import 'package:state_manage/services/modals/user.dart';
final dio =Dio();
class UserMethods{


static Future<Result> adduser ({
    required String name,
    required String email,
    required String mobileno

  })async{
    Result result =Result();

     Map<String,dynamic> data =<String,dynamic>{
      "name" :name,
      "mobileno":mobileno,
      'email':email
     };
    try {
      // ignore: unused_local_variable
      final response =await dio.post('https://6451f642a2860c9ed4fe7357.mockapi.io/user/user',data:data );
      result.code =200;
      result.message='User Created Successfully';
    } catch (e) {
       result.code =500;
      result.message =e.toString();
    }
    return result;
  }

static Future<List<User>>getuser()async{
    Response response;
    List<User> users = [];
    try {
      response = await dio.get('https://6451f642a2860c9ed4fe7357.mockapi.io/user/user');
     List userdata = response.data;

     for (int i = 0; i < userdata.length; i++) {
        User user =
            User.fromJson(userdata[i] as Map<String, dynamic>);
        users.add(user);
      }
              
    } catch (e) {
      log( e.toString() as num);
      return [];
    }
    return users;
  }

  static Future<Result>deleteuser({required String id})async{
          Result result =Result(); 
          
          try {
           final response = await dio.delete('https://6451f642a2860c9ed4fe7357.mockapi.io/user/user/$id',);
            result.code=200;
            result.message  ="User Deleted Successfully";
             print("data deleted");
          } catch (e) {
            result.code=500;
            result.message=e.toString();  
          }
          return result;
    }

  static Future<Result> edituser ({
    required User user,
    

  })async{
    Result result =Result();

    
    try {
      // ignore: unused_local_variable
      print(user.id);
      final response =await dio.put('https://6451f642a2860c9ed4fe7357.mockapi.io/user/user/${user.id}',data:user.toJson() );
      result.code =200;
      result.message='User updated Successfully';
    } catch (e) {
       result.code =500;
      result.message =e.toString();
    }
    return result;
  } 

}