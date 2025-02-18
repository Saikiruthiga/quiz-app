import express from "express";
import db from "../db.js"; // Import the Knex connection

const router = express.Router();

router.get("/quizzes", async (req, res) => {
  try {
    const quizzes = await db("quizzes").select("*"); // Fetch all quizzes
    res.json(quizzes);
  } catch (error) {
    res.status(500).json({ error: "Database error: " + error.message });
  }
});

export default router;
