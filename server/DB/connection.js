const mongoose=require('mongoose');

const initConnection=async ()=>{
  try {
        await mongoose
            .connect(process.env.MONGODB_URL);
        return console.log('Database is connect');
    } catch (error) {
        return console.log(`Error ${error}`);
    }
}

module.exports=initConnection5