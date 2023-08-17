const productsRoutes=require('express').Router()
const auth = require('../../middleware/auth')
const {dealOfTheDay,orderProduct,saveAddress,removeFromCart,addToCart,ratingProduct,searchProduct,getcategoryProduct,}=require('./controller/userProductController')



productsRoutes.get('/product/category',auth,getcategoryProduct)
productsRoutes.get('/product/search/:product',auth,searchProduct)
productsRoutes.post('/product/rating',auth,ratingProduct)
productsRoutes.get('/product/deal-of-day',auth,dealOfTheDay)
productsRoutes.post('/product/add-to-cart',auth,addToCart)
productsRoutes.delete('/product/remove-from-cart/:id',auth,removeFromCart)
productsRoutes.post('/product/save-user-address',auth,saveAddress)
productsRoutes.post('/product/save-user-order',auth,orderProduct)


module.exports=productsRoutes