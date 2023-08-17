const orderModel = require("../../../DB/models/order");
const {productModel} = require("../../../DB/models/productModel")
const userModel=require("../../../DB/models/user")


const getcategoryProduct=async(req,res)=>{
    try {
        const {catagory}=req.query
        const products=await productModel.find({catagory});
        res.status(200).json({products})
    } catch (error) {
        res.status(500).json({Error:error.message})

    }
}

const searchProduct=async(req,res)=>{
    try {
        const {product}=req.params
        const products=await productModel.find({productName:{$regex:product,$options:'i'}});
        res.status(200).json({products})
    } catch (error) {
        res.status(500).json({Error:error.message})

    }
}

const ratingProduct=async(req,res)=>{
    try {
        const{id,rating}=req.body;
        let product=await productModel.findById(id);
        for (let i = 0; i< product.ratings?.length; i++) {
          if (product.ratings[i].userId == req.user) {
            product.ratings.splice(i, 1);
           break;
        }
    } 
    const ratingSchema={
        'userId': req.user,
        rating,
    }

    product.ratings?.push(ratingSchema)
    product=await product.save()
    res.json({message:product})

    } catch (error) {
        res.status(500).json({Error:error.message})

    }
}

const dealOfTheDay = async(req, res )=>{ 
    try {
        let products = await productModel.find({});

        products = products.sort((a, b) => {
          let aSum = 0;
          let bSum = 0;
    
          for (let i = 0; i < a.ratings.length; i++) {
            aSum += a.ratings[i].rating;
          }
    
          for (let i = 0; i < b.ratings.length; i++) {
            bSum += b.ratings[i].rating;
          }
          return aSum < bSum ? 1 : -1;
        });
    
        res.json(products[0]);
        
    } catch (error) {
        res.status(500).json({Error:error.message})

    }
}

const addToCart = async(req, res)=>{
    try {
        const{id}=req.body;
        const products = await productModel.findById(id); 
        let user= await userModel.findById(req.user);
    
        if (user.cart.length==0){
            user.cart.push({product:products,quantity:1});
        }else{
            let isProductFound = false; 
            for (let i = 0; i < user.cart.length; i++){
                if (user.cart[i].product._id.equals(products._id)) {
                    isProductFound=true;
                }
            }
            if(isProductFound){
                let productt=user.cart.find((producttt)=>producttt.product._id.equals(products._id) )
                productt.quantity+=1;
            }else{
                user.cart.push({product:products,quantity:1});
            }
        }

        user=await user.save();
        res.json({message:"add to cart",user})
        
    } catch (error) {
        res.status(500).json({Error:error.message})

    }
}


const removeFromCart = async(req, res)=>{
    try {
        const{id}=req.params;
        const products = await productModel.findById(id); 
        let user= await userModel.findById(req.user);
    
            let isProductFound = false; 
            for (let i = 0; i < user.cart.length; i++){
                if (user.cart[i].product._id.equals(products._id)) {
                    if(user.cart[i].quantity==1){
                        user.cart.splice(i, 1);
                    }else{
                        user.cart[i].quantity-=1;
                    }
                }
            }
            
        

        user=await user.save();
        res.json({message:"add to cart",user})
        
    } catch (error) {
        res.status(500).json({Error:error.message})

    }
}


const saveAddress=async(req,res)=>{
    try {
        const {address}=req.body;
        let user=await userModel.findById(req.user)
        user.address=address
        user=user.save();
        res.json({message:"saved address",user})

    } catch (error) {

    }
    
}

const orderProduct = async (req, res) => {
    try {
        const {cart,totalPrice,address}=req.body
        let products=[];
    
        for (let i=0; i<cart.length;i++) {
            let product = await productModel.findById(cart[i].product._id);
            if(product.quantity>=cart[i].quantity){
                product.quantity -= cart[1].quantity
                products.push({product:product,quantity:cart[i].quantity});
                await product.save();
            }else{
                return res.status(200).json({message:`${product.productName} is out of Stock`});
            }
        
        }
        let user=await userModel.findById(req.user);
        user.cart = []
        user=await user.save();

        let order = new orderModel({
            products:products,
            totalPrice,
            address,
            userId:req.user,
            orderAt:new Date().getTime(),
        })
        order=await order.save();
        res.status(200).json(order);

    } catch (error) {
        res.status(500).json({Error:error.message})

    }

}







module.exports={dealOfTheDay,orderProduct,saveAddress,removeFromCart,addToCart,ratingProduct,searchProduct,getcategoryProduct};