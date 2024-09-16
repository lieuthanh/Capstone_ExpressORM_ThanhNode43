import express from "express"
import userRouter from "./user.router.js"
import imageRouter from "./image.router.js"
import authRouter from "./auth.router.js"

const rootRouter = express.Router()

rootRouter.use("/user", userRouter)
rootRouter.use("/image",imageRouter)
rootRouter.use("/auth",authRouter)

export default rootRouter