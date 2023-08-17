const userRouter=require('express').Router()
const {userSignUp,userSignIn,postToken,getUserData}=require("./controller/user.controller")
const auth=require("../../middleware/auth")

userRouter.post("/signUp",userSignUp)
userRouter.post("/signIn",userSignIn)
userRouter.post("/token",postToken)
userRouter.get("/user",auth,getUserData)

module.exports=userRouter