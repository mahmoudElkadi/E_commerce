const mongoose=require('mongoose')
const { productSchema } = require('./productModel')

const userSchema=mongoose.Schema({
    userName:{
        type:String,
        required:true,
        trim:true,
    },
    email:{
        required:true,
        type:String,
        trim:true,
    },
    password:{
        required:true,
        type:String,
    },
    address:{
        type:String,
        default:'',
    },
    type:{
        type:String,
        default:'user'
    },
    cart:[
        {
            product:productSchema,
            quantity:{
                type:Number,
                required:true,
            },
              
        }
    ]
})

const userModel=mongoose.model("user",userSchema)

module.exports=userModel