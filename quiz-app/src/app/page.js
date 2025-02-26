import { Box } from "@mui/material";
export default function Home() {
  return (
    <Box
      sx={{
        backgroundColor: "blue",
        height: "100vh",
        display: "flex",
        alignItems: "center",
        justifyContent: "center",
      }}
    >
      <h1 style={{ color: "white" }}>Quiz app</h1>
    </Box>
  );
}
