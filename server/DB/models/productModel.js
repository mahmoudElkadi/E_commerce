const mongoose=require('mongoose');
const ratingSchema = require('./rating');

const productSchema=mongoose.Schema({
    productName:{
        type:String,
        required:true,
        trim:true,
    },
    description:{
        required:true,
        type:String,
        trim:true,
    },
    price:{
        required:true,
        type:Number,
    },
    quantity:{
        required:true,
        type:Number,
    },
    catagory:{
        type:String,
        default:'user'
    },
    images:[{
        type:String,
        default:'user'
    }],
    ratings:[ratingSchema]
})

const productModel=mongoose.model('product', productSchema)

module.exports={productModel,productSchema}