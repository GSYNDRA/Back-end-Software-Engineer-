import express from "express";
// import { login, signup } from "../controllers/authController.js";
import AuthController from '../controllers/authController.js';
import { verifyToken } from '../config/jwt.js';

const authRoutes = express.Router();


/**
 * @swagger
 * tags:
 *   name: Auth
 *   description: Authentication related routes
 */

/**
 * @swagger
 * /auth/login:
 *   post:
 *     summary: Log in a user
 *     tags: [Auth]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               email:
 *                 type: string
 *               password:
 *                 type: string
 *     responses:
 *       200:
 *         description: Successful login
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 token:
 *                   type: string
 *       400:
 *         description: Invalid input
 */
// authRoutes.post("/login", login);

/**
 * @swagger
 * /auth/signup:
 *   post:
 *     summary: Sign up a new user
 *     tags: [Auth]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               email:
 *                 type: string
 *               password:
 *                 type: string
 *     responses:
 *       201:
 *         description: User created
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 id:
 *                   type: string
 *                 email:
 *                   type: string
 *       400:
 *         description: Invalid input
 */
// authRoutes.post("/signup", signup);

authRoutes.post('/signup', AuthController.signup);
authRoutes.post('/reset-verification-token', AuthController.resetVerificationToken);
authRoutes.post('/verify-account', AuthController.verifyEmail);

authRoutes.post('/login', AuthController.login);
authRoutes.post('/logout', AuthController.logout);
authRoutes.post('/refresh-token', AuthController.refreshToken);

authRoutes.post('/forgot-password', AuthController.forgetPassword);
authRoutes.post('/reset-forgot-password-token', AuthController.resetForgotPasswordToken);

authRoutes.post('/reset-password', AuthController.resetPassword);

authRoutes.post('/change-password',verifyToken, AuthController.changePassword);
authRoutes.post('/verify-code-number',AuthController.verifyResetOrVerificationToken);

export default authRoutes;
