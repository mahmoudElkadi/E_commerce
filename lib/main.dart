import 'package:e_commerce_app/Network/local/sharedPrefernce.dart';
import 'package:e_commerce_app/commponent/constants/globalVariables.dart';
import 'package:e_commerce_app/modules/admin/adminScreen.dart';
import 'package:e_commerce_app/modules/auth/authScreen.dart';
import 'package:e_commerce_app/modules/home/homeScreen.dart';
import 'package:e_commerce_app/provider/userProvider.dart';
import 'package:e_commerce_app/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'layout/ecommerceLayout.dart';

void main(context)async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init();
  var token=await CacheHelper.getData(key: 'token');
  var type=await CacheHelper.getData(key: 'type');

  print(token);
  print(type);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create:(context)=>UserProvider())
      ],
        child:const MyApp())
  );
}
//eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY0OTBkOTQ1Nzc2NzFmYjVlYjIyOWQzZSIsImlhdCI6MTY4NzIzODA1NH0.DFqLj0QGnZV07X3qprN12_JuonUMV8PgrPQKyfFG4PI

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthServices authServices=AuthServices();

  @override
  void initState() {
    super.initState();
    authServices.getUserData(context: context);
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme: ColorScheme.light(
         // primary: GlobalVariables.secondaryColor,
        ),
        appBarTheme: AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black)
        )
      ),

      home:token == null?
          AuthScreen(): Provider.of<UserProvider>(context).user.type=='user'?
      BottomBar():Provider.of<UserProvider>(context).user.type=='admin'?
      AdminScreen():BottomBar()
    );
  }
}
