
  class User {
	final String? id;
	final String name;
	final String email;
	final String mobileno;

	User({
		this.id,
		required this.name,
		required this.email,
		required this.mobileno,
	});

	factory User.fromJson(Map<String, dynamic> json){
    return User(id:json['id'],name:json['name'], email:json['email'], mobileno:json['mobileno']);
  } 
		
	Map<String, dynamic> toJson(){
   return{
    'id':id,
    'name':name,
    'email':email,
    'mobileno':mobileno
   };
   
  } 
}
	