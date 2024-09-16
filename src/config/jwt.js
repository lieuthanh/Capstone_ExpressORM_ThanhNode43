import jwt from "jsonwebtoken";
//yarn add jsonwebtoken
export const createToken = (data)=>{
    //tham số 1 payload: string, buffer, object
    //tham số 2 signature (secret key)
    //tham số 3 header
    return jwt.sign({data}, "NODE_43", {algorithm: "HS256", expiresIn:"7d"})
}

export const verifyToken = (token)=>
    //khác khóa bí mật
    //kiểm tra token
    //hợp lệ error = null, ko hợp lệ error != null
    jwt.verify(token, "NODE_43", (error)=> error)

//xử lý refresh_token
export const createTokenRef = (data)=>{
    return jwt.sign({data}, "RESET", {algorithm: "HS256", expiresIn:"7d"})
}

export const verifyTokenRef = token=> jwt.verify(token, "RESET", error=> error)


export const decodeToken = (token)=>{
    return jwt.decode(token)
}

export const middleWareToken = (req,res,next)=>{
    let {token} = req.headers;
    let checkToken = verifyToken(token)
    if(checkToken == null){
        next()
        return
    }else{
        
        res.status(401).send(checkToken.name)
    }
}