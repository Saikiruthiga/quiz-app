import express from "express";
import cors from "cors";
import quizRoutes from "./routes/quizRoutes.js";

const app = express(); // express application instance
const PORT = 5000;
app.use(cors());

app.use(express.json()); //middleware to parse JSON - convert incoming JSON request into javascript objects. without this Express app wont understand JSON request bodies
app.use("/api", quizRoutes);

app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});

//express - A web framework for building API servers

// i am sending a request to http://localhost:5000/api/quizzes
//express routes it to quizRoutes.js
//quizRoutes.js handles the request and responses.
