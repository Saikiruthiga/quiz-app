"use client";
import {
  Box,
  Typography,
  FormControl,
  InputLabel,
  MenuItem,
  Select,
} from "@mui/material";
import { useState } from "react";
export default function Home() {
  const [category, setCategory] = useState("");
  const [difficulty, setDifficulty] = useState("");
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
      <FormControl
        sx={{ minWidth: 200, backgroundColor: "white", borderRadius: 1 }}
      >
        <InputLabel>Category</InputLabel>
        <Select value={category} onChange={(e) => setCategory(e.target.value)}>
          <MenuItem value="History">History</MenuItem>
          <MenuItem value="Science">Science</MenuItem>
          <MenuItem value="General Knowledge">General Knowledge</MenuItem>
        </Select>
      </FormControl>
      <FormControl
        sx={{ minWidth: 200, backgroundColor: "white", borderRadius: 1 }}
      >
        <InputLabel>Difficulty</InputLabel>
        <Select
          value={difficulty}
          onChange={(e) => setDifficulty(e.target.value)}
        >
          <MenuItem value="Easy">Easy</MenuItem>
          <MenuItem value="Medium">Medium</MenuItem>
          <MenuItem value="Hard">Hard</MenuItem>
        </Select>
      </FormControl>
    </Box>
  );
}
