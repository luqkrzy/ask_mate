--
-- PostgreSQL database dump
--

-- Dumped from database version 13.1 (Ubuntu 13.1-1.pgdg20.10+1)
-- Dumped by pg_dump version 13.1 (Ubuntu 13.1-1.pgdg20.10+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: tag_insert(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.tag_insert() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
         INSERT INTO question_tag(question_id, tag_id)
         VALUES(NEW.question_id, NEW.tag_id);

    RETURN NEW;
END;
$$;


ALTER FUNCTION public.tag_insert() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: answer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.answer (
    answer_id integer NOT NULL,
    submission_time timestamp without time zone NOT NULL,
    vote_number integer DEFAULT 0,
    question_id integer,
    message text NOT NULL,
    image character varying DEFAULT 'default_answer.png'::character varying,
    user_id integer
);


ALTER TABLE public.answer OWNER TO postgres;

--
-- Name: answer_answer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.answer_answer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.answer_answer_id_seq OWNER TO postgres;

--
-- Name: answer_answer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.answer_answer_id_seq OWNED BY public.answer.answer_id;


--
-- Name: comment_for_answer_id; Type: SEQUENCE; Schema: public; Owner: luq
--

CREATE SEQUENCE public.comment_for_answer_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comment_for_answer_id OWNER TO luq;

--
-- Name: comment_for_answer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comment_for_answer (
    comment_id integer DEFAULT nextval('public.comment_for_answer_id'::regclass) NOT NULL,
    user_id integer,
    question_id integer,
    answer_id integer,
    message text NOT NULL,
    submission_time timestamp without time zone DEFAULT now(),
    edited_number integer DEFAULT 0
);


ALTER TABLE public.comment_for_answer OWNER TO postgres;

--
-- Name: comment_for_question_id; Type: SEQUENCE; Schema: public; Owner: luq
--

CREATE SEQUENCE public.comment_for_question_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comment_for_question_id OWNER TO luq;

--
-- Name: comment_for_question; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comment_for_question (
    comment_id integer DEFAULT nextval('public.comment_for_question_id'::regclass) NOT NULL,
    user_id integer,
    question_id integer,
    message text NOT NULL,
    submission_time timestamp without time zone DEFAULT now(),
    edited_number integer DEFAULT 0
);


ALTER TABLE public.comment_for_question OWNER TO postgres;

--
-- Name: question; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.question (
    question_id integer NOT NULL,
    user_id integer NOT NULL,
    submission_time timestamp without time zone,
    edit_submission_time timestamp without time zone,
    view_number integer DEFAULT 0,
    vote_number integer DEFAULT 0,
    title text NOT NULL,
    message text NOT NULL,
    image character varying DEFAULT 'default_question.png'::character varying,
    tag_id integer
);


ALTER TABLE public.question OWNER TO postgres;

--
-- Name: question_question_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.question_question_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.question_question_id_seq OWNER TO postgres;

--
-- Name: question_question_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.question_question_id_seq OWNED BY public.question.question_id;


--
-- Name: question_tag; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.question_tag (
    question_id integer,
    tag_id integer,
    question_tag_id integer NOT NULL
);


ALTER TABLE public.question_tag OWNER TO postgres;

--
-- Name: question_tag_question_tag_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.question_tag_question_tag_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.question_tag_question_tag_id_seq OWNER TO postgres;

--
-- Name: question_tag_question_tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.question_tag_question_tag_id_seq OWNED BY public.question_tag.question_tag_id;


--
-- Name: tag; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tag (
    tag_id integer NOT NULL,
    tag_name character varying(20)
);


ALTER TABLE public.tag OWNER TO postgres;

--
-- Name: tag_tag_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tag_tag_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tag_tag_id_seq OWNER TO postgres;

--
-- Name: tag_tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tag_tag_id_seq OWNED BY public.tag.tag_id;


--
-- Name: user_votes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_votes (
    vote_id integer NOT NULL,
    user_id integer,
    question_id integer,
    answer_id integer,
    has_voted integer,
    vote_time timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.user_votes OWNER TO postgres;

--
-- Name: user_votes_vote_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_votes_vote_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_votes_vote_id_seq OWNER TO postgres;

--
-- Name: user_votes_vote_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_votes_vote_id_seq OWNED BY public.user_votes.vote_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    user_name character varying(50) NOT NULL,
    email character varying(50) NOT NULL,
    password character varying(256) NOT NULL,
    register_date timestamp without time zone DEFAULT now(),
    reputation integer DEFAULT 0,
    picture character varying(50) DEFAULT 'default_user.jpg'::character varying
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO postgres;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: vc_requests; Type: TABLE; Schema: public; Owner: luq
--

CREATE TABLE public.vc_requests (
    id integer NOT NULL,
    year integer NOT NULL,
    month integer NOT NULL,
    day integer NOT NULL,
    hour integer NOT NULL,
    minute integer NOT NULL,
    ip character varying NOT NULL,
    user_agent character varying NOT NULL,
    path character varying NOT NULL,
    status integer NOT NULL,
    args character varying
);


ALTER TABLE public.vc_requests OWNER TO luq;

--
-- Name: vc_requests_id_seq; Type: SEQUENCE; Schema: public; Owner: luq
--

CREATE SEQUENCE public.vc_requests_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vc_requests_id_seq OWNER TO luq;

--
-- Name: vc_requests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: luq
--

ALTER SEQUENCE public.vc_requests_id_seq OWNED BY public.vc_requests.id;


--
-- Name: answer answer_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answer ALTER COLUMN answer_id SET DEFAULT nextval('public.answer_answer_id_seq'::regclass);


--
-- Name: question question_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question ALTER COLUMN question_id SET DEFAULT nextval('public.question_question_id_seq'::regclass);


--
-- Name: question_tag question_tag_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question_tag ALTER COLUMN question_tag_id SET DEFAULT nextval('public.question_tag_question_tag_id_seq'::regclass);


--
-- Name: tag tag_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tag ALTER COLUMN tag_id SET DEFAULT nextval('public.tag_tag_id_seq'::regclass);


--
-- Name: user_votes vote_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_votes ALTER COLUMN vote_id SET DEFAULT nextval('public.user_votes_vote_id_seq'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Name: vc_requests id; Type: DEFAULT; Schema: public; Owner: luq
--

ALTER TABLE ONLY public.vc_requests ALTER COLUMN id SET DEFAULT nextval('public.vc_requests_id_seq'::regclass);


--
-- Name: answer answer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answer
    ADD CONSTRAINT answer_pkey PRIMARY KEY (answer_id);


--
-- Name: comment_for_answer pk_com_for_answer_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment_for_answer
    ADD CONSTRAINT pk_com_for_answer_id PRIMARY KEY (comment_id);


--
-- Name: comment_for_question pkey_comm_quest; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment_for_question
    ADD CONSTRAINT pkey_comm_quest PRIMARY KEY (comment_id);


--
-- Name: question question_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question
    ADD CONSTRAINT question_pkey PRIMARY KEY (question_id);


--
-- Name: question_tag question_tag_id_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question_tag
    ADD CONSTRAINT question_tag_id_pkey PRIMARY KEY (question_tag_id);


--
-- Name: tag tag_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tag
    ADD CONSTRAINT tag_pkey PRIMARY KEY (tag_id);


--
-- Name: user_votes uniq_answer_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_votes
    ADD CONSTRAINT uniq_answer_id UNIQUE (answer_id);


--
-- Name: user_votes uniq_question_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_votes
    ADD CONSTRAINT uniq_question_id UNIQUE (question_id);


--
-- Name: users user_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT user_id PRIMARY KEY (user_id);


--
-- Name: user_votes user_votes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_votes
    ADD CONSTRAINT user_votes_pkey PRIMARY KEY (vote_id);


--
-- Name: vc_requests vc_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: luq
--

ALTER TABLE ONLY public.vc_requests
    ADD CONSTRAINT vc_requests_pkey PRIMARY KEY (id);


--
-- Name: fk_com_for_answ_question_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_com_for_answ_question_id ON public.comment_for_answer USING btree (question_id);


--
-- Name: fk_com_for_answ_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_com_for_answ_user_id ON public.comment_for_answer USING btree (user_id);


--
-- Name: fk_com_for_answer_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_com_for_answer_id ON public.comment_for_answer USING btree (answer_id);


--
-- Name: fk_com_for_question_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fk_com_for_question_user_id ON public.comment_for_question USING btree (user_id);


--
-- Name: question ins_same_rec; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER ins_same_rec AFTER INSERT ON public.question FOR EACH ROW EXECUTE FUNCTION public.tag_insert();


--
-- Name: user_votes fk_answer_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_votes
    ADD CONSTRAINT fk_answer_id FOREIGN KEY (answer_id) REFERENCES public.answer(answer_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: comment_for_answer fk_com_for_answ_question_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment_for_answer
    ADD CONSTRAINT fk_com_for_answ_question_id FOREIGN KEY (question_id) REFERENCES public.question(question_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: comment_for_answer fk_com_for_answ_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment_for_answer
    ADD CONSTRAINT fk_com_for_answ_user_id FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: comment_for_answer fk_com_for_answer_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment_for_answer
    ADD CONSTRAINT fk_com_for_answer_id FOREIGN KEY (answer_id) REFERENCES public.answer(answer_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: answer fk_question_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answer
    ADD CONSTRAINT fk_question_id FOREIGN KEY (question_id) REFERENCES public.question(question_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: question_tag fk_question_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question_tag
    ADD CONSTRAINT fk_question_id FOREIGN KEY (question_id) REFERENCES public.question(question_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_votes fk_question_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_votes
    ADD CONSTRAINT fk_question_id FOREIGN KEY (question_id) REFERENCES public.question(question_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: comment_for_question fk_question_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment_for_question
    ADD CONSTRAINT fk_question_id FOREIGN KEY (question_id) REFERENCES public.question(question_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: question fk_tag_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question
    ADD CONSTRAINT fk_tag_id FOREIGN KEY (tag_id) REFERENCES public.tag(tag_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: question_tag fk_tag_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question_tag
    ADD CONSTRAINT fk_tag_id FOREIGN KEY (tag_id) REFERENCES public.tag(tag_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: question fk_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question
    ADD CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: answer fk_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answer
    ADD CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_votes fk_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_votes
    ADD CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: comment_for_question fk_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment_for_question
    ADD CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

