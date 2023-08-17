import 'dart:convert';

class UserModel{
  String? id;
  String? userName;
  String? email;
  String? password;
  String? address;
  String? type;
  String? token;
  final List<dynamic>? cart;

  UserModel({
    this.id,
    this.userName,
    this.email,
    this.password,
    this.address,
    this.type,
    this.token,
    this.cart
});
  factory UserModel.fromMap(Map<String,dynamic> json){
    return UserModel(
        id:json['_id'],
    userName:json['userName'],
    email:json['email'],
    password:json['password'],
    address:json['address'],
    type:json['type'],
    token:json['token'],
      cart:List<Map<String,dynamic>>.from(
          json['cart']?.map(
                  (x) => Map<String,dynamic>.from(x)
          ),
      ),);

  }

  Map<String,dynamic> toMap(){
  return{
    'id':id,
    'userName':userName,
    'email':email,
    'password':password,
    'address':address,
    'type':type,
    'token':token,
    'cart':cart,
  };
  }

  String toJson()=>json.encode(toMap());
   factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

   UserModel copyWith({
     String? id,
     String? userName,
     String? email,
     String? password,
     String? address,
     String? type,
     String? token,
     List<dynamic>? cart ,
}){
     return UserModel(
       id: id??this.id,
       userName: userName??this.userName,
       email: email??this.email,
       password: password??this.password,
       address: address??this.address,
       type: type??this.type,
       token: token??this.token,
       cart: cart??this.cart,
     );
   }

}