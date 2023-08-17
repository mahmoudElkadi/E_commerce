const express = require('express')
const app = express()
require("dotenv").config();
const userRouter=require("./modules/users/user.routes")
const productRouter=require("./modules/adminProduct/productRoutes")
const productsRoutes=require("./modules/userProduct/userProductRoutes")
const initConnection=require('./DB/connection')
const port = process.env.PORT

initConnection();
app.use(express.json())

app.use(userRouter)
app.use(productRouter)
app.use(productsRoutes)
app.get('/', (req, res) => res.send('Hello World!'))
app.listen(port, () => console.log(`Example app listen on port ${port}!`))