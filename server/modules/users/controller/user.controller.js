const userModel=require("../../../DB/models/user")
const bcrypt=require('bcrypt')
const jwt=require("jsonwebtoken")


const userSignUp=async(req,res)=>{
try {
  const {userName,email,password}=req.body;

  const findUser =await userModel.findOne({email:email})
  if(findUser){
    res.status(400).json({msg:"email is already register"})
  }else{

   const hashPassword= bcrypt.hashSync(password,parseInt(process.env.SALT_ROUND))
    const newUser=new userModel({userName:userName,email:email,password:hashPassword})
    const addUser=await newUser.save()
    res.status(200).json({msg:"user register is done",addUser})
  }
} catch (error) {
  res.status(500).json({Error:`Error ${error}`})
}
}

const userSignIn=async(req,res)=>{
  try {
    const {email,password}=req.body
    const findUser=await userModel.findOne({email})
    if (findUser) {
      const user=bcrypt.compare(password,findUser.password,(err,result)=>{
        if (result) {
          const token=jwt.sign({id:findUser._id},process.env.KEY_TOKEN)
          res.status(200).json({msg:"welcome",token,...findUser._doc})
        } else {
          res.status(400).json({msg:"password isn't correct"})

        }
      })
      
    } else {
      res.status(400).json({msg:"email is not register"})
    }

  } catch (error) {
    res.status(500).json({msg:error.toString()})
  }
}

const postToken=async(req,res)=>{
  try {
    const token =req.header('token');
    if(!token)return res.json(false);
    else{
     const verifed= jwt.verify(token,process.env.KEY_TOKEN)
      if(!verifed)return res.json(false)
      else{
        const user=await userModel.findOne({id:verifed._id})
        if(!user)return res.json(false)
        res.json(true)
      }
    }
  } catch (error) {
    res.status(500).json({msg:error.toString()})
  }
}

const getUserData=async(req,res)=>{
  const user=await userModel.findById(req.user);
  if (!user) {
    res.status(400).json('token verified is failed')
  } else {
    res.status(200).json({msg:"user data",...user._doc,token:req.token})
    
  }
}


module.exports={userSignUp,userSignIn,postToken,getUserData}