import express from "express"
import { createComment, deleteImage, getCheckImageSave, getComment, getImage, getImageDetail, getImagePage, getImageSearch} from "../controllers/image.controller.js";
import { upload } from "../config/upload.js";
import { middleWareToken } from "../config/jwt.js";

const imageRouter = express.Router();

//API GET danh sách ảnh
imageRouter.get("/get-all-image",middleWareToken, getImage)

//API GET danh sách ảnh phân trang
imageRouter.get("/get-all-image/:page",middleWareToken, getImagePage)

//API GET tìm kiếm danh sách ảnh theo tên
imageRouter.get("/search-image",middleWareToken,getImageSearch)

//API GET thông tin ảnh và người tạo ảnh bằng id ảnh
imageRouter.get("/get-image-detail/:imageId",getImageDetail)

//API GET thông tin bình luận theo Id ảnh
imageRouter.get("/get-comment/:imageId", getComment);

//API GET tt đã lưu hình này chưa theo Id ảnh( dùng để ktra ảnh đã lưu hay chưa ở nút Save)
imageRouter.get("/get-check-image-save/:imageId/:userId",
middleWareToken,
getCheckImageSave)

//API POST lưu tt bình luận của người dùng với hình ảnh
imageRouter.post("/create-comment",createComment)

//API DELETE xóa ảnh đã tạo theo Id ảnh
imageRouter.delete("/delete-image/:imageId",
middleWareToken,
deleteImage)

export default imageRouter