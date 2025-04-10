
// import bcrypt from "bcrypt";


// export const login = async (req, res) => {
//   let { user_name, user_password } = req.body;

//   // check email and password == table user
//   let checkUser = await model.users.findOne({
//     where: {
//       user_name,
//     },
//   });

//   // exist => login successfully
//   if (checkUser) {
//     bcrypt.compare(user_password, checkUser.user_password, (err, result) => {
//       if (err) {
//         console.error(err);
//         responseData(res, "An error occurred during login", "", 500);
//         return;
//       }

//       if (result) {
//         let token = { user_id: checkUser.user_id, role_id: checkUser.role_id };
//         responseData(res, "Login successfully", token, 200);
//       } else {
//         // wrong password
//         responseData(res, "Wrong password", "", 400);
//       }
//     });
//   } else {
//     // not exist
//     responseData(res, "User doesn't exist", "", 400);
//   }
// };

// export const signup = async (req, res) => {
//   // try {
//   let {
//     full_name,
//     address,
//     user_name,
//     bank_account,
//     user_password,
//     phone,
//     email,
//   } = req.body;

//   // Validate bank account
//   if (!/^[a-zA-Z\s]+-\d+$/.test(bank_account)) {
//     return responseData(res, "Invalid bank account format", "", 400);
//   }

//   // Validate user password (must contain uppercase, lowercase, digit, and special character)
//   if (
//     !/(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+])[A-Za-z\d!@#$%^&*()_+]{8,}/.test(
//       user_password
//     )
//   ) {
//     return responseData(
//       res,
//       "Password must contain at least one uppercase letter, one lowercase letter, one digit, one special character, and be at least 8 characters long",
//       "",
//       400
//     );
//   }

//   // Validate phone number (assuming phone number should be exactly 10 digits)
//   if (!/^\d{10}$/.test(phone)) {
//     return responseData(res, "Invalid phone number format", "", 400);
//   }

//   // Validate email address
//   if (!/^\S+@\S+\.\S+$/.test(email)) {
//     return responseData(res, "Invalid email address", "", 400);
//   }

//   let checkUser = await model.users.findOne({
//     where: {
//       user_name,
//     },
//   });

//   if (checkUser) {
//     return responseData(res, "Username already exists", "", 400);
//   }

//   //hash the pass
//   let hashedPassword = bcrypt.hashSync(user_password, 10);

//   let newData = {
//     full_name,
//     address,
//     user_name,
//     bank_account,
//     user_password: hashedPassword,
//     phone,
//     email,
//     role_id: 2,
//   };

//   await model.users.create(newData);

//   responseData(res, "Sucessfully sign up", "", 200);
//   // } catch {
//   //   responseData(res, "Error", "", 500);
//   // }
// };

import { responseData } from "../config/response.js";
import * as service from "../services/authService.js";

export default class AuthController {
  static async signup(req, res) {
    const {
    full_name,
    address,
    user_name,
    bank_account,
    password,
    phone,
    email,
    } = req.body;
    const { error, data, status } = await service.signupService(
      full_name,
      address,
      user_name,
      bank_account,
      password,
      phone,
      email,
    );

    if (error) {
      return responseData(res, error, "", status);
    }
    return responseData(res, "success", data, status);
  }
  static async verifyEmail(req, res) {
    const { code } = req.body;
    const { error, data, status } = await service.verifyEmailService(code, res);

    if (error) {
      return responseData(res, error, "", status);
    }
    return responseData(res, "success", data, status);
  }

  static async resetVerificationToken(req, res) {
    const { email } = req.body;
    const { error, message, data, status } =
      await service.resetVerificationTokenService(email);

    if (error) {
      return responseData(res, error, "", status);
    }
    return responseData(res, message, data, status);
  }

  static async resetForgotPasswordToken(req, res) {
    const { email } = req.body;
    const { error, message, data, status } =
      await service.resetForgotPasswordTokenService(email);

    if (error) {
      return responseData(res, error, "", status);
    }
    return responseData(res, message, data, status);
  }

  static async login(req, res) {
    const { email, password } = req.body;
    const { error, data, status } = await service.loginService(
      res,
      email,
      password
    );

    if (error) {
      return responseData(res, error, "", status);
    }
    return responseData(res, "Login successfully", data, status);
  }

  static async logout(req, res) {
    // const { token } = req.headers;
    const { error, message, status } = await service.logoutService(req, res);

    if (error) {
      return responseData(res, error, "", status);
    }
    return responseData(res, message, "", status);
  }

  static async refreshToken(req, res) {
    // const { token } = req.headers;
    const { error, data, status } = await service.refreshTokenService(req, res);

    if (error) {
      return responseData(res, error, "", status);
    }
    return responseData(res, "", data, status);
  }

  static async forgetPassword(req, res) {
    const { email } = req.body;
    const { error, message, data, status } =
      await service.forgetPasswordService(email);

    if (error) {
      return responseData(res, error, "", status);
    }
    return responseData(res, message, data, status);
  }

  static async resetPassword(req, res) {
    const { code, newPassword} = req.body;
    const { error,message, data, status } = await service.resetPasswordService(code, newPassword);

    if (error) {
      return responseData(res, error, "", status);
    }
    return responseData(res, message, data, status);
  }

  static async changePassword(req, res) {
    const { newPassword, oldPassword} = req.body;
    let id = req.user_id;
    console.log(id)
    const { error,message, data, status } = await service.changePasswordService(id, oldPassword, newPassword);

    if (error) {
      return responseData(res, error, "", status);
    }
    return responseData(res, message, data, status);
  }

  static async verifyResetOrVerificationToken(req, res) {
    const { code } = req.body;
    const { error,message, data, status } = await service.verifyResetOrVerificationTokenService(code);

    if (error) {
      return responseData(res, error, "", status);
    }
    return responseData(res, message, data, status);
  }
  
}
