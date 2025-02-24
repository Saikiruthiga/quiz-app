// A configuration file for knex where database connections are defined

import dotenv from "dotenv";

dotenv.config();
const knexConfig = {
  development: {
    client: process.env.DB_CLIENT,
    connection: {
      host: process.env.DB_HOST,
      port: process.env.DB_PORT,
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD,
      database: process.env.DB_DATABASE_NAME,
    },
    migrations: {
      directory: "./migrations",
    },
    seeds: {
      directory: "./seeds",
    },
  },
};

export default knexConfig;

//migrations for database schema management, adding columns, contraints,tables etc.,
//seeds - for inserting values by javascript instead of using SQL queries.
// knexConfig is imported in migrations and seeds file if we are using
