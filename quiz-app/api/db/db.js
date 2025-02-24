import knex from "knex";
import dotenv from "dotenv";

dotenv.config(); // Load environment variables

//db is the knex instance
//knex - a query builder for sql databases

const db = knex({
  client: process.env.DB_CLIENT || "pg",
  connection: {
    host: process.env.DB_HOST || "127.0.0.1",
    port: process.env.DB_PORT || 5432,
    user: process.env.DB_USER || "postgres",
    password: process.env.DB_PASSWORD || "postgres",
    database: process.env.DB_DATABASE_NAME || "quiz_app",
    ssl:
      process.env.DB_USE_SSL === "true" ? { rejectUnauthorized: false } : false,
  },
  pool: { min: 2, max: 10 },
  debug: true,
});

export default db;
