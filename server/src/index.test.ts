import express from "express";
import { api } from "./index";

const app = express();
const port = 3001;

app.all("/*", (req, res) => api(req, res));
app.listen(port, () => console.log(`Example app listening on port ${port}!`));
