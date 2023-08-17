const jwt=require('jsonwebtoken')
const userModel = require('../DB/models/user')


const admin=async(req,res,next)=>{
    try {
        const token=req.header('token')
        if(!token)
        res.status(401).json({msg:"no auth token"})

        const user=jwt.verify(token,process.env.KEY_TOKEN)
        if(!user)
        return res.status(401).json({msg:"token verification failed"})
        const findUser=await userModel.findById(user.id);
        if(findUser.type=="user" || user.type=='seller'){
            res.status(401).json({msg:"user not auth"})
        }
        req.user=user.id
        req.token=token
        next()
    } catch (error) {
        res.status(500).json({msg:error.toString()})
    }
}

module.exports=admin