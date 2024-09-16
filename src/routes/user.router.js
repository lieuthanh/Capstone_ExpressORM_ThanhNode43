import { middleWareToken } from "../config/jwt.js";
import { upload } from "../config/upload.js";
import { getImageCreated, getImageSaved, getInfoUser, putUpdateInfoUser, uploadImageUser } from "../controllers/user.controller.js";
import express from "express"

const userRouter = express.Router();

//API GET thông tin user
userRouter.get("/get-info-user",middleWareToken,getInfoUser)

//API GET danh sách ảnh đã lưu theo userId
userRouter.get("/image-saved-userid",middleWareToken,getImageSaved)

//API GET danh sách ảnh đã tạo theo userId
userRouter.get("/image-created-userid",middleWareToken,getImageCreated)

//API POST thêm một ảnh của user
userRouter.post("/upload-image",middleWareToken,upload.single("hinhAnh"),uploadImageUser)

//API PUT thông tin cá nhân của user
userRouter.put("/update-info-user",middleWareToken,putUpdateInfoUser)

export default userRouter



