import 'dart:convert';
import 'package:e_commerce_app/Network/local/sharedPrefernce.dart';
import 'package:e_commerce_app/commponent/common/reusableWidget.dart';
import 'package:e_commerce_app/commponent/constants/errorHandling.dart';
import 'package:e_commerce_app/commponent/constants/globalVariables.dart';
import 'package:e_commerce_app/layout/ecommerceLayout.dart';
import 'package:e_commerce_app/model/userModel.dart';
import 'package:e_commerce_app/modules/admin/adminScreen.dart';
import 'package:e_commerce_app/modules/home/homeScreen.dart';
import 'package:e_commerce_app/provider/userProvider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../commponent/constants/utiles.dart';


class AuthServices{

  void signUpUser({
    required context,
    required String userName,
    required String email,
    required String password,
})async{
try{
  UserModel userModel=UserModel(
      userName: userName,
      email: email,
      password:password,
      type: '',
      address: '',
      token: '',
    cart: []
  );

  http.Response res= await http.post(Uri.parse('$uri/signUp'),
      body:userModel.toJson(),
      headers: <String,String>{
        'Content-Type': 'application/json; charset=UTF-8',
      }
  );
  print(res.statusCode);
  httpErrorHandle(response: res,
      context: context,
      onSuccess: (){
    showSnackBar(context,'Account Created');
      });
}
catch (e){
  print(e.toString());
}
}


  void signInUser({
    required context,
    required String email,
    required String password,
  })async{
    try{
      UserModel userModel=UserModel(
          email: email,
          password:password,

      );

      http.Response res= await http.post(Uri.parse('$uri/signIn'),
          body:userModel.toJson(),
          headers: <String,String>{
            'Content-Type': 'application/json; charset=UTF-8'
          }
      );
      print(res.body);
      httpErrorHandle(response: res,
          context: context,
          onSuccess: (){
        Provider.of<UserProvider>(context ,listen: false).setUser(res.body);
           CacheHelper.saveData(key: 'token', value: jsonDecode(res.body)['token']);
           CacheHelper.saveData(key: 'type', value: jsonDecode(res.body)['type']);
           navigateTo(context,jsonDecode(res.body)['type']=='user'? BottomBar():AdminScreen());
          });
    }
    catch (e){
      showSnackBar(context, e.toString());
    }
  }


  void getUserData({
    required context,
  })async{
    try{
     String token= CacheHelper.getData(key: 'token');
     if(token == null){
       CacheHelper.saveData(key: 'token', value: '');
     }
     else{
      var resToken=await http.post(Uri.parse('$uri/token'),
       headers:<String,String>{
         'token':token,
         'Content-Type': 'application/json; charset=UTF-8'
       }
       );
       var response=jsonDecode(resToken.body);
       if(response ==true){
       http.Response userRes=await  http.get(Uri.parse('$uri/user'),
         headers: <String,String>{
           'token':token,
           'Content-Type': 'application/json; charset=UTF-8'
         }
         );

       var userProvider=Provider.of<UserProvider>(context,listen: false);
       userProvider.setUser(userRes.body);
       }
     }

    }
    catch (e){
      showSnackBar(context, e.toString());
    }
  }
}


