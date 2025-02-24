--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2
-- Dumped by pg_dump version 17.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: options; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.options (
    id integer NOT NULL,
    question_id integer,
    option_text text NOT NULL,
    is_correct boolean DEFAULT false NOT NULL
);


ALTER TABLE public.options OWNER TO postgres;

--
-- Name: options_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.options_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.options_id_seq OWNER TO postgres;

--
-- Name: options_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.options_id_seq OWNED BY public.options.id;


--
-- Name: questions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.questions (
    id integer NOT NULL,
    quiz_id integer,
    question_text text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.questions OWNER TO postgres;

--
-- Name: questions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.questions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.questions_id_seq OWNER TO postgres;

--
-- Name: questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.questions_id_seq OWNED BY public.questions.id;


--
-- Name: quizzes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.quizzes (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    category character varying(100) NOT NULL,
    difficulty character varying(50) DEFAULT 'medium'::character varying,
    created_by integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT quizzes_difficulty_check CHECK (((difficulty)::text = ANY ((ARRAY['easy'::character varying, 'medium'::character varying, 'hard'::character varying])::text[])))
);


ALTER TABLE public.quizzes OWNER TO postgres;

--
-- Name: quizzes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.quizzes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.quizzes_id_seq OWNER TO postgres;

--
-- Name: quizzes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.quizzes_id_seq OWNED BY public.quizzes.id;


--
-- Name: user_responses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_responses (
    id integer NOT NULL,
    user_id integer,
    question_id integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.user_responses OWNER TO postgres;

--
-- Name: user_responses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_responses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_responses_id_seq OWNER TO postgres;

--
-- Name: user_responses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_responses_id_seq OWNED BY public.user_responses.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(100) NOT NULL,
    email character varying(255) NOT NULL,
    password text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    role character varying(50) DEFAULT 'player'::character varying,
    CONSTRAINT users_role_check CHECK (((role)::text = ANY ((ARRAY['admin'::character varying, 'player'::character varying])::text[])))
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: options id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.options ALTER COLUMN id SET DEFAULT nextval('public.options_id_seq'::regclass);


--
-- Name: questions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questions ALTER COLUMN id SET DEFAULT nextval('public.questions_id_seq'::regclass);


--
-- Name: quizzes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quizzes ALTER COLUMN id SET DEFAULT nextval('public.quizzes_id_seq'::regclass);


--
-- Name: user_responses id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_responses ALTER COLUMN id SET DEFAULT nextval('public.user_responses_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: options options_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.options
    ADD CONSTRAINT options_pkey PRIMARY KEY (id);


--
-- Name: questions questions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_pkey PRIMARY KEY (id);


--
-- Name: quizzes quizzes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quizzes
    ADD CONSTRAINT quizzes_pkey PRIMARY KEY (id);


--
-- Name: user_responses user_responses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_responses
    ADD CONSTRAINT user_responses_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: options options_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.options
    ADD CONSTRAINT options_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.questions(id) ON DELETE CASCADE;


--
-- Name: questions questions_quiz_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_quiz_id_fkey FOREIGN KEY (quiz_id) REFERENCES public.quizzes(id) ON DELETE CASCADE;


--
-- Name: quizzes quizzes_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.quizzes
    ADD CONSTRAINT quizzes_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: user_responses user_responses_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_responses
    ADD CONSTRAINT user_responses_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.questions(id) ON DELETE CASCADE;


--
-- Name: user_responses user_responses_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_responses
    ADD CONSTRAINT user_responses_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

insert into users (username,email,password,role,created_at) values 
('Alice Johnson', 'alice@example.com', 'password123', 'admin', CURRENT_TIMESTAMP),
('Bob Smith', 'bob@example.com', 'password456', 'player', CURRENT_TIMESTAMP),
('Charlie Brown', 'charlie@example.com', 'password789', 'player', CURRENT_TIMESTAMP),
('Diana Prince', 'diana@example.com', 'password101', 'admin', CURRENT_TIMESTAMP),
('Eve Adams', 'eve@example.com', 'password202', 'player', CURRENT_TIMESTAMP);

insert into quizzes (title,category,difficulty,created_by,created_at)values
('General Knowledge Quiz', 'General Knowledge', 'medium', 1, CURRENT_TIMESTAMP),
('Science Quiz', 'Science', 'hard', 2, CURRENT_TIMESTAMP),
('History Quiz', 'History', 'easy', 3, CURRENT_TIMESTAMP);

insert into questions (quiz_id,question_text,created_at) VALUES
(1, 'What is the capital of France?', CURRENT_TIMESTAMP),
(1, 'Who wrote "To Kill a Mockingbird"?', CURRENT_TIMESTAMP),
(1, 'What is the largest planet in our solar system?', CURRENT_TIMESTAMP),
(1, 'What year did the Titanic sink?', CURRENT_TIMESTAMP),
(1, 'Who painted the Mona Lisa?', CURRENT_TIMESTAMP),
(2, 'What is the chemical symbol for water?', CURRENT_TIMESTAMP),
(2, 'Who developed the theory of relativity?', CURRENT_TIMESTAMP),
(2, 'What is the powerhouse of the cell?', CURRENT_TIMESTAMP),
(2, 'What planet is known as the Red Planet?', CURRENT_TIMESTAMP),
(2, 'What is the speed of light?', CURRENT_TIMESTAMP),
(3, 'Who was the first President of the United States?', CURRENT_TIMESTAMP),
(3, 'In what year did World War II end?', CURRENT_TIMESTAMP),
(3, 'Who was the first man to walk on the moon?', CURRENT_TIMESTAMP),
(3, 'What ancient civilization built the pyramids?', CURRENT_TIMESTAMP),
(3, 'Who was known as the Maid of Orleans?', CURRENT_TIMESTAMP);

INSERT INTO options (question_id, option_text, is_correct) VALUES
-- Options for question 1
(1, 'Paris', true),
(1, 'London', false),
(1, 'Berlin', false),
(1, 'Madrid', false),

-- Options for question 2
(2, 'Harper Lee', true),
(2, 'Mark Twain', false),
(2, 'Ernest Hemingway', false),
(2, 'F. Scott Fitzgerald', false),

-- Options for question 3
(3, 'Jupiter', true),
(3, 'Saturn', false),
(3, 'Earth', false),
(3, 'Mars', false),

-- Options for question 4
(4, '1912', true),
(4, '1905', false),
(4, '1920', false),
(4, '1898', false),

-- Options for question 5
(5, 'Leonardo da Vinci', true),
(5, 'Vincent van Gogh', false),
(5, 'Pablo Picasso', false),
(5, 'Claude Monet', false),

-- Options for question 6
(6, 'H2O', true),
(6, 'CO2', false),
(6, 'O2', false),
(6, 'N2', false),

-- Options for question 7
(7, 'Albert Einstein', true),
(7, 'Isaac Newton', false),
(7, 'Galileo Galilei', false),
(7, 'Nikola Tesla', false),

-- Options for question 8
(8, 'Mitochondria', true),
(8, 'Nucleus', false),
(8, 'Ribosome', false),
(8, 'Chloroplast', false),

-- Options for question 9
(9, 'Mars', true),
(9, 'Venus', false),
(9, 'Jupiter', false),
(9, 'Saturn', false),

-- Options for question 10
(10, '299,792,458 m/s', true),
(10, '150,000,000 m/s', false),
(10, '1,000,000 m/s', false),
(10, '300,000,000 m/s', false),

-- Options for question 11
(11, 'George Washington', true),
(11, 'Thomas Jefferson', false),
(11, 'Abraham Lincoln', false),
(11, 'John Adams', false),

-- Options for question 12
(12, '1945', true),
(12, '1939', false),
(12, '1918', false),
(12, '1965', false),

-- Options for question 13
(13, 'Neil Armstrong', true),
(13, 'Buzz Aldrin', false),
(13, 'Yuri Gagarin', false),
(13, 'Michael Collins', false),

-- Options for question 14
(14, 'Egyptians', true),
(14, 'Romans', false),
(14, 'Greeks', false),
(14, 'Mayans', false),

-- Options for question 15
(15, 'Joan of Arc', true),
(15, 'Marie Curie', false),
(15, 'Queen Elizabeth I', false),
(15, 'Catherine the Great', false);