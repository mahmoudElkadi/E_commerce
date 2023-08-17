const jwt=require('jsonwebtoken')

const auth=async(req,res,next)=>{
    try {
        const token=req.header('token')
        if(!token)
        res.status(401).json({msg:"no auth token"})

        const user=jwt.verify(token,process.env.KEY_TOKEN)
        if(!user)
        return res.status(401).json({msg:"token verification failed"})
        req.user=user.id
        req.token=token
        next()
    } catch (error) {
        res.status(500).json({msg:error.toString()})
    }
}

module.exports=auth