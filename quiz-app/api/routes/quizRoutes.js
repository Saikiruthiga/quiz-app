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

export default router;
