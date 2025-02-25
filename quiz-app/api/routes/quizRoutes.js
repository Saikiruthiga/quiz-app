import express from "express";
import db from "../db/db.js"; // Import the Knex connection

const router = express.Router(); // creates an Express Router instance (router) to handle routes separately

//To get all quizzes
router.get("/quizzes", async (req, res) => {
  try {
    const quizzes = await db("quizzes").select("*"); // Fetch all quizzes
    res.json(quizzes); // converts the javascript object / array into JSON response
  } catch (error) {
    res.status(500).json({ error: "Database error: " + error.message });
  }
});

// to get specific quiz by its id
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

// to post a new quiz
router.post("/quizzes", async (req, res) => {
  const { title, category, difficulty, created_by } = req.body;
  try {
    const [newQuiz] = await db("quizzes")
      .insert({
        title,
        category,
        difficulty,
        created_by,
      })
      .returning("*");

    res.status(201).json(newQuiz);
  } catch (error) {
    res.status(500).json({ error: "Error creating quiz : " + error.message });
  }
});

// to update a quiz

router.put("/quizzes/:id", async (req, res) => {
  const { id } = req.params;
  const { title, category, difficulty, created_by } = req.body;
  try {
    const updatedQuiz = await db("quizzes")
      .where({ id })
      .update({ title, category, difficulty, created_by })
      .returning("*");
    if (updatedQuiz.length === 0) {
      return res.status(404).json({ message: "Quiz not found" });
    }
    res.status(200).json(updatedQuiz[0]);
  } catch (error) {
    res.status(500).json({ error: "Error updating quiz:" + error.message });
  }
});

// to delete a quiz by its id

router.delete("/quizzes/:id", async (req, res) => {
  const { id } = req.params;
  try {
    const deleted = await db("quizzes").where({ id }).del();
    if (deleted === 0) {
      return res.status(404).json({ message: "quiz not found" });
    }
    return res.status(202).json({ message: "Deleted successfully" }); // 202 - accepted, 200 - ok, 204 - no content, we wont get any confirmation message
  } catch (error) {
    res.status(500).json({ error: "Error deleting quiz :" + error.message });
  }
});

// to post a question to a quiz

router.post("/quizzes/:id/questions", async (req, res) => {
  const { id } = req.params;
  const { question_text } = req.body;
  try {
    const [newQuestion] = await db("questions")
      .insert({ quiz_id: id, question_text: question_text })
      .returning("*");
    return res.status(200).json(newQuestion);
  } catch (error) {
    res
      .status(500)
      .json({ error: "Error adding new question : " + error.message });
  }
});

//to post options for a question

router.post("/questions/:id", async (req, res) => {
  const { id } = req.params;
  const { option_text, is_correct } = req.body;
  try {
    const [options] = await db("options")
      .insert({
        question_id: id,
        option_text: option_text,
        is_correct: is_correct,
      })
      .returning("*");
    return res.status(200).json(options);
  } catch (error) {
    res.status(500).json({
      error: "Error adding options to the question :" + error.message,
    });
  }
});

export default router;
