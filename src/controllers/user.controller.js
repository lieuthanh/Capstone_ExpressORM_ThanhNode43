import initModels from "../models/init-models.js"
import sequelize from "../models/connect.js"
import { responseData } from "../config/response.js";
import { decodeToken } from "../config/jwt.js";

const model = initModels(sequelize)

const getInfoUser = async(req, res)=>{
    let {token} = req.headers;
    let {data} = decodeToken(token);
    try{
        let user = await model.nguoi_dung.findByPk(data.userId);
     if(user){
        responseData(user,"Thành công",200,res);
     }else{
        responseData("","User not found",404,res)
     }
    }catch(error){
        responseData(res, null, error.message, 500)
    }
}

const getImageSaved = async(req,res)=>{
    let {token} = req.headers;
    let {data} = decodeToken(token);
    
    try {
        let imageSave = await model.luu_anh.findAll({
            where:{
                nguoi_dung_id: data.userId,
            },
            include:["hinh","nguoi_dung"]
        })
        responseData(imageSave,"Get images saved successful!",200,res)
    } catch (error) {
        responseData(error.message,null,500,res)
    }
}

const getImageCreated = async(req,res)=>{
    let {token} = req.headers;
    let {data} = decodeToken(token);
    
    try {
        let userImage = await model.hinh_anh.findAll({
            where:{
                nguoi_dung_id: data.userId
            },
            include:["nguoi_dung"]
        })
        responseData(userImage,"User Image created successful!",200,res)
    } catch (error) {
        responseData(error.message,null,500,res)
    }
}

const uploadImageUser = async(req,res)=>{
    try {
        const file = req.file
        //res.send(file)
        //kiểm tra file đã upload chưa
        if(!file){
            return responseData(null,"No file uploaded",400,res)
        }
        let {token} = req.headers;
        let {data} = decodeToken(token);
        let description = "Mô tả hình "+ file.filename;
        //tạo dữ liệu trong table hinh_anh
        const newImage = await model.hinh_anh.create({
            ten_hinh: file.filename,
            duong_dan:file.path,
            mo_ta:  description,
            nguoi_dung_id:data.userId,
            ngay_tao:new Date(),
        });
        responseData(newImage,"Image upload successful!",201,res)

    } catch (error) {
        responseData(error.message,null,500,res)
    }
}

const putUpdateInfoUser = async(req,res)=>{
    try {
        let {token} = req.headers;
        let {data} = decodeToken(token);
        let {fullName, age} = req.body;
        let user = await model.nguoi_dung.findByPk(data.userId);
        //kiểm tra user có tồn tại ko
        if(!user){
            return responseData(null,"User not found",404,res);
        }

        user.ho_ten = fullName;
        user.tuoi = age;
        await user.save();

        responseData(user,"User Edit Successful!",200,res);
    } catch (error) {
        responseData(error.message,null,500,res)
    }
}

export {
    getInfoUser,
    getImageSaved,
    getImageCreated,
    uploadImageUser,
    putUpdateInfoUser
}