import express from "express";
import quizRoutes from "./routes/quizRoutes.js";

const app = express();
const PORT = 5000;

app.use(express.json()); // Middleware to parse JSON
app.use("/api", quizRoutes); // Use the quiz API routes

app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});
