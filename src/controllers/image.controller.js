import initModels from "../models/init-models.js";
import sequelize from "../models/connect.js";
import { responseData } from "../config/response.js";
import { Op } from "sequelize";
import { decodeToken } from "../config/jwt.js";

const model = initModels(sequelize);

const getImage = async(req,res)=>{
    let data = await model.hinh_anh.findAll();
    
    responseData(data,"Successful!",200,res);
}
const getImagePage = async(req,res)=>{
    let {page} = req.params

    let pageSize = 3;
    let index = (page-1)*pageSize;

    let data = await model.hinh_anh.findAll({
        offset: index,
        limit:pageSize
    });
    responseData(data,"Successful!",200,res);
}

const getImageSearch = async(req,res)=>{
    let {searchName} = req.query;
    let data = await model.hinh_anh.findAll({
        where:{
            ten_hinh:{
            [Op.like]: `%${searchName}%`,
        },
        },
        include:["nguoi_dung"],
    })
    responseData(data,"Successful!",200,res);
}

const getImageDetail = async (req,res)=>{
    let {imageId} = req.params;
    let data = await model.hinh_anh.findOne({   
        where: {
        hinh_id:imageId,
    },
    include:["nguoi_dung"],
})
    responseData(data,"Successful!",200,res);
}

const getComment = async(req,res)=>{
    let {imageId} = req.params;
    let data = await model.binh_luan.findAll({   
        where: {
        hinh_id:imageId,
    },
    include:["nguoi_dung","hinh"],
})
    responseData(data,"Successful!",200,res);
}

const getCheckImageSave = async(req,res)=>{
    let {imageId,userId} = req.params;
    try{
        let data = await model.luu_anh.findOne({
            where:{
                hinh_id: imageId,
                nguoi_dung_id: userId
            },
        });
    if(data){
        responseData(true,"Image is saved",200,res);
    }else{
        responseData(false,"Image is not saved",200, res);
    }
    }catch(error){
        responseData(error.message,null,500,res)
    }
}

const createComment = async(req,res)=>{
    let {imageId,content,userId} = req.body;

    let {token} = req.headers;
    let {data} = decodeToken(token);
    let dateComment = new Date();

    let newData = {
        nguoi_dung_id: data.userId,
        hinh_id: imageId,
        noi_dung:content,
        ngay_binh_luan: dateComment,
    };
    await model.binh_luan.create(newData);
    responseData(newData,"Comment is created!",200,res)
}

const deleteImage = async(req,res)=>{
    let {imageId}= req.params;
    try{
        let image = await model.hinh_anh.findByPk(imageId);
        if(!image){
            return responseData(null,"Image not found",404,res)
        }
        //check user có quyền xóa hình ko
        let {token} = req.headers;
        let {data} = decodeToken(token);
        if(image.nguoi_dung_id != data.userId){
            return responseData(null,"Unauthorized delete image",403,res);
        }

        await model.hinh_anh.destroy({
            where:{
                hinh_id:imageId,
            }
        })
        responseData(data,"Image deleted",200,res);

    }catch(error){
        responseData(error.message,null,500,res)
    }
}


export {
    getImage,
    getImagePage,
    getImageDetail,
    getImageSearch,
    getComment,
    getCheckImageSave,
    createComment,
    deleteImage
}
