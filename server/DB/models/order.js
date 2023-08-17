const mongoose=require('mongoose');
const { productSchema } = require('./productModel');

const orderSchema = mongoose.Schema({
    products:[
      {
          product:productSchema,
          quantity:{
            type:Number,
            required:true,
        }
      }
    ],
    totalPrice:
     {
        required:true,
        type:Number
     },
     address :{
        type:String,
        required:true,
     },

     userId:{
        type:String,
        required:true,
     },
     orderAt:{
        type:Number,
        required:true,
     },
     status:{
        type:Number,
        default:0,
     },
})

const orderModel=mongoose.model('order',orderSchema);

module.exports = orderModel;