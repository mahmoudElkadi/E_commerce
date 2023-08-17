import 'dart:io';

import 'package:e_commerce_app/commponent/constants/utiles.dart';
import 'package:e_commerce_app/provider/userProvider.dart';
import 'package:e_commerce_app/services/user/userServieses.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import '../../paymentConfiguration.dart';
import 'package:provider/provider.dart';

import '../../commponent/common/reusableWidget.dart';
import '../../commponent/constants/globalVariables.dart';

class AddressScreen extends StatefulWidget {
  final String totalAmount;

  const AddressScreen( {Key? key, required this.totalAmount}) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {

  final UserServices userServices=UserServices();
  final addressKey=GlobalKey<FormState>();
  var houseController=TextEditingController();
  var streetController=TextEditingController();
  var pincodeController=TextEditingController();
  var cityController=TextEditingController();

  List<PaymentItem> paymentItem=[];
  String addressToBeUsed='';
  
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    paymentItem.add(PaymentItem(amount: widget.totalAmount.toString(),label:'Total Amount',status: PaymentItemStatus.final_price  ));
  }

  void onGooglePayResult(res){
    if(Provider.of<UserProvider>(context,listen: false).user.address!.isEmpty){
      userServices.saveUserAddress(context: context, address: addressToBeUsed);
    }
    userServices.placeOrder(context: context, address: addressToBeUsed, totalSum:double.parse(widget.totalAmount.toString()) );
  }
  void onGooglePayResult2(){
    if(Provider.of<UserProvider>(context,listen: false).user.address!.isEmpty){
      userServices.saveUserAddress(context: context, address: addressToBeUsed);
    }
    userServices.placeOrder(context: context, address: addressToBeUsed, totalSum:double.parse(widget.totalAmount.toString()) );
  }

  void payPressed(String addressFromProvider){
    addressToBeUsed='';
    bool isForm=houseController.text.isNotEmpty ||
        streetController.text.isNotEmpty ||
        pincodeController.text.isNotEmpty ||
        cityController.text.isNotEmpty ;

    if (isForm){
      if(addressKey.currentState!.validate()){
        addressToBeUsed='${houseController.text} ,${streetController.text} ,${cityController.text} - ${pincodeController.text} ';
        print(addressToBeUsed);
      }else{
        throw Exception('Please enter all the value');
      }
    }else if(addressFromProvider.isNotEmpty){
      addressToBeUsed= addressFromProvider;
    }else{
      showSnackBar(context, 'Error');
    }
  }





  @override
  Widget build(BuildContext context) {
    var address=context.watch<UserProvider>().user.address;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize:const Size.fromHeight(60),
        child:AppBar(
          flexibleSpace:Container(
            decoration: BoxDecoration(
                gradient: GlobalVariables.appBarGradient
            ),
          ) ,

          ),
        ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              if(address!.isNotEmpty)
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black,width: 0),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text('${address.toString()}',
                style:TextStyle(
                  fontSize: 18
                ) ,
                ),
              ),
              if(address!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text('OR',
                style: TextStyle(
                  fontSize: 22
                ),),
              ),
              Form(
                key: addressKey,
                child: Column(
                  children: [

                    TextFormField2(controller: houseController,
                        type: TextInputType.text,
                        label: "Flat,House no ,Building",
                        kind: 'House'),
                    SizedBox(height: 10,),
                    TextFormField2(controller: streetController,
                      type: TextInputType.text,
                      label: "Area,Street",
                      kind: 'Street',

                    ),
                    SizedBox(height: 10,),
                    TextFormField2(controller: pincodeController,
                      type: TextInputType.text,
                      label: "Pincode",
                      kind: 'Pincode',

                    ),
                    SizedBox(height: 10,),
                    TextFormField2
                      (
                      controller: cityController,
                      type: TextInputType.text,
                      label: "Town/city",
                      kind: 'City',

                    ),
                    SizedBox(height: 10,),

                  ApplePayButton(
                    paymentConfiguration: PaymentConfiguration.fromJsonString(defaultApplePay),
                    paymentItems: const[
                      PaymentItem(
                          amount: '0.01',
                          label: 'Item A',
                          status: PaymentItemStatus.final_price
                      ),
                      PaymentItem(
                          amount: '0.01 ',
                          label: 'Item B',
                          status: PaymentItemStatus.final_price
                      ),
                      PaymentItem(
                          amount: '0.02',
                          label: 'Total',
                          status: PaymentItemStatus.final_price
                      )
                    ],
                    style: ApplePayButtonStyle.black,
                    width: double.infinity,
                    height: 50,
                    type: ApplePayButtonType.buy,
                    onPaymentResult: (result)=>debugPrint('Payment Result $result'),
                    loadingIndicator: Center(child: CircularProgressIndicator(),),
                  ),

                  GooglePayButton(
                    onPressed: ()=>payPressed(address),
                    paymentConfiguration: PaymentConfiguration.fromJsonString(defaultGooglePay),
                    paymentItems: paymentItem,
                    type: GooglePayButtonType.pay,
                    margin: const EdgeInsets.only(top: 15.0),
                    width: double.infinity,
                    height: 50,
                    onPaymentResult:onGooglePayResult,
                    loadingIndicator: Center(child: CircularProgressIndicator(),),
                  ),
                    defaultButton( text: 'text', onpressed: (){
                      String addressToBeUsed1;
                      if(address!.isNotEmpty){
                        userServices.placeOrder(context: context, address: address, totalSum:double.parse(widget.totalAmount.toString()) );

                      }
                      else if(addressKey.currentState!.validate()){
                        addressToBeUsed1='${houseController.text} ,${streetController.text} ,${cityController.text} - ${pincodeController.text} ';
                        print(addressToBeUsed1);
                        if(Provider.of<UserProvider>(context,listen: false).user.address!.isEmpty){
                          userServices.saveUserAddress(context: context, address: addressToBeUsed1);
                        }
                        print(double.parse(widget.totalAmount.toString()));
                        userServices.placeOrder(context: context, address: addressToBeUsed1, totalSum:double.parse(widget.totalAmount.toString()) );

                        print(addressToBeUsed);
                      }
                    })

                  ],
                ),

              ),
            ],
          ),
        ),
      ),
    );
  }
}
