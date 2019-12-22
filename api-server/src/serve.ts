import express from "express";
import { api } from "./index";

const app = express();
const port = 3000;

app.get("/healthz", (req, res) => {
    res.status(200).send();
});

app.all("/api/v1/*", (req, res) => api(req, res));

app.listen(port, () => console.log(`TCPchecker API service is listening on ${port}!`));
