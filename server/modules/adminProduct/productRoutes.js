const productRoutes=require('express').Router()
const admin = require('../../middleware/admin')
const {createProduct,getYourProduct,deleteYourProduct}=require('./controller/productContorller')


productRoutes.post('/product',admin,createProduct)
productRoutes.get('/product',admin,getYourProduct)
productRoutes.delete('/product',admin,deleteYourProduct)


module.exports=productRoutes