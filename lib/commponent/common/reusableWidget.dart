
import 'package:e_commerce_app/commponent/constants/globalVariables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
//import 'package:fluttertoast/fluttertoast.dart';

Widget TextFormField2({
  required TextEditingController controller,
  required TextInputType type,
  IconData ?suffixIcon,
  bool isPass=false,
  Function()? showPass,
  Function()? onTab,

  String? label,
  String? hintText,
  required String kind,
  Function(String value)? onChange,
  int maxLines=1,

  context,
  Function(String  value)? onSubmit

}) {
  return TextFormField(
    maxLines: maxLines,
    controller: controller,
    onTap: onTab,
    onFieldSubmitted: onSubmit,
    keyboardType: type,
    obscureText: isPass,

    onChanged: onChange,
    validator: (String? value) {
      if (value!.isEmpty) {
        return '$kind must not be Empty';
      }
      return null;
    },
    textAlign: TextAlign.start,
    cursorColor: Colors.black,

    decoration: InputDecoration(
      contentPadding: EdgeInsets.only(left: 10,bottom: 10,right: 10,top: 10),
      focusColor: Colors.black,
      filled: true,
      fillColor: Colors.white,
      iconColor: Colors.black,

      focusedBorder:OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          borderSide: BorderSide(color: Colors.grey,width: 1)) ,
      border:OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          borderSide: BorderSide(color: Colors.grey,width: 1)
      ),
      enabledBorder:OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          borderSide: BorderSide(color: Colors.grey,width: 1)
      ),
      hintText: hintText,
      labelText: label,
      prefixIconColor: Colors.black,
      labelStyle: TextStyle(
          color: Colors.grey
      ),
      prefixStyle: TextStyle(
          backgroundColor: Colors.white
      ),



    ),
  );
}

Widget defaultTextFormField({
  required TextEditingController controller,
  required TextInputType type,
  IconData ?suffixIcon,
  bool isPass=false,
  Function()? showPass,
  Function()? onTab,

   String? label,
   String? hintText,
   IconData? prefixIcon,
  required String kind,
  Function(String value)? onChange,
  int maxLines=1,

  context,
  Function(String  value)? onSubmit

}) {
  return TextFormField(
    maxLines: maxLines,
    controller: controller,
    onTap: onTab,
    onFieldSubmitted: onSubmit,
    keyboardType: type,
    obscureText: isPass,

    onChanged: onChange,
    validator: (String? value) {
      if (value!.isEmpty) {
        return '$kind must not be Empty';
      }
      return null;
    },
  textAlign: TextAlign.start,
  cursorColor: Colors.black,

    decoration: InputDecoration(
      contentPadding: EdgeInsets.only(bottom: 10,right: 10,top: 10),
      focusColor: Colors.black,
      filled: true,
      fillColor: Colors.white,
      iconColor: Colors.black,

      focusedBorder:OutlineInputBorder(
         borderRadius: BorderRadius.all(Radius.circular(7)),
         borderSide: BorderSide(color: Colors.white,width: 1)) ,
      border:OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(7)),
          borderSide: BorderSide(color: Colors.white,width: 1)
      ),
      enabledBorder:OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(7)),
          borderSide: BorderSide(color: Colors.white,width: 1)
      ),
      hintText: hintText,
      labelText: label,
      prefixIconColor: Colors.black,
      prefixIcon: Icon(prefixIcon),
      suffixIcon: IconButton(onPressed: showPass, icon: Icon(suffixIcon),),
      labelStyle: TextStyle(
          color: Colors.grey
      ),
      prefixStyle: TextStyle(
          backgroundColor: Colors.white
      ),



    ),
  );
}


Widget defaultButton({
  @required double width =double.infinity,
  @required Color background=GlobalVariables.secondaryColor,
  @required double height=40,
  @required Color color=Colors.white,
  // required  Function() function,
  required String text,
  required Null Function() onpressed,
}) {
  return Container(
    width: width,
    height: height,
    color: background,
    child: MaterialButton(

      onPressed: onpressed,
      child: Text('${text.toUpperCase()}',
        style: TextStyle(
            fontSize: 16,
            color: color
        ),
      ),
    ),

  );
}


Widget defaultTextButton({
  required Function() function,
  required String text
}){
  return TextButton(onPressed: function, child:Text(
      '${text}'
  ),
  );
}

Widget MyDivider(){
  return Container(
    width: double.infinity,
    height: 1,
    color: Colors.grey[300],
  );
}

// void showToast({
//   required String msg,
//   required ToastStatus state
// }){
//   Fluttertoast.showToast(
//       msg: msg,
//       toastLength: Toast.LENGTH_LONG,
//       gravity: ToastGravity.BOTTOM,
//       timeInSecForIosWeb: 5,
//       backgroundColor: chooseToastColor(state),
//       textColor: Colors.white,
//       fontSize: 16.0
//   );
// }

enum ToastStatus{SUCCESS, ERROR, WARNING}

Color? chooseToastColor(ToastStatus state){
  Color color;
  switch(state)
  {
    case ToastStatus.SUCCESS:
      color= Colors.green;
      break;
    case ToastStatus.WARNING:
      color= Colors.amber;
      break;
    case ToastStatus.ERROR:
      color= Colors.red;
      break;
  }
  return color;
}


void navigateTo(context,widget){
  Navigator.push(context, MaterialPageRoute(builder: (context)=>widget));
}

void navigateAndFinish(context,widget)=>Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context)=>widget),
        (route) => false
);


Widget defaultAppBar({
  required BuildContext context,
  String? text,
  List<Widget>? actions,
}){
  return AppBar(
    leading:IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: (){
        Navigator.pop(context);
      },
    ) ,
    title: Text(
        '${text}'
    ),
    titleSpacing: 3,
    actions: actions,
  );
}

Widget defaultOutLineButton({
  required String text,
  required Null Function() onpressed,

}){
  return Expanded(
    child: Container(
        margin: EdgeInsets.symmetric(horizontal:10 ),
        height: 40,
        decoration:BoxDecoration (
            border: Border.all(color: Colors.white,width: 0),
            borderRadius: BorderRadius.circular(50),
            color: Colors.white
        ),
        child: OutlinedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black12.withOpacity(0.03),
            shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(50)) ,

          ),
          onPressed: onpressed,
          child: Text('$text',style:TextStyle(
            color: Colors.black,

          ) ,
          ),
        )
    ),
  );
}


Widget rateingProduct({
  required double rating
}){
  return RatingBarIndicator(
    direction: Axis.horizontal,
      itemCount: 5,
      rating: rating,
      itemSize: 15,
      itemBuilder: (context,_)=>Icon(Icons.star,color: GlobalVariables.secondaryColor,)
  );
}