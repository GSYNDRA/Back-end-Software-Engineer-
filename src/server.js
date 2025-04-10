import express from "express";
import cors from "cors";
import rootRoute from "./routes/rootRoutes.js";
import swaggerRouter from "./swagger/swagger.js";
import cookieParser from "cookie-parser";

const app = express();
app.use(express.json());
app.use(cookieParser()); // allows us to parse incoming cookies

app.use(cors());

app.use(express.static("."));

app.use(swaggerRouter);
app.use(rootRoute);

app.listen(8080);
export default app;
