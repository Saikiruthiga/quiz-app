"use client";
import {
  Box,
  Typography,
  FormControl,
  InputLabel,
  MenuItem,
  Select,
} from "@mui/material";
import { useState, useEffect, useCallback } from "react";
export default function Home() {
  const [category, setCategory] = useState("");
  const [difficulty, setDifficulty] = useState("");
  const [questions, setQuestions] = useState([]);

  const fetchQuestions = useCallback(() => {
    if (!category || !difficulty) {
      alert("Please select both difficulty and category");
      return;
    }
    fetch(
      `http://localhost:5000/api/questions?difficulty=${difficulty}&category=${category}`
    )
      .then((response) => response.json())
      .then((data) => setQuestions(data))
      .catch((error) => console.error("Error fetching questions :", error));
  }, [category, difficulty]);

  useEffect(() => {
    if (category && difficulty) {
      fetchQuestions();
    }
  }, [category, difficulty, fetchQuestions]);

  return (
    <Box
      sx={{
        backgroundColor: "blue",
        height: "100vh",
        display: "flex",
        flexDirection: "column",
        alignItems: "center",
        justifyContent: "flex-start",
        paddingTop: "5%",
      }}
    >
      <Typography
        variant="h3"
        sx={{ color: "white", fontFamily: "'Georgia',serif" }}
      >
        Quiz App
      </Typography>
      <Box sx={{ margin: "20px", paddingLeft: "20px" }}>
        <FormControl
          sx={{
            minWidth: 150,
            backgroundColor: "white",
            borderRadius: 1,
            marginRight: "20px",
          }}
        >
          <InputLabel>Category</InputLabel>
          <Select
            value={category}
            onChange={(e) => setCategory(e.target.value)}
          >
            <MenuItem value="History">History</MenuItem>
            <MenuItem value="Science">Science</MenuItem>
            <MenuItem value="General Knowledge">General Knowledge</MenuItem>
          </Select>
        </FormControl>
        <FormControl
          sx={{
            minWidth: 150,
            backgroundColor: "white",
            borderRadius: 1,
            marginLeft: "20px",
          }}
        >
          <InputLabel>Difficulty</InputLabel>
          <Select
            value={difficulty}
            onChange={(e) => setDifficulty(e.target.value)}
          >
            <MenuItem value="easy">easy</MenuItem>
            <MenuItem value="medium">medium</MenuItem>
            <MenuItem value="hard">hard</MenuItem>
          </Select>
        </FormControl>
      </Box>
      {category && difficulty ? (
        <Box>
          {questions.length > 0 ? (
            questions.map((question) => (
              <Box key={question.id}>
                <Typography>{question.question_text}</Typography>
              </Box>
            ))
          ) : (
            <Typography>No questions available</Typography>
          )}
        </Box>
      ) : null}
    </Box>
  );
}
