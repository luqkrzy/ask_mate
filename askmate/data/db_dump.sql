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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: answer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.answer (
    answer_id integer NOT NULL,
    submission_time timestamp without time zone NOT NULL,
    vote_number integer,
    question_id integer,
    message text NOT NULL,
    image character varying
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
-- Name: comment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comment (
    comment_id integer NOT NULL,
    user_id integer,
    question_id integer,
    answer_id integer,
    message text NOT NULL,
    submission_time timestamp without time zone,
    edited_number integer
);


ALTER TABLE public.comment OWNER TO postgres;

--
-- Name: comment_comment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.comment_comment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comment_comment_id_seq OWNER TO postgres;

--
-- Name: comment_comment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.comment_comment_id_seq OWNED BY public.comment.comment_id;


--
-- Name: question; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.question (
    question_id integer NOT NULL,
    user_id integer NOT NULL,
    submission_time timestamp without time zone NOT NULL,
    edit_submission_time timestamp without time zone,
    view_number integer,
    vote_number integer,
    title text NOT NULL,
    message text NOT NULL,
    image character varying
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
    tag_id integer
);


ALTER TABLE public.question_tag OWNER TO postgres;

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
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    user_name character varying(50) NOT NULL,
    email character varying(50) NOT NULL,
    password character varying(256) NOT NULL,
    register_date timestamp without time zone,
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
-- Name: answer answer_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answer ALTER COLUMN answer_id SET DEFAULT nextval('public.answer_answer_id_seq'::regclass);


--
-- Name: comment comment_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment ALTER COLUMN comment_id SET DEFAULT nextval('public.comment_comment_id_seq'::regclass);


--
-- Name: question question_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question ALTER COLUMN question_id SET DEFAULT nextval('public.question_question_id_seq'::regclass);


--
-- Name: tag tag_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tag ALTER COLUMN tag_id SET DEFAULT nextval('public.tag_tag_id_seq'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Data for Name: answer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.answer (answer_id, submission_time, vote_number, question_id, message, image) FROM stdin;
1	2020-02-05 03:26:13	48	44	Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.\n\nPraesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.\n\nCras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.	\N
2	2020-03-03 23:54:27	29	47	Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.\n\nQuisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.\n\nVestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.	\N
3	2020-05-05 06:31:32	78	46	Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.	\N
4	2020-03-20 23:12:51	3	33	Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.	\N
5	2020-06-30 03:08:26	87	31	Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.	\N
6	2020-11-17 19:05:27	41	19	Sed ante. Vivamus tortor. Duis mattis egestas metus.\n\nAenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.\n\nQuisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.	\N
7	2020-08-05 05:54:00	15	35	Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.\n\nNullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.	\N
8	2020-05-08 03:33:46	52	39	Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.	\N
9	2020-07-04 19:36:45	6	32	Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.\n\nMorbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.\n\nFusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.	\N
10	2020-04-16 13:33:55	90	48	Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.	\N
11	2020-03-22 06:58:22	24	34	Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.\n\nDuis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.	\N
12	2020-09-26 23:44:02	11	24	Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.\n\nPhasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.\n\nProin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.	\N
13	2020-07-29 03:14:07	82	38	Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.	\N
14	2020-05-01 06:02:50	1	34	In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.\n\nSuspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.	\N
15	2020-06-15 10:06:20	7	55	Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.	\N
16	2020-07-18 06:24:50	35	52	Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.\n\nPhasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.\n\nProin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.	\N
17	2020-11-13 01:13:51	86	45	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.\n\nVestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.\n\nDuis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.	\N
18	2020-02-10 15:17:36	86	33	Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.\n\nPhasellus in felis. Donec semper sapien a libero. Nam dui.	\N
19	2020-12-15 05:44:07	58	25	Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.\n\nProin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.	\N
20	2020-12-27 07:20:02	54	15	Fusce consequat. Nulla nisl. Nunc nisl.	\N
21	2020-03-09 21:48:52	15	29	In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.\n\nNulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.\n\nCras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.	\N
22	2021-01-06 03:24:53	68	48	Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.	\N
23	2020-04-11 04:35:26	58	28	Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.\n\nMaecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.\n\nNullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.	\N
24	2020-06-16 00:01:20	28	48	Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.\n\nMaecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.	\N
82	2020-08-17 04:57:22	27	22	Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.	\N
25	2021-01-03 19:39:25	69	32	Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.\n\nEtiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.	\N
26	2020-01-26 12:32:36	14	53	Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.\n\nQuisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.\n\nPhasellus in felis. Donec semper sapien a libero. Nam dui.	\N
27	2020-08-02 02:07:46	84	12	Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.\n\nIn quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.	\N
28	2020-08-11 10:40:25	1	49	Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.	\N
29	2020-08-03 01:33:49	88	11	In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.	\N
30	2020-04-13 20:42:31	59	38	Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.\n\nFusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.\n\nSed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.	\N
31	2020-08-24 17:02:12	91	36	Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.	\N
32	2020-10-22 20:16:29	3	35	Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.	\N
33	2020-09-22 20:33:49	62	18	Sed ante. Vivamus tortor. Duis mattis egestas metus.\n\nAenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.\n\nQuisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.	\N
34	2020-04-09 20:46:46	47	22	Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.	\N
35	2020-12-19 05:54:05	93	22	Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.\n\nAenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.\n\nCurabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.	\N
36	2020-02-15 08:14:02	70	49	Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.\n\nIn congue. Etiam justo. Etiam pretium iaculis justo.\n\nIn hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.	\N
37	2020-02-07 13:06:42	6	34	Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.\n\nDuis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.	\N
38	2020-11-23 09:15:57	14	51	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.\n\nVestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.	\N
39	2020-05-21 04:44:12	67	26	In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.\n\nNulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.\n\nCras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.	\N
40	2020-03-27 09:11:22	19	11	Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.\n\nQuisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.\n\nVestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.	\N
41	2020-12-12 07:48:51	5	38	Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.\n\nIn hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.\n\nAliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.	\N
42	2020-05-06 10:30:06	93	8	Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.\n\nProin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.\n\nDuis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.	\N
43	2020-08-17 06:56:50	50	26	Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.	\N
44	2020-05-19 18:13:55	58	49	In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.	\N
45	2020-01-23 00:46:57	9	20	Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.\n\nIn quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.	\N
46	2020-11-14 20:42:52	13	39	Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.\n\nPhasellus in felis. Donec semper sapien a libero. Nam dui.	\N
47	2020-01-20 05:07:00	8	43	Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.	\N
48	2020-05-31 05:45:48	63	49	Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.\n\nFusce consequat. Nulla nisl. Nunc nisl.\n\nDuis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.	\N
49	2020-10-19 00:40:44	79	26	Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.	\N
50	2020-08-10 22:05:28	49	15	Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.\n\nMaecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.	\N
51	2020-10-18 14:37:30	55	18	Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.\n\nCurabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.\n\nInteger tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.	\N
52	2020-04-19 19:30:40	79	31	In congue. Etiam justo. Etiam pretium iaculis justo.\n\nIn hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.	\N
53	2020-05-28 07:03:10	85	26	Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.	\N
54	2020-08-07 20:07:15	36	31	Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.	\N
55	2020-05-26 11:52:51	58	14	Sed ante. Vivamus tortor. Duis mattis egestas metus.	\N
56	2020-08-02 16:57:01	96	50	Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.\n\nInteger tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.\n\nPraesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.	\N
57	2020-03-01 07:40:05	6	44	Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.\n\nCurabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.	\N
58	2020-10-03 20:42:31	41	25	In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.\n\nAliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.	\N
59	2020-08-16 16:54:20	18	40	Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.\n\nMaecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.\n\nCurabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.	\N
60	2020-07-04 17:57:32	73	13	Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.\n\nPraesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.	\N
61	2020-05-09 08:00:48	59	35	Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.\n\nAenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.	\N
62	2020-11-23 22:35:45	57	14	Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.	\N
63	2020-05-21 13:27:11	71	23	Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.	\N
64	2020-11-07 04:16:25	18	11	Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.	\N
65	2020-06-04 08:24:50	62	20	Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.\n\nPraesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.	\N
66	2020-10-10 04:30:44	31	42	In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.\n\nAliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.\n\nSed ante. Vivamus tortor. Duis mattis egestas metus.	\N
67	2020-02-23 15:43:06	1	52	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.	\N
68	2020-03-28 23:34:49	99	12	Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.	\N
69	2020-08-14 11:30:17	54	39	In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.\n\nMaecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.	\N
70	2020-05-13 17:08:45	95	30	Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.\n\nProin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.\n\nDuis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.	\N
71	2020-09-18 14:33:33	10	28	Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.	\N
72	2020-07-05 13:02:25	97	55	Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.	\N
73	2020-11-10 09:00:21	36	51	Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.	\N
74	2020-11-05 13:18:18	90	15	In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.\n\nSuspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.\n\nMaecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.	\N
75	2020-05-20 13:21:36	42	48	Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.	\N
76	2020-05-06 05:09:45	57	50	Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.	\N
77	2020-08-28 06:02:56	93	51	Sed ante. Vivamus tortor. Duis mattis egestas metus.\n\nAenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.	\N
78	2020-11-10 14:38:20	57	28	Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.	\N
79	2020-08-07 23:42:05	64	35	Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.\n\nProin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.	\N
80	2020-07-07 12:03:33	67	12	Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.	\N
81	2020-01-25 03:59:34	60	41	Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.\n\nProin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.\n\nDuis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.	\N
83	2020-09-18 11:22:04	35	56	Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.\n\nCras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.\n\nQuisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.	\N
84	2020-06-12 11:15:09	32	25	Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.	\N
85	2020-11-07 19:27:11	43	49	Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.\n\nQuisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.\n\nVestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.	\N
86	2020-06-12 15:05:07	36	34	Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.	\N
87	2020-09-20 08:15:09	70	37	Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.\n\nPellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.\n\nCum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.	\N
88	2020-02-06 23:02:52	59	12	Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.	\N
89	2020-08-15 18:28:10	88	24	Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.	\N
90	2020-08-11 03:05:08	87	51	Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.	\N
91	2020-11-16 06:28:43	28	51	Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.	\N
92	2020-05-08 17:15:28	11	33	Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.	\N
93	2020-04-26 13:05:45	41	35	In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.\n\nAliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.\n\nSed ante. Vivamus tortor. Duis mattis egestas metus.	\N
94	2020-10-18 17:29:40	3	54	Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.\n\nCurabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.	\N
95	2020-05-19 00:54:46	14	35	Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.\n\nCurabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.\n\nPhasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.	\N
96	2020-10-30 18:02:02	90	19	Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.\n\nNam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.	\N
97	2020-09-21 16:33:40	83	20	Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.\n\nCurabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.\n\nPhasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.	\N
98	2020-03-25 14:18:41	28	17	Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.\n\nNullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.\n\nIn quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.	\N
99	2020-12-26 08:51:11	15	23	Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.\n\nMaecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.\n\nCurabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.	\N
100	2020-06-04 08:55:37	77	32	Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.\n\nDuis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.\n\nDonec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.	\N
\.


--
-- Data for Name: comment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.comment (comment_id, user_id, question_id, answer_id, message, submission_time, edited_number) FROM stdin;
1	6	7	78	Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem. Fusce consequat.	2020-09-14 09:36:17	5
2	7	54	34	Curabitur convallis. Duis consequat dui nec nisi volutpat eleifend.	2020-11-29 12:59:04	5
3	11	20	19	Etiam justo. Etiam pretium iaculis justo. In hac habitasse platea dictumst.	2020-09-21 21:22:30	1
4	12	30	65	Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci.	2020-09-28 13:01:58	1
5	5	13	97	Donec dapibus.	2020-02-09 01:03:48	4
6	2	48	36	Suspendisse accumsan tortor quis turpis. Sed ante. Vivamus tortor.	2020-12-11 21:08:53	2
7	10	54	95	Morbi non quam nec dui luctus rutrum. Nulla tellus. In sagittis dui vel nisl.	2021-01-05 03:23:24	5
8	4	29	14	In congue.	2020-12-13 14:28:07	3
9	5	23	8	Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam. Nam tristique tortor eu pede.	2020-11-21 17:31:20	4
10	2	10	94	Nulla nisl. Nunc nisl.	2020-01-12 22:26:57	5
11	9	44	82	Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.	2020-07-19 22:55:43	3
12	11	50	22	Suspendisse potenti. Nullam porttitor lacus at turpis.	2020-03-22 20:16:31	3
13	2	55	40	Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui. Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc.	2020-10-08 23:54:01	2
14	10	51	69	Mauris lacinia sapien quis libero. Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum.	2020-05-10 01:37:32	1
15	12	24	43	Nunc rhoncus dui vel sem. Sed sagittis.	2020-02-15 17:21:39	3
16	4	55	23	Quisque porta volutpat erat.	2020-11-03 06:45:24	3
17	3	14	93	Duis mattis egestas metus. Aenean fermentum.	2020-01-19 02:33:55	5
18	7	15	66	Pellentesque at nulla. Suspendisse potenti.	2020-11-25 08:08:23	1
19	4	29	65	Vestibulum sed magna at nunc commodo placerat. Praesent blandit.	2020-02-05 16:12:50	5
20	1	29	45	Pellentesque eget nunc.	2020-03-08 15:28:04	3
21	11	15	54	Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.	2020-10-07 20:41:54	1
22	5	45	8	Aliquam quis turpis eget elit sodales scelerisque.	2020-05-19 01:09:45	1
23	9	55	13	Nunc purus. Phasellus in felis.	2020-03-01 14:01:49	3
24	5	31	26	Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus. Phasellus in felis.	2020-07-11 19:32:07	2
25	9	7	28	Sed accumsan felis. Ut at dolor quis odio consequat varius.	2020-10-08 22:52:33	1
26	3	42	59	Etiam vel augue.	2020-11-20 15:25:32	3
27	8	30	15	Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.	2020-12-11 21:34:18	3
28	1	16	59	Fusce consequat.	2020-04-24 13:12:29	3
29	8	14	39	Phasellus in felis. Donec semper sapien a libero. Nam dui.	2020-07-08 04:38:39	3
30	1	39	65	Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.	2020-06-06 09:51:29	5
31	7	39	99	In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante.	2020-04-28 11:39:23	2
32	3	49	62	Cras pellentesque volutpat dui. Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam.	2020-06-12 04:01:31	4
33	4	14	92	Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.	2020-06-16 16:31:32	2
34	12	16	30	Nulla tellus. In sagittis dui vel nisl. Duis ac nibh.	2020-05-02 07:00:12	3
35	3	50	36	Donec ut mauris eget massa tempor convallis.	2020-10-26 12:52:58	2
36	10	21	25	Vivamus tortor.	2020-06-29 13:06:35	1
37	1	23	29	Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.	2020-09-22 04:32:15	5
38	7	19	15	Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.	2020-03-27 20:25:05	2
39	9	26	75	In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.	2020-09-25 17:25:56	4
40	12	12	29	Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante.	2020-10-24 16:12:23	4
41	8	20	11	Nulla mollis molestie lorem.	2020-02-27 11:32:44	3
42	8	20	7	In sagittis dui vel nisl. Duis ac nibh.	2020-07-17 09:22:47	1
43	3	29	74	Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.	2020-03-15 16:47:27	5
44	4	40	64	Quisque ut erat. Curabitur gravida nisi at nibh. In hac habitasse platea dictumst.	2020-02-28 10:11:59	5
45	1	46	69	Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante.	2020-02-16 21:44:28	3
46	4	54	46	Nam dui. Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis.	2020-01-16 10:46:00	2
47	5	16	23	Donec vitae nisi. Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus.	2020-03-24 07:21:42	2
48	3	50	33	Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.	2020-10-26 23:02:04	3
49	3	10	3	Sed ante.	2020-08-24 17:27:13	4
50	12	33	26	Nulla ac enim.	2020-03-02 07:02:36	5
\.


--
-- Data for Name: question; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.question (question_id, user_id, submission_time, edit_submission_time, view_number, vote_number, title, message, image) FROM stdin;
7	13	2020-04-28 06:00:18	2020-01-18 19:28:44	36	63	Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.	Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat. In congue. Etiam justo. Etiam pretium iaculis justo. In hac habitasse platea dictumst. Etiam faucibus cursus urna.	\N
8	2	2020-03-01 04:35:36	2020-12-23 21:24:48	803	24	Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.	Suspendisse potenti. Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris. Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis. Fusce posuere felis sed lacus.	\N
9	4	2020-07-07 12:47:47	2020-07-18 21:55:43	827	20	Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.	Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc.	\N
10	7	2020-12-17 02:54:11	2020-01-22 03:09:45	118	160	Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.	Aenean sit amet justo.	\N
11	7	2020-07-16 14:03:17	2020-06-13 17:43:46	874	172	Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.	Vivamus tortor. Duis mattis egestas metus. Aenean fermentum.	\N
12	13	2020-10-06 13:47:03	2020-03-15 23:46:06	334	107	Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.	Pellentesque viverra pede ac diam.	\N
13	2	2020-05-09 14:38:38	2020-02-11 06:06:28	718	4	Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.	Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem. Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat. Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.	\N
14	5	2020-08-31 20:04:40	2020-05-22 19:42:44	534	19	Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.	Praesent lectus. Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis. Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus. Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.	\N
15	4	2020-08-16 04:12:19	2020-12-01 07:35:40	894	194	In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.	Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus. Curabitur at ipsum ac tellus semper interdum.	\N
16	1	2020-10-26 10:19:18	2021-01-06 09:05:25	600	43	In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.	In eleifend quam a odio. In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat. Curabitur gravida nisi at nibh. In hac habitasse platea dictumst.	\N
17	13	2020-12-14 07:33:43	2020-12-27 21:14:04	808	94	Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.	Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum. Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc.	\N
18	11	2020-03-29 09:43:16	2020-10-27 18:59:07	810	101	Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.	In eleifend quam a odio. In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat. Curabitur gravida nisi at nibh.	\N
19	5	2020-11-22 20:55:30	2020-01-21 11:25:46	358	51	In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.	Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.	\N
20	13	2020-01-19 01:15:12	2020-07-01 16:53:23	383	139	In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.	Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl. Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum. Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est. Phasellus sit amet erat.	\N
21	10	2020-11-18 20:37:38	2020-09-01 03:29:29	687	128	Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.	Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros. Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat. In congue. Etiam justo. Etiam pretium iaculis justo. In hac habitasse platea dictumst.	\N
22	12	2020-02-28 01:59:29	2020-10-23 08:41:19	152	72	In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.	Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl. Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum. Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.	\N
23	2	2020-06-18 07:52:09	2020-07-15 11:53:24	608	6	Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.	Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris. Morbi non lectus.	\N
24	2	2020-11-16 12:20:29	2020-05-10 22:35:32	946	85	Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.	Donec dapibus. Duis at velit eu est congue elementum.	\N
25	12	2020-12-02 11:35:22	2020-06-04 23:24:11	442	161	Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.	Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros. Vestibulum ac est lacinia nisi venenatis tristique.	\N
26	2	2020-04-12 11:18:22	2020-09-21 05:33:25	750	88	Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.	Nulla nisl. Nunc nisl. Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum. In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante.	\N
27	13	2020-11-21 18:43:03	2020-10-18 01:19:17	131	81	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.	Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo. Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.	\N
28	8	2020-09-27 00:46:03	2020-02-04 22:55:49	76	8	Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.	Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.	\N
29	2	2020-03-03 06:16:29	2020-11-01 22:43:01	416	154	Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.	Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue.	\N
30	1	2020-10-08 22:20:42	2020-09-24 21:08:07	895	154	Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.	Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque. Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus. In sagittis dui vel nisl. Duis ac nibh.	\N
31	11	2020-07-28 08:03:15	2020-07-07 03:18:42	230	116	Phasellus in felis. Donec semper sapien a libero. Nam dui.	Duis mattis egestas metus. Aenean fermentum. Donec ut mauris eget massa tempor convallis.	\N
32	13	2020-11-07 23:04:18	2020-09-02 00:31:32	788	57	Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.	Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem. Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat.	\N
33	13	2020-01-12 18:40:58	2020-05-27 13:35:21	583	93	Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.	Vivamus tortor. Duis mattis egestas metus. Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh. Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros. Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue.	\N
34	7	2020-06-27 13:51:49	2020-01-24 08:42:38	280	114	Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.	Morbi non quam nec dui luctus rutrum. Nulla tellus. In sagittis dui vel nisl. Duis ac nibh.	\N
35	5	2020-10-16 16:14:27	2020-02-02 05:12:28	252	134	Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.	Morbi non quam nec dui luctus rutrum. Nulla tellus.	\N
36	5	2020-01-21 02:26:21	2020-03-15 23:14:32	459	142	Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.	Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem. Fusce consequat.	\N
37	11	2020-12-06 20:55:08	2020-12-25 13:07:05	518	53	Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.	Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.	\N
38	9	2020-07-15 20:07:22	2020-03-21 19:30:14	373	12	Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.	Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem. Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus. Pellentesque at nulla. Suspendisse potenti.	\N
39	2	2020-02-20 04:34:33	2020-03-25 10:25:30	970	184	Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.	Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.	\N
40	12	2020-09-29 08:21:43	2020-01-23 19:52:35	787	102	Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.	Curabitur gravida nisi at nibh.	\N
41	12	2020-12-30 10:09:33	2020-08-03 20:02:42	166	69	Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.	Morbi ut odio.	\N
42	3	2020-03-03 00:05:42	2020-11-17 19:44:20	421	181	Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.	Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi. Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus. Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.	\N
43	2	2020-01-11 14:41:22	2020-07-11 00:59:00	292	100	Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.	Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus. Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero. Nullam sit amet turpis elementum ligula vehicula consequat.	\N
44	10	2020-05-20 08:13:05	2020-03-03 06:46:16	386	54	Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.	Donec vitae nisi.	\N
45	3	2020-08-15 13:55:53	2020-02-14 20:44:47	163	169	In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.	Morbi non quam nec dui luctus rutrum. Nulla tellus.	\N
46	3	2020-02-08 05:18:41	2020-09-15 00:54:06	842	89	Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.	Morbi vel lectus in quam fringilla rhoncus. Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero. Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum.	\N
47	9	2020-10-05 11:46:26	2020-04-27 04:13:40	569	105	Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.	Curabitur convallis.	\N
48	1	2020-05-14 07:58:23	2020-09-08 08:56:19	956	12	Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.	Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat. Praesent blandit. Nam nulla.	\N
49	1	2021-01-05 02:42:25	2020-09-18 15:21:43	247	32	Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.	Duis at velit eu est congue elementum.	\N
50	10	2020-04-03 09:39:05	2020-10-01 10:06:57	624	150	Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.	Suspendisse potenti. Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris. Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.	\N
51	7	2020-11-09 07:35:18	2020-04-28 10:46:50	581	27	Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.	Nulla ut erat id mauris vulputate elementum. Nullam varius.	\N
52	1	2020-01-23 05:06:31	2020-01-30 05:39:10	270	130	Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.	Sed ante. Vivamus tortor. Duis mattis egestas metus. Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh. Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros. Vestibulum ac est lacinia nisi venenatis tristique.	\N
53	12	2020-09-05 16:46:33	2020-03-05 14:15:33	81	127	Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.	In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.	\N
54	2	2020-12-11 04:39:36	2020-09-18 03:05:21	794	55	Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.	Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum. Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy.	\N
55	9	2020-08-24 09:33:26	2020-01-13 17:25:01	582	13	Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.	Nulla tempus.	\N
56	7	2020-09-24 05:22:40	2020-01-26 03:44:27	312	131	Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.	Fusce consequat. Nulla nisl. Nunc nisl. Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum. In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo. Aliquam quis turpis eget elit sodales scelerisque.	\N
\.


--
-- Data for Name: question_tag; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.question_tag (question_id, tag_id) FROM stdin;
50	2
48	9
22	3
19	8
20	4
26	9
41	9
15	4
48	4
47	8
14	6
44	3
28	8
8	4
38	8
39	7
24	8
16	2
20	4
40	4
31	1
7	7
53	8
28	2
21	8
36	4
32	3
45	6
47	5
7	2
11	7
16	8
34	3
17	3
21	2
13	3
23	9
17	1
29	2
27	2
36	1
21	8
19	1
34	7
21	1
56	8
8	4
41	5
10	8
21	8
\.


--
-- Data for Name: tag; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tag (tag_id, tag_name) FROM stdin;
1	css
2	html
3	java
4	python
5	C++
6	C#
7	Ract
8	Java
9	JavaScript
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (user_id, user_name, email, password, register_date, reputation, picture) FROM stdin;
4	Mannie Giovannazzi	mgiovannazzi0@state.tx.us	61b198be1288b1ab7e9e02e0cad6d708	2020-06-25 00:01:50	0	default_user.jpg
5	Haley Miettinen	hmiettinen1@mashable.com	452c76d4c38458bf6e9107decf1c3f41	2020-06-27 20:14:17	0	default_user.jpg
6	Ellis Cramphorn	ecramphorn2@4shared.com	8578b9c6fd20463a3ffff5755fd2e5c0	2020-01-23 10:39:10	0	default_user.jpg
7	Bobbye Retter	bretter3@amazon.co.jp	ee715110c562c976d14d99dc8bc34f45	2020-10-18 15:34:59	0	default_user.jpg
8	Noel Smithson	nsmithson4@baidu.com	6068d215ed9adebe5334fd84ff0bfc9c	2020-04-20 09:45:36	0	default_user.jpg
9	Ginelle Clay	gclay5@businessweek.com	b5b2b9a155c2741e3443c44bf8357399	2021-01-08 01:20:04	0	default_user.jpg
10	Hammad Kopelman	hkopelman6@shareasale.com	a4676b9e377178cb98ae007f91afad2b	2020-03-09 22:37:33	0	default_user.jpg
11	Bronson Horsley	bhorsley7@state.gov	dfac6f45ebae93b3fd3174231bee74e8	2020-11-22 00:39:04	0	default_user.jpg
12	Ravi Parradice	rparradice8@google.nl	07384ce657d2f53035dc3260caee48b4	2020-11-04 06:20:16	0	default_user.jpg
13	Robinette Barradell	rbarradell9@4shared.com	642b59c71cdf686c2d74f10905743ab0	2020-09-16 23:19:29	0	default_user.jpg
2	Griswold Neachell	gneachell0@weather.com	0f85c84e9f362fbb3461b47ae448dd1b	2020-01-15 07:09:43	0	default_user.jpg
3	Lindon Fruchter	lfruchter1@sfgate.com	3ba8d207963c6c00c847b220c597b369	2020-11-16 03:25:31	0	default_user.jpg
14	John Nowak	jogh@wp.pl	qwewfsgdfsfdcsf	2021-01-08 01:20:04	0	default_user.jpg
15	Test	email@wp.pl	dsdfsddf	2021-01-08 01:20:04	0	default_user.jpg
1	luq	chhange@wp.pl	root	2017-05-02 16:55:00	0	default_user.jpg
16	Next User	change@wp.pl	sdfsdgdgdrgdg	2020-04-20 09:45:36	0	default_user.jpg
17	Next with time	new@wp.pl	sdfsdgdgdrgdg	2021-01-13 19:22:50	0	default_user.jpg
18	laszlo	laszlo@hu.pl	$2b$12$Obate92rVtxQFFKrpKdS6ucbOKjewyUjJ24qGnds1D2E78ubOm0Gq	2021-01-13 22:36:57	0	default_user.jpg
21	new user hahah	new_user@wpa.pl	$2b$12$M2EjJtkAfKcG6tANOVtnW.4Lwp1hXFk1Z7XvBpzPEyXfHMM8Qx1Da	2021-01-14 10:52:36	0	default_user.jpg
\.


--
-- Name: answer_answer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.answer_answer_id_seq', 100, true);


--
-- Name: comment_comment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.comment_comment_id_seq', 50, true);


--
-- Name: question_question_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.question_question_id_seq', 56, true);


--
-- Name: tag_tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tag_tag_id_seq', 9, true);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_user_id_seq', 21, true);


--
-- Name: answer answer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answer
    ADD CONSTRAINT answer_pkey PRIMARY KEY (answer_id);


--
-- Name: comment comment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_pkey PRIMARY KEY (comment_id);


--
-- Name: question question_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question
    ADD CONSTRAINT question_pkey PRIMARY KEY (question_id);


--
-- Name: tag tag_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tag
    ADD CONSTRAINT tag_pkey PRIMARY KEY (tag_id);


--
-- Name: users unique_email; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT unique_email UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: comment answer_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT answer_id FOREIGN KEY (answer_id) REFERENCES public.answer(answer_id);


--
-- Name: answer question_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answer
    ADD CONSTRAINT question_id FOREIGN KEY (question_id) REFERENCES public.question(question_id);


--
-- Name: question_tag question_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question_tag
    ADD CONSTRAINT question_id FOREIGN KEY (question_id) REFERENCES public.question(question_id);


--
-- Name: comment question_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT question_id FOREIGN KEY (question_id) REFERENCES public.question(question_id);


--
-- Name: question question_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question
    ADD CONSTRAINT question_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: question_tag tag_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question_tag
    ADD CONSTRAINT tag_id FOREIGN KEY (tag_id) REFERENCES public.tag(tag_id);


--
-- Name: comment user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT user_id FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- PostgreSQL database dump complete
--

