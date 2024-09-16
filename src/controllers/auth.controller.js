import initModels from "../models/init-models.js";
import sequelize from "../models/connect.js";
import { responseData } from "../config/response.js";
import bcrypt from "bcrypt";
import { createToken, createTokenRef, decodeToken, verifyToken, verifyTokenRef } from "../config/jwt.js";

const model = initModels(sequelize);

const signUp = async(req,res)=>{
    let {email, mat_khau, ho_ten,tuoi} = req.body;

    let checkEmail = await model.nguoi_dung.findOne({
        where:{
            email,
        },
    });

    if(checkEmail){
        responseData("","Email already exists!",409,res);
        return;
    }
        let newData={
            email,
            mat_khau: bcrypt.hashSync(mat_khau,10),
            ho_ten,
            tuoi,
            anh_dai_dien:"",
            refresh_token:""
        };
        let data = await model.nguoi_dung.create(newData);
        responseData(data,"Sign Up Successfully!",201,res);
    }

const login= async(req,res)=>{
    let {email, mat_khau} = req.body;
    let checkEmail = await model.nguoi_dung.findOne({
        where:{
            email
        },
    });
    if(checkEmail){
        if(bcrypt.compareSync(mat_khau, checkEmail.mat_khau)){
            let key = new Date().getTime()

            let token = createToken({userId: checkEmail.dataValues.nguoi_dung_id, key});

            //create refresh token
            let refreshToken = createTokenRef({userId: checkEmail.dataValues.nguoi_dung_id, key})
            checkEmail.refresh_token = refreshToken

            await model.nguoi_dung.update(checkEmail.dataValues,{
                where:{
                    nguoi_dung_id: checkEmail.dataValues.nguoi_dung_id
                }
            })
            responseData(token,"Login Successfully!",200,res);
        }else{
            responseData("","Password is not correct!",403,res);
        }
    }else{
        responseData("","Email is not correct!",403,res);
    }
}

const resetToken = async (req,res)=>{
    //verify token
    let {token} = req.headers;
    let checkToken = verifyToken(token)
    if(checkToken != null && checkToken.name != "TokenExpiredError"){ //loại trừ lỗi expired
        res.status(401).send("Unauthorized token")
        return;
    }
    //verify refresh token
    let tokenDecode = decodeToken(token)

    //lấy user trong database để get refresh token kiểm tra
    let getUser = await model.nguoi_dung.findByPk(tokenDecode.data.userId);
    let checkTokenRef = verifyTokenRef(getUser.refresh_token)
    if(checkTokenRef != null){
        res.status(401).send("Unauthorized refresh token")
        return;
    }
    let tokenRefDecode = decodeToken(getUser.refresh_token)
    //check key
    if(tokenDecode.data.key != tokenRefDecode.data.key){
        res.status(401).send("Unauthorized refresh token")
        return
    }
    //create access token
    let newToken = createToken({userId: tokenDecode.data.userId, key: tokenRefDecode.data.key})
    responseData(newToken, "Login Successful!", 200, res);

}

export {
    signUp,
    login,
    resetToken
}