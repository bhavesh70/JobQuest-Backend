--
-- PostgreSQL database dump
--

-- Dumped from database version 15.3
-- Dumped by pg_dump version 15.3

-- Started on 2023-11-13 12:12:19 IST

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
-- TOC entry 895 (class 1247 OID 19265)
-- Name: application_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.application_status AS ENUM (
    'Applied',
    'Under_Review',
    'Shortlisted',
    'In_Progress',
    'Selected',
    'Rejected'
);


ALTER TYPE public.application_status OWNER TO postgres;

--
-- TOC entry 871 (class 1247 OID 19110)
-- Name: location_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.location_type AS ENUM (
    'Remote',
    'Hybrid',
    'On_Site'
);


ALTER TYPE public.location_type OWNER TO postgres;

--
-- TOC entry 861 (class 1247 OID 19080)
-- Name: phone_number; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN public.phone_number AS character varying(10)
	CONSTRAINT phone_number_check CHECK (((VALUE)::text ~ '^[0-9]{10}$'::text));


ALTER DOMAIN public.phone_number OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 231 (class 1259 OID 19249)
-- Name: applicant_skills; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.applicant_skills (
    applicant_id integer NOT NULL,
    skill_id integer NOT NULL
);


ALTER TABLE public.applicant_skills OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 19194)
-- Name: applicants; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.applicants (
    id integer NOT NULL,
    first_name text NOT NULL,
    last_name text NOT NULL,
    phone_number public.phone_number NOT NULL,
    email text NOT NULL,
    password text NOT NULL,
    resume_id integer
);


ALTER TABLE public.applicants OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 19193)
-- Name: applicants_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.applicants_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.applicants_id_seq OWNER TO postgres;

--
-- TOC entry 3761 (class 0 OID 0)
-- Dependencies: 227
-- Name: applicants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.applicants_id_seq OWNED BY public.applicants.id;


--
-- TOC entry 233 (class 1259 OID 19291)
-- Name: applications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.applications (
    id integer NOT NULL,
    applicant_id integer NOT NULL,
    recruiter_id integer NOT NULL,
    job_id integer NOT NULL,
    resume_id integer NOT NULL,
    status public.application_status DEFAULT 'Applied'::public.application_status,
    date_of_applied date NOT NULL,
    date_of_join date
);


ALTER TABLE public.applications OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 19290)
-- Name: applications_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.applications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.applications_id_seq OWNER TO postgres;

--
-- TOC entry 3762 (class 0 OID 0)
-- Dependencies: 232
-- Name: applications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.applications_id_seq OWNED BY public.applications.id;


--
-- TOC entry 224 (class 1259 OID 19150)
-- Name: colleges; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.colleges (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.colleges OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 19149)
-- Name: college_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.college_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.college_id_seq OWNER TO postgres;

--
-- TOC entry 3763 (class 0 OID 0)
-- Dependencies: 223
-- Name: college_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.college_id_seq OWNED BY public.colleges.id;


--
-- TOC entry 215 (class 1259 OID 19067)
-- Name: companies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.companies (
    id integer NOT NULL,
    name text NOT NULL,
    description text,
    website_link text
);


ALTER TABLE public.companies OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 19066)
-- Name: companies_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.companies_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.companies_id_seq OWNER TO postgres;

--
-- TOC entry 3764 (class 0 OID 0)
-- Dependencies: 214
-- Name: companies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.companies_id_seq OWNED BY public.companies.id;


--
-- TOC entry 230 (class 1259 OID 19218)
-- Name: degrees; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.degrees (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.degrees OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 19217)
-- Name: degrees_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.degrees_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.degrees_id_seq OWNER TO postgres;

--
-- TOC entry 3765 (class 0 OID 0)
-- Dependencies: 229
-- Name: degrees_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.degrees_id_seq OWNED BY public.degrees.id;


--
-- TOC entry 235 (class 1259 OID 19380)
-- Name: educations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.educations (
    id integer NOT NULL,
    college_id integer NOT NULL,
    degree_id integer NOT NULL,
    college_start_date date NOT NULL,
    college_end_date date NOT NULL,
    applicant_id integer NOT NULL
);


ALTER TABLE public.educations OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 19379)
-- Name: educations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.educations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.educations_id_seq OWNER TO postgres;

--
-- TOC entry 3766 (class 0 OID 0)
-- Dependencies: 234
-- Name: educations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.educations_id_seq OWNED BY public.educations.id;


--
-- TOC entry 222 (class 1259 OID 19134)
-- Name: job_skills; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.job_skills (
    job_id integer NOT NULL,
    skill_id integer NOT NULL
);


ALTER TABLE public.job_skills OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 19118)
-- Name: jobs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.jobs (
    id integer NOT NULL,
    title text NOT NULL,
    job_type text NOT NULL,
    year_of_experience integer DEFAULT 0,
    ctc real NOT NULL,
    date_of_posting timestamp without time zone NOT NULL,
    deadline timestamp without time zone NOT NULL,
    location_type public.location_type DEFAULT 'Remote'::public.location_type NOT NULL,
    location text,
    recruiter_id integer NOT NULL,
    description text,
    CONSTRAINT jobs_year_of_experience_check CHECK (((year_of_experience >= 0) AND (year_of_experience <= 30)))
);


ALTER TABLE public.jobs OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 19117)
-- Name: jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.jobs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.jobs_id_seq OWNER TO postgres;

--
-- TOC entry 3767 (class 0 OID 0)
-- Dependencies: 220
-- Name: jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.jobs_id_seq OWNED BY public.jobs.id;


--
-- TOC entry 217 (class 1259 OID 19083)
-- Name: recruiters; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.recruiters (
    id integer NOT NULL,
    first_name text NOT NULL,
    last_name text NOT NULL,
    phone_number public.phone_number NOT NULL,
    email text NOT NULL,
    password text NOT NULL,
    company_id integer NOT NULL
);


ALTER TABLE public.recruiters OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 19082)
-- Name: recruiters_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.recruiters_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.recruiters_id_seq OWNER TO postgres;

--
-- TOC entry 3768 (class 0 OID 0)
-- Dependencies: 216
-- Name: recruiters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.recruiters_id_seq OWNED BY public.recruiters.id;


--
-- TOC entry 226 (class 1259 OID 19161)
-- Name: resumes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resumes (
    id integer NOT NULL,
    pdf text NOT NULL
);


ALTER TABLE public.resumes OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 19160)
-- Name: resumes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.resumes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.resumes_id_seq OWNER TO postgres;

--
-- TOC entry 3769 (class 0 OID 0)
-- Dependencies: 225
-- Name: resumes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.resumes_id_seq OWNED BY public.resumes.id;


--
-- TOC entry 219 (class 1259 OID 19099)
-- Name: skills; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.skills (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.skills OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 19098)
-- Name: skills_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.skills_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.skills_id_seq OWNER TO postgres;

--
-- TOC entry 3770 (class 0 OID 0)
-- Dependencies: 218
-- Name: skills_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.skills_id_seq OWNED BY public.skills.id;


--
-- TOC entry 3532 (class 2604 OID 19197)
-- Name: applicants id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.applicants ALTER COLUMN id SET DEFAULT nextval('public.applicants_id_seq'::regclass);


--
-- TOC entry 3534 (class 2604 OID 19294)
-- Name: applications id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.applications ALTER COLUMN id SET DEFAULT nextval('public.applications_id_seq'::regclass);


--
-- TOC entry 3530 (class 2604 OID 19153)
-- Name: colleges id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.colleges ALTER COLUMN id SET DEFAULT nextval('public.college_id_seq'::regclass);


--
-- TOC entry 3524 (class 2604 OID 19070)
-- Name: companies id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.companies ALTER COLUMN id SET DEFAULT nextval('public.companies_id_seq'::regclass);


--
-- TOC entry 3533 (class 2604 OID 19221)
-- Name: degrees id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.degrees ALTER COLUMN id SET DEFAULT nextval('public.degrees_id_seq'::regclass);


--
-- TOC entry 3536 (class 2604 OID 19383)
-- Name: educations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.educations ALTER COLUMN id SET DEFAULT nextval('public.educations_id_seq'::regclass);


--
-- TOC entry 3527 (class 2604 OID 19121)
-- Name: jobs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobs ALTER COLUMN id SET DEFAULT nextval('public.jobs_id_seq'::regclass);


--
-- TOC entry 3525 (class 2604 OID 19086)
-- Name: recruiters id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recruiters ALTER COLUMN id SET DEFAULT nextval('public.recruiters_id_seq'::regclass);


--
-- TOC entry 3531 (class 2604 OID 19164)
-- Name: resumes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resumes ALTER COLUMN id SET DEFAULT nextval('public.resumes_id_seq'::regclass);


--
-- TOC entry 3526 (class 2604 OID 19102)
-- Name: skills id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.skills ALTER COLUMN id SET DEFAULT nextval('public.skills_id_seq'::regclass);


--
-- TOC entry 3751 (class 0 OID 19249)
-- Dependencies: 231
-- Data for Name: applicant_skills; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.applicant_skills (applicant_id, skill_id) FROM stdin;
1	1
1	2
1	3
\.


--
-- TOC entry 3748 (class 0 OID 19194)
-- Dependencies: 228
-- Data for Name: applicants; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.applicants (id, first_name, last_name, phone_number, email, password, resume_id) FROM stdin;
1	Bhavesh	Purswani	8866624082	bhaveshpurswani10@gmail.com	AbraKaDabra	1
\.


--
-- TOC entry 3753 (class 0 OID 19291)
-- Dependencies: 233
-- Data for Name: applications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.applications (id, applicant_id, recruiter_id, job_id, resume_id, status, date_of_applied, date_of_join) FROM stdin;
\.


--
-- TOC entry 3744 (class 0 OID 19150)
-- Dependencies: 224
-- Data for Name: colleges; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.colleges (id, name) FROM stdin;
1	DAIICT
\.


--
-- TOC entry 3735 (class 0 OID 19067)
-- Dependencies: 215
-- Data for Name: companies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.companies (id, name, description, website_link) FROM stdin;
\.


--
-- TOC entry 3750 (class 0 OID 19218)
-- Dependencies: 230
-- Data for Name: degrees; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.degrees (id, name) FROM stdin;
1	Btech-ICT
\.


--
-- TOC entry 3755 (class 0 OID 19380)
-- Dependencies: 235
-- Data for Name: educations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.educations (id, college_id, degree_id, college_start_date, college_end_date, applicant_id) FROM stdin;
1	1	1	2020-09-01	2024-05-30	1
\.


--
-- TOC entry 3742 (class 0 OID 19134)
-- Dependencies: 222
-- Data for Name: job_skills; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.job_skills (job_id, skill_id) FROM stdin;
\.


--
-- TOC entry 3741 (class 0 OID 19118)
-- Dependencies: 221
-- Data for Name: jobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.jobs (id, title, job_type, year_of_experience, ctc, date_of_posting, deadline, location_type, location, recruiter_id, description) FROM stdin;
\.


--
-- TOC entry 3737 (class 0 OID 19083)
-- Dependencies: 217
-- Data for Name: recruiters; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.recruiters (id, first_name, last_name, phone_number, email, password, company_id) FROM stdin;
\.


--
-- TOC entry 3746 (class 0 OID 19161)
-- Dependencies: 226
-- Data for Name: resumes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resumes (id, pdf) FROM stdin;
1	hello.pdf
\.


--
-- TOC entry 3739 (class 0 OID 19099)
-- Dependencies: 219
-- Data for Name: skills; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.skills (id, name) FROM stdin;
1	java
2	c++
3	python
\.


--
-- TOC entry 3771 (class 0 OID 0)
-- Dependencies: 227
-- Name: applicants_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.applicants_id_seq', 1, false);


--
-- TOC entry 3772 (class 0 OID 0)
-- Dependencies: 232
-- Name: applications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.applications_id_seq', 1, false);


--
-- TOC entry 3773 (class 0 OID 0)
-- Dependencies: 223
-- Name: college_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.college_id_seq', 1, false);


--
-- TOC entry 3774 (class 0 OID 0)
-- Dependencies: 214
-- Name: companies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.companies_id_seq', 1, false);


--
-- TOC entry 3775 (class 0 OID 0)
-- Dependencies: 229
-- Name: degrees_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.degrees_id_seq', 1, false);


--
-- TOC entry 3776 (class 0 OID 0)
-- Dependencies: 234
-- Name: educations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.educations_id_seq', 1, false);


--
-- TOC entry 3777 (class 0 OID 0)
-- Dependencies: 220
-- Name: jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.jobs_id_seq', 1, false);


--
-- TOC entry 3778 (class 0 OID 0)
-- Dependencies: 216
-- Name: recruiters_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.recruiters_id_seq', 1, false);


--
-- TOC entry 3779 (class 0 OID 0)
-- Dependencies: 225
-- Name: resumes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.resumes_id_seq', 1, false);


--
-- TOC entry 3780 (class 0 OID 0)
-- Dependencies: 218
-- Name: skills_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.skills_id_seq', 1, false);


--
-- TOC entry 3573 (class 2606 OID 19253)
-- Name: applicant_skills applicant_skills_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.applicant_skills
    ADD CONSTRAINT applicant_skills_pkey PRIMARY KEY (applicant_id, skill_id);


--
-- TOC entry 3563 (class 2606 OID 19203)
-- Name: applicants applicants_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.applicants
    ADD CONSTRAINT applicants_email_key UNIQUE (email);


--
-- TOC entry 3565 (class 2606 OID 19201)
-- Name: applicants applicants_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.applicants
    ADD CONSTRAINT applicants_pkey PRIMARY KEY (id);


--
-- TOC entry 3567 (class 2606 OID 19205)
-- Name: applicants applicants_resume_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.applicants
    ADD CONSTRAINT applicants_resume_id_key UNIQUE (resume_id);


--
-- TOC entry 3575 (class 2606 OID 19297)
-- Name: applications applications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.applications
    ADD CONSTRAINT applications_pkey PRIMARY KEY (id);


--
-- TOC entry 3555 (class 2606 OID 19159)
-- Name: colleges college_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.colleges
    ADD CONSTRAINT college_name_key UNIQUE (name);


--
-- TOC entry 3557 (class 2606 OID 19157)
-- Name: colleges college_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.colleges
    ADD CONSTRAINT college_pkey PRIMARY KEY (id);


--
-- TOC entry 3539 (class 2606 OID 19076)
-- Name: companies companies_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.companies
    ADD CONSTRAINT companies_name_key UNIQUE (name);


--
-- TOC entry 3541 (class 2606 OID 19072)
-- Name: companies companies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.companies
    ADD CONSTRAINT companies_pkey PRIMARY KEY (id);


--
-- TOC entry 3569 (class 2606 OID 19227)
-- Name: degrees degrees_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.degrees
    ADD CONSTRAINT degrees_name_key UNIQUE (name);


--
-- TOC entry 3571 (class 2606 OID 19225)
-- Name: degrees degrees_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.degrees
    ADD CONSTRAINT degrees_pkey PRIMARY KEY (id);


--
-- TOC entry 3577 (class 2606 OID 19385)
-- Name: educations educations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.educations
    ADD CONSTRAINT educations_pkey PRIMARY KEY (id);


--
-- TOC entry 3553 (class 2606 OID 19138)
-- Name: job_skills job_skills_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_skills
    ADD CONSTRAINT job_skills_pkey PRIMARY KEY (job_id, skill_id);


--
-- TOC entry 3551 (class 2606 OID 19128)
-- Name: jobs jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);


--
-- TOC entry 3543 (class 2606 OID 19092)
-- Name: recruiters recruiters_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recruiters
    ADD CONSTRAINT recruiters_email_key UNIQUE (email);


--
-- TOC entry 3545 (class 2606 OID 19090)
-- Name: recruiters recruiters_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recruiters
    ADD CONSTRAINT recruiters_pkey PRIMARY KEY (id);


--
-- TOC entry 3559 (class 2606 OID 19170)
-- Name: resumes resumes_pdf_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resumes
    ADD CONSTRAINT resumes_pdf_key UNIQUE (pdf);


--
-- TOC entry 3561 (class 2606 OID 19168)
-- Name: resumes resumes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resumes
    ADD CONSTRAINT resumes_pkey PRIMARY KEY (id);


--
-- TOC entry 3547 (class 2606 OID 19108)
-- Name: skills skills_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.skills
    ADD CONSTRAINT skills_name_key UNIQUE (name);


--
-- TOC entry 3549 (class 2606 OID 19106)
-- Name: skills skills_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.skills
    ADD CONSTRAINT skills_pkey PRIMARY KEY (id);


--
-- TOC entry 3583 (class 2606 OID 19254)
-- Name: applicant_skills applicant_skills_applicant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.applicant_skills
    ADD CONSTRAINT applicant_skills_applicant_id_fkey FOREIGN KEY (applicant_id) REFERENCES public.applicants(id);


--
-- TOC entry 3584 (class 2606 OID 19259)
-- Name: applicant_skills applicant_skills_skill_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.applicant_skills
    ADD CONSTRAINT applicant_skills_skill_id_fkey FOREIGN KEY (skill_id) REFERENCES public.skills(id);


--
-- TOC entry 3582 (class 2606 OID 19211)
-- Name: applicants applicants_resume_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.applicants
    ADD CONSTRAINT applicants_resume_id_fkey FOREIGN KEY (resume_id) REFERENCES public.resumes(id);


--
-- TOC entry 3585 (class 2606 OID 19298)
-- Name: applications applications_applicant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.applications
    ADD CONSTRAINT applications_applicant_id_fkey FOREIGN KEY (applicant_id) REFERENCES public.applicants(id);


--
-- TOC entry 3586 (class 2606 OID 19308)
-- Name: applications applications_job_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.applications
    ADD CONSTRAINT applications_job_id_fkey FOREIGN KEY (job_id) REFERENCES public.jobs(id);


--
-- TOC entry 3587 (class 2606 OID 19303)
-- Name: applications applications_recruiter_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.applications
    ADD CONSTRAINT applications_recruiter_id_fkey FOREIGN KEY (recruiter_id) REFERENCES public.recruiters(id);


--
-- TOC entry 3588 (class 2606 OID 19313)
-- Name: applications applications_resume_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.applications
    ADD CONSTRAINT applications_resume_id_fkey FOREIGN KEY (resume_id) REFERENCES public.resumes(id);


--
-- TOC entry 3589 (class 2606 OID 19396)
-- Name: educations educations_applicant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.educations
    ADD CONSTRAINT educations_applicant_id_fkey FOREIGN KEY (applicant_id) REFERENCES public.applicants(id);


--
-- TOC entry 3590 (class 2606 OID 19386)
-- Name: educations educations_college_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.educations
    ADD CONSTRAINT educations_college_id_fkey FOREIGN KEY (college_id) REFERENCES public.colleges(id);


--
-- TOC entry 3591 (class 2606 OID 19391)
-- Name: educations educations_degree_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.educations
    ADD CONSTRAINT educations_degree_id_fkey FOREIGN KEY (degree_id) REFERENCES public.degrees(id);


--
-- TOC entry 3580 (class 2606 OID 19139)
-- Name: job_skills job_skills_job_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_skills
    ADD CONSTRAINT job_skills_job_id_fkey FOREIGN KEY (job_id) REFERENCES public.jobs(id);


--
-- TOC entry 3581 (class 2606 OID 19144)
-- Name: job_skills job_skills_skill_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_skills
    ADD CONSTRAINT job_skills_skill_id_fkey FOREIGN KEY (skill_id) REFERENCES public.skills(id);


--
-- TOC entry 3579 (class 2606 OID 19129)
-- Name: jobs jobs_recruiter_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_recruiter_id_fkey FOREIGN KEY (recruiter_id) REFERENCES public.recruiters(id);


--
-- TOC entry 3578 (class 2606 OID 19093)
-- Name: recruiters recruiters_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recruiters
    ADD CONSTRAINT recruiters_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.companies(id);


-- Completed on 2023-11-13 12:12:20 IST

--
-- PostgreSQL database dump complete
--

