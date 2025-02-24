import express from "express";
import db from "../db/db.js"; // Import the Knex connection

const router = express.Router(); // creates an Express Router instance (router) to handle routes separately

router.get("/quizzes", async (req, res) => {
  try {
    const quizzes = await db("quizzes").select("*"); // Fetch all quizzes
    res.json(quizzes); // converts the javascript object / array into JSON response
  } catch (error) {
    res.status(500).json({ error: "Database error: " + error.message });
  }
});

router.get("/quizzes/:id", async (req, res) => {
  const { id } = req.params;
  try {
    const quiz = await db("quizzes").where({ id }).first();
    if (!quiz) {
      return res.status(404).json({ message: "Quiz not found" });
    }
    const quizQuestions = await db("questions").where({ quiz_id: id });
    res.json({ quiz, questions: quizQuestions });
  } catch (error) {
    res.status(500).json({ error: "Database error" + error.message });
  }
});

export default router;
