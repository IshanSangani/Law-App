const UserServices = require('../services/user.service');
exports.register = async (req, res, next) => {
    try {
        console.log("---req body---", req.body);
        const { email, password, role } = req.body;
        const duplicate = await UserServices.getUserByEmail(email);
        if (duplicate) {
            throw new Error(`UserName ${email}, Already Registered`)
        }
        const response = await UserServices.registerUser(email, password, role);

        res.json({ status: true, success: 'User registered successfully' });
    } catch (err) {
        console.log("---> err -->", err);
        next(err);
    }
}

exports.login = async (req, res, next) => {
    try {
        const { email, password } = req.body;

        if (!email || !password) {
            throw new Error('Parameter are not correct');
        }
        let user = await UserServices.checkUser(email);
        if (!user) {
            throw new Error('User does not exist');
        }

        const { isMatch, role } = await user.comparePassword(password);

        if (isMatch === false) {
            throw new Error(`Username or Password does not match`);
        }

        // Creating Token
        let tokenData;
        tokenData = { _id: user._id, email: user.email, role: role };

        const token = await UserServices.generateAccessToken(tokenData, "secret", "1h")

        res.status(200).json({ status: true, success: "sendData", token: token, role: role });
    } catch (error) {
        console.log(error, 'err---->');
        next(error);
    }
}