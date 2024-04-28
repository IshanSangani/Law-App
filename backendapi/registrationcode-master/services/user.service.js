const UserModel = require("../models/user.model");
const jwt = require("jsonwebtoken");

class UserServices {
 
    static async registerUser(email, password, role) {
        try {
            console.log("-----Email --- Password --- Role-----", email, password, role);
            
            const createUser = new UserModel({ email, password, role });
            return await createUser.save();
        } catch (err) {
            throw err;
        }
    }

    static async getUserByEmail(email) {
        try {
            return await UserModel.findOne({ email });
        } catch (err) {
            console.log(err);
        }
    }

    static async checkUser(email) {
        try {
            return await UserModel.findOne({ email });
        } catch (error) {
            throw error;
        }
    }

    static async generateAccessToken(tokenData, JWTSecret_Key, JWT_EXPIRE) {
        return jwt.sign(tokenData, JWTSecret_Key, { expiresIn: JWT_EXPIRE });
    }
}

module.exports = UserServices;