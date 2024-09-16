import express from "express"
import rootRouter from "./routes/rootRouter.js";
import cors from "cors"

const app = express();
app.use(express.json());
app.use(express.static(".")); //định vị load thư mục tài nguyên


app.use(cors())

app.use(rootRouter)
app.listen(8080)


