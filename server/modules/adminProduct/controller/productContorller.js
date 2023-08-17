const {productModel} = require("../../../DB/models/productModel")

const createProduct=async(req,res)=>{
    try {
    
        const{productName,description,price,quantity,catagory,images}=req.body
        const product=new productModel({productName,description,price,quantity,catagory,images})
        const addProduct=await product.save();
        res.status(200).json({msg:'Add Product',addProduct})
    } catch (error) {
        res.status(500).json({Error:error.message})
    }
}

const getYourProduct=async(req,res)=>{
    try {
        const products=await productModel.find();
        res.status(200).json({products})
    } catch (error) {
        res.status(500).json({Error:error.message})

    }
}

const deleteYourProduct=async(req,res)=>{
    try {
        const {id}=req.body
        await productModel.findByIdAndDelete(id);
        res.status(200).json({msg:"Product is deleted"})
    } catch (error) {
        res.status(500).json({Error:error.message})

    }
}







module.exports={createProduct,getYourProduct,deleteYourProduct};