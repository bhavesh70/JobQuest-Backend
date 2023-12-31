toc.dat                                                                                             0000600 0004000 0002000 00000074734 14524343167 0014467 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        PGDMP                       
    {            jobquest    15.3    15.3 i    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false         �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false         �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false         �           1262    19065    jobquest    DATABASE     �   CREATE DATABASE jobquest WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = icu LOCALE = 'en_US.UTF-8' ICU_LOCALE = 'en-US';
    DROP DATABASE jobquest;
                postgres    false                    1247    19265    application_status    TYPE     �   CREATE TYPE public.application_status AS ENUM (
    'Applied',
    'Under_Review',
    'Shortlisted',
    'In_Progress',
    'Selected',
    'Rejected'
);
 %   DROP TYPE public.application_status;
       public          postgres    false         g           1247    19110    location_type    TYPE     X   CREATE TYPE public.location_type AS ENUM (
    'Remote',
    'Hybrid',
    'On_Site'
);
     DROP TYPE public.location_type;
       public          postgres    false         ]           1247    19080    phone_number    DOMAIN     �   CREATE DOMAIN public.phone_number AS character varying(10)
	CONSTRAINT phone_number_check CHECK (((VALUE)::text ~ '^[0-9]{10}$'::text));
 !   DROP DOMAIN public.phone_number;
       public          postgres    false         �            1259    19249    applicant_skills    TABLE     k   CREATE TABLE public.applicant_skills (
    applicant_id integer NOT NULL,
    skill_id integer NOT NULL
);
 $   DROP TABLE public.applicant_skills;
       public         heap    postgres    false         �            1259    19194 
   applicants    TABLE     �   CREATE TABLE public.applicants (
    id integer NOT NULL,
    first_name text NOT NULL,
    last_name text NOT NULL,
    phone_number public.phone_number NOT NULL,
    email text NOT NULL,
    password text NOT NULL,
    resume_id integer
);
    DROP TABLE public.applicants;
       public         heap    postgres    false    861         �            1259    19193    applicants_id_seq    SEQUENCE     �   CREATE SEQUENCE public.applicants_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.applicants_id_seq;
       public          postgres    false    228         �           0    0    applicants_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.applicants_id_seq OWNED BY public.applicants.id;
          public          postgres    false    227         �            1259    19291    applications    TABLE     N  CREATE TABLE public.applications (
    id integer NOT NULL,
    applicant_id integer NOT NULL,
    recruiter_id integer NOT NULL,
    job_id integer NOT NULL,
    resume_id integer NOT NULL,
    status public.application_status DEFAULT 'Applied'::public.application_status,
    date_of_applied date NOT NULL,
    date_of_join date
);
     DROP TABLE public.applications;
       public         heap    postgres    false    895    895         �            1259    19290    applications_id_seq    SEQUENCE     �   CREATE SEQUENCE public.applications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.applications_id_seq;
       public          postgres    false    233         �           0    0    applications_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.applications_id_seq OWNED BY public.applications.id;
          public          postgres    false    232         �            1259    19150    colleges    TABLE     R   CREATE TABLE public.colleges (
    id integer NOT NULL,
    name text NOT NULL
);
    DROP TABLE public.colleges;
       public         heap    postgres    false         �            1259    19149    college_id_seq    SEQUENCE     �   CREATE SEQUENCE public.college_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.college_id_seq;
       public          postgres    false    224         �           0    0    college_id_seq    SEQUENCE OWNED BY     B   ALTER SEQUENCE public.college_id_seq OWNED BY public.colleges.id;
          public          postgres    false    223         �            1259    19067 	   companies    TABLE     �   CREATE TABLE public.companies (
    id integer NOT NULL,
    name text NOT NULL,
    description text,
    website_link text
);
    DROP TABLE public.companies;
       public         heap    postgres    false         �            1259    19066    companies_id_seq    SEQUENCE     �   CREATE SEQUENCE public.companies_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.companies_id_seq;
       public          postgres    false    215         �           0    0    companies_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.companies_id_seq OWNED BY public.companies.id;
          public          postgres    false    214         �            1259    19218    degrees    TABLE     Q   CREATE TABLE public.degrees (
    id integer NOT NULL,
    name text NOT NULL
);
    DROP TABLE public.degrees;
       public         heap    postgres    false         �            1259    19217    degrees_id_seq    SEQUENCE     �   CREATE SEQUENCE public.degrees_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.degrees_id_seq;
       public          postgres    false    230         �           0    0    degrees_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.degrees_id_seq OWNED BY public.degrees.id;
          public          postgres    false    229         �            1259    19380 
   educations    TABLE     �   CREATE TABLE public.educations (
    id integer NOT NULL,
    college_id integer NOT NULL,
    degree_id integer NOT NULL,
    college_start_date date NOT NULL,
    college_end_date date NOT NULL,
    applicant_id integer NOT NULL
);
    DROP TABLE public.educations;
       public         heap    postgres    false         �            1259    19379    educations_id_seq    SEQUENCE     �   CREATE SEQUENCE public.educations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.educations_id_seq;
       public          postgres    false    235         �           0    0    educations_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.educations_id_seq OWNED BY public.educations.id;
          public          postgres    false    234         �            1259    19134 
   job_skills    TABLE     _   CREATE TABLE public.job_skills (
    job_id integer NOT NULL,
    skill_id integer NOT NULL
);
    DROP TABLE public.job_skills;
       public         heap    postgres    false         �            1259    19118    jobs    TABLE     .  CREATE TABLE public.jobs (
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
    DROP TABLE public.jobs;
       public         heap    postgres    false    871    871         �            1259    19117    jobs_id_seq    SEQUENCE     �   CREATE SEQUENCE public.jobs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.jobs_id_seq;
       public          postgres    false    221         �           0    0    jobs_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE public.jobs_id_seq OWNED BY public.jobs.id;
          public          postgres    false    220         �            1259    19083 
   recruiters    TABLE     �   CREATE TABLE public.recruiters (
    id integer NOT NULL,
    first_name text NOT NULL,
    last_name text NOT NULL,
    phone_number public.phone_number NOT NULL,
    email text NOT NULL,
    password text NOT NULL,
    company_id integer NOT NULL
);
    DROP TABLE public.recruiters;
       public         heap    postgres    false    861         �            1259    19082    recruiters_id_seq    SEQUENCE     �   CREATE SEQUENCE public.recruiters_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.recruiters_id_seq;
       public          postgres    false    217         �           0    0    recruiters_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.recruiters_id_seq OWNED BY public.recruiters.id;
          public          postgres    false    216         �            1259    19161    resumes    TABLE     P   CREATE TABLE public.resumes (
    id integer NOT NULL,
    pdf text NOT NULL
);
    DROP TABLE public.resumes;
       public         heap    postgres    false         �            1259    19160    resumes_id_seq    SEQUENCE     �   CREATE SEQUENCE public.resumes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.resumes_id_seq;
       public          postgres    false    226         �           0    0    resumes_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.resumes_id_seq OWNED BY public.resumes.id;
          public          postgres    false    225         �            1259    19099    skills    TABLE     P   CREATE TABLE public.skills (
    id integer NOT NULL,
    name text NOT NULL
);
    DROP TABLE public.skills;
       public         heap    postgres    false         �            1259    19098    skills_id_seq    SEQUENCE     �   CREATE SEQUENCE public.skills_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.skills_id_seq;
       public          postgres    false    219         �           0    0    skills_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.skills_id_seq OWNED BY public.skills.id;
          public          postgres    false    218         �           2604    19197    applicants id    DEFAULT     n   ALTER TABLE ONLY public.applicants ALTER COLUMN id SET DEFAULT nextval('public.applicants_id_seq'::regclass);
 <   ALTER TABLE public.applicants ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    227    228    228         �           2604    19294    applications id    DEFAULT     r   ALTER TABLE ONLY public.applications ALTER COLUMN id SET DEFAULT nextval('public.applications_id_seq'::regclass);
 >   ALTER TABLE public.applications ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    232    233    233         �           2604    19153    colleges id    DEFAULT     i   ALTER TABLE ONLY public.colleges ALTER COLUMN id SET DEFAULT nextval('public.college_id_seq'::regclass);
 :   ALTER TABLE public.colleges ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    224    223    224         �           2604    19070    companies id    DEFAULT     l   ALTER TABLE ONLY public.companies ALTER COLUMN id SET DEFAULT nextval('public.companies_id_seq'::regclass);
 ;   ALTER TABLE public.companies ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    215    214    215         �           2604    19221 
   degrees id    DEFAULT     h   ALTER TABLE ONLY public.degrees ALTER COLUMN id SET DEFAULT nextval('public.degrees_id_seq'::regclass);
 9   ALTER TABLE public.degrees ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    229    230    230         �           2604    19383    educations id    DEFAULT     n   ALTER TABLE ONLY public.educations ALTER COLUMN id SET DEFAULT nextval('public.educations_id_seq'::regclass);
 <   ALTER TABLE public.educations ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    235    234    235         �           2604    19121    jobs id    DEFAULT     b   ALTER TABLE ONLY public.jobs ALTER COLUMN id SET DEFAULT nextval('public.jobs_id_seq'::regclass);
 6   ALTER TABLE public.jobs ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    221    220    221         �           2604    19086    recruiters id    DEFAULT     n   ALTER TABLE ONLY public.recruiters ALTER COLUMN id SET DEFAULT nextval('public.recruiters_id_seq'::regclass);
 <   ALTER TABLE public.recruiters ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    216    217    217         �           2604    19164 
   resumes id    DEFAULT     h   ALTER TABLE ONLY public.resumes ALTER COLUMN id SET DEFAULT nextval('public.resumes_id_seq'::regclass);
 9   ALTER TABLE public.resumes ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    225    226    226         �           2604    19102 	   skills id    DEFAULT     f   ALTER TABLE ONLY public.skills ALTER COLUMN id SET DEFAULT nextval('public.skills_id_seq'::regclass);
 8   ALTER TABLE public.skills ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    218    219    219         �          0    19249    applicant_skills 
   TABLE DATA           B   COPY public.applicant_skills (applicant_id, skill_id) FROM stdin;
    public          postgres    false    231       3751.dat �          0    19194 
   applicants 
   TABLE DATA           i   COPY public.applicants (id, first_name, last_name, phone_number, email, password, resume_id) FROM stdin;
    public          postgres    false    228       3748.dat �          0    19291    applications 
   TABLE DATA           �   COPY public.applications (id, applicant_id, recruiter_id, job_id, resume_id, status, date_of_applied, date_of_join) FROM stdin;
    public          postgres    false    233       3753.dat �          0    19150    colleges 
   TABLE DATA           ,   COPY public.colleges (id, name) FROM stdin;
    public          postgres    false    224       3744.dat �          0    19067 	   companies 
   TABLE DATA           H   COPY public.companies (id, name, description, website_link) FROM stdin;
    public          postgres    false    215       3735.dat �          0    19218    degrees 
   TABLE DATA           +   COPY public.degrees (id, name) FROM stdin;
    public          postgres    false    230       3750.dat �          0    19380 
   educations 
   TABLE DATA           s   COPY public.educations (id, college_id, degree_id, college_start_date, college_end_date, applicant_id) FROM stdin;
    public          postgres    false    235       3755.dat �          0    19134 
   job_skills 
   TABLE DATA           6   COPY public.job_skills (job_id, skill_id) FROM stdin;
    public          postgres    false    222       3742.dat �          0    19118    jobs 
   TABLE DATA           �   COPY public.jobs (id, title, job_type, year_of_experience, ctc, date_of_posting, deadline, location_type, location, recruiter_id, description) FROM stdin;
    public          postgres    false    221       3741.dat �          0    19083 
   recruiters 
   TABLE DATA           j   COPY public.recruiters (id, first_name, last_name, phone_number, email, password, company_id) FROM stdin;
    public          postgres    false    217       3737.dat �          0    19161    resumes 
   TABLE DATA           *   COPY public.resumes (id, pdf) FROM stdin;
    public          postgres    false    226       3746.dat �          0    19099    skills 
   TABLE DATA           *   COPY public.skills (id, name) FROM stdin;
    public          postgres    false    219       3739.dat �           0    0    applicants_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.applicants_id_seq', 1, false);
          public          postgres    false    227         �           0    0    applications_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.applications_id_seq', 1, false);
          public          postgres    false    232         �           0    0    college_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.college_id_seq', 1, false);
          public          postgres    false    223         �           0    0    companies_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.companies_id_seq', 1, false);
          public          postgres    false    214         �           0    0    degrees_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.degrees_id_seq', 1, false);
          public          postgres    false    229         �           0    0    educations_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.educations_id_seq', 1, false);
          public          postgres    false    234         �           0    0    jobs_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.jobs_id_seq', 1, false);
          public          postgres    false    220         �           0    0    recruiters_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.recruiters_id_seq', 1, false);
          public          postgres    false    216         �           0    0    resumes_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.resumes_id_seq', 1, false);
          public          postgres    false    225         �           0    0    skills_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.skills_id_seq', 1, false);
          public          postgres    false    218         �           2606    19253 &   applicant_skills applicant_skills_pkey 
   CONSTRAINT     x   ALTER TABLE ONLY public.applicant_skills
    ADD CONSTRAINT applicant_skills_pkey PRIMARY KEY (applicant_id, skill_id);
 P   ALTER TABLE ONLY public.applicant_skills DROP CONSTRAINT applicant_skills_pkey;
       public            postgres    false    231    231         �           2606    19203    applicants applicants_email_key 
   CONSTRAINT     [   ALTER TABLE ONLY public.applicants
    ADD CONSTRAINT applicants_email_key UNIQUE (email);
 I   ALTER TABLE ONLY public.applicants DROP CONSTRAINT applicants_email_key;
       public            postgres    false    228         �           2606    19201    applicants applicants_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.applicants
    ADD CONSTRAINT applicants_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.applicants DROP CONSTRAINT applicants_pkey;
       public            postgres    false    228         �           2606    19205 #   applicants applicants_resume_id_key 
   CONSTRAINT     c   ALTER TABLE ONLY public.applicants
    ADD CONSTRAINT applicants_resume_id_key UNIQUE (resume_id);
 M   ALTER TABLE ONLY public.applicants DROP CONSTRAINT applicants_resume_id_key;
       public            postgres    false    228         �           2606    19297    applications applications_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.applications
    ADD CONSTRAINT applications_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.applications DROP CONSTRAINT applications_pkey;
       public            postgres    false    233         �           2606    19159    colleges college_name_key 
   CONSTRAINT     T   ALTER TABLE ONLY public.colleges
    ADD CONSTRAINT college_name_key UNIQUE (name);
 C   ALTER TABLE ONLY public.colleges DROP CONSTRAINT college_name_key;
       public            postgres    false    224         �           2606    19157    colleges college_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.colleges
    ADD CONSTRAINT college_pkey PRIMARY KEY (id);
 ?   ALTER TABLE ONLY public.colleges DROP CONSTRAINT college_pkey;
       public            postgres    false    224         �           2606    19076    companies companies_name_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.companies
    ADD CONSTRAINT companies_name_key UNIQUE (name);
 F   ALTER TABLE ONLY public.companies DROP CONSTRAINT companies_name_key;
       public            postgres    false    215         �           2606    19072    companies companies_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.companies
    ADD CONSTRAINT companies_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.companies DROP CONSTRAINT companies_pkey;
       public            postgres    false    215         �           2606    19227    degrees degrees_name_key 
   CONSTRAINT     S   ALTER TABLE ONLY public.degrees
    ADD CONSTRAINT degrees_name_key UNIQUE (name);
 B   ALTER TABLE ONLY public.degrees DROP CONSTRAINT degrees_name_key;
       public            postgres    false    230         �           2606    19225    degrees degrees_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.degrees
    ADD CONSTRAINT degrees_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.degrees DROP CONSTRAINT degrees_pkey;
       public            postgres    false    230         �           2606    19385    educations educations_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.educations
    ADD CONSTRAINT educations_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.educations DROP CONSTRAINT educations_pkey;
       public            postgres    false    235         �           2606    19138    job_skills job_skills_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.job_skills
    ADD CONSTRAINT job_skills_pkey PRIMARY KEY (job_id, skill_id);
 D   ALTER TABLE ONLY public.job_skills DROP CONSTRAINT job_skills_pkey;
       public            postgres    false    222    222         �           2606    19128    jobs jobs_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.jobs DROP CONSTRAINT jobs_pkey;
       public            postgres    false    221         �           2606    19092    recruiters recruiters_email_key 
   CONSTRAINT     [   ALTER TABLE ONLY public.recruiters
    ADD CONSTRAINT recruiters_email_key UNIQUE (email);
 I   ALTER TABLE ONLY public.recruiters DROP CONSTRAINT recruiters_email_key;
       public            postgres    false    217         �           2606    19090    recruiters recruiters_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.recruiters
    ADD CONSTRAINT recruiters_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.recruiters DROP CONSTRAINT recruiters_pkey;
       public            postgres    false    217         �           2606    19170    resumes resumes_pdf_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.resumes
    ADD CONSTRAINT resumes_pdf_key UNIQUE (pdf);
 A   ALTER TABLE ONLY public.resumes DROP CONSTRAINT resumes_pdf_key;
       public            postgres    false    226         �           2606    19168    resumes resumes_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.resumes
    ADD CONSTRAINT resumes_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.resumes DROP CONSTRAINT resumes_pkey;
       public            postgres    false    226         �           2606    19108    skills skills_name_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.skills
    ADD CONSTRAINT skills_name_key UNIQUE (name);
 @   ALTER TABLE ONLY public.skills DROP CONSTRAINT skills_name_key;
       public            postgres    false    219         �           2606    19106    skills skills_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.skills
    ADD CONSTRAINT skills_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.skills DROP CONSTRAINT skills_pkey;
       public            postgres    false    219         �           2606    19254 3   applicant_skills applicant_skills_applicant_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.applicant_skills
    ADD CONSTRAINT applicant_skills_applicant_id_fkey FOREIGN KEY (applicant_id) REFERENCES public.applicants(id);
 ]   ALTER TABLE ONLY public.applicant_skills DROP CONSTRAINT applicant_skills_applicant_id_fkey;
       public          postgres    false    228    231    3565                     2606    19259 /   applicant_skills applicant_skills_skill_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.applicant_skills
    ADD CONSTRAINT applicant_skills_skill_id_fkey FOREIGN KEY (skill_id) REFERENCES public.skills(id);
 Y   ALTER TABLE ONLY public.applicant_skills DROP CONSTRAINT applicant_skills_skill_id_fkey;
       public          postgres    false    231    3549    219         �           2606    19211 $   applicants applicants_resume_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.applicants
    ADD CONSTRAINT applicants_resume_id_fkey FOREIGN KEY (resume_id) REFERENCES public.resumes(id);
 N   ALTER TABLE ONLY public.applicants DROP CONSTRAINT applicants_resume_id_fkey;
       public          postgres    false    226    228    3561                    2606    19298 +   applications applications_applicant_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.applications
    ADD CONSTRAINT applications_applicant_id_fkey FOREIGN KEY (applicant_id) REFERENCES public.applicants(id);
 U   ALTER TABLE ONLY public.applications DROP CONSTRAINT applications_applicant_id_fkey;
       public          postgres    false    233    3565    228                    2606    19308 %   applications applications_job_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.applications
    ADD CONSTRAINT applications_job_id_fkey FOREIGN KEY (job_id) REFERENCES public.jobs(id);
 O   ALTER TABLE ONLY public.applications DROP CONSTRAINT applications_job_id_fkey;
       public          postgres    false    3551    233    221                    2606    19303 +   applications applications_recruiter_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.applications
    ADD CONSTRAINT applications_recruiter_id_fkey FOREIGN KEY (recruiter_id) REFERENCES public.recruiters(id);
 U   ALTER TABLE ONLY public.applications DROP CONSTRAINT applications_recruiter_id_fkey;
       public          postgres    false    233    3545    217                    2606    19313 (   applications applications_resume_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.applications
    ADD CONSTRAINT applications_resume_id_fkey FOREIGN KEY (resume_id) REFERENCES public.resumes(id);
 R   ALTER TABLE ONLY public.applications DROP CONSTRAINT applications_resume_id_fkey;
       public          postgres    false    233    3561    226                    2606    19396 '   educations educations_applicant_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.educations
    ADD CONSTRAINT educations_applicant_id_fkey FOREIGN KEY (applicant_id) REFERENCES public.applicants(id);
 Q   ALTER TABLE ONLY public.educations DROP CONSTRAINT educations_applicant_id_fkey;
       public          postgres    false    228    3565    235                    2606    19386 %   educations educations_college_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.educations
    ADD CONSTRAINT educations_college_id_fkey FOREIGN KEY (college_id) REFERENCES public.colleges(id);
 O   ALTER TABLE ONLY public.educations DROP CONSTRAINT educations_college_id_fkey;
       public          postgres    false    235    3557    224                    2606    19391 $   educations educations_degree_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.educations
    ADD CONSTRAINT educations_degree_id_fkey FOREIGN KEY (degree_id) REFERENCES public.degrees(id);
 N   ALTER TABLE ONLY public.educations DROP CONSTRAINT educations_degree_id_fkey;
       public          postgres    false    230    3571    235         �           2606    19139 !   job_skills job_skills_job_id_fkey    FK CONSTRAINT     ~   ALTER TABLE ONLY public.job_skills
    ADD CONSTRAINT job_skills_job_id_fkey FOREIGN KEY (job_id) REFERENCES public.jobs(id);
 K   ALTER TABLE ONLY public.job_skills DROP CONSTRAINT job_skills_job_id_fkey;
       public          postgres    false    221    3551    222         �           2606    19144 #   job_skills job_skills_skill_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.job_skills
    ADD CONSTRAINT job_skills_skill_id_fkey FOREIGN KEY (skill_id) REFERENCES public.skills(id);
 M   ALTER TABLE ONLY public.job_skills DROP CONSTRAINT job_skills_skill_id_fkey;
       public          postgres    false    222    3549    219         �           2606    19129    jobs jobs_recruiter_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_recruiter_id_fkey FOREIGN KEY (recruiter_id) REFERENCES public.recruiters(id);
 E   ALTER TABLE ONLY public.jobs DROP CONSTRAINT jobs_recruiter_id_fkey;
       public          postgres    false    217    3545    221         �           2606    19093 %   recruiters recruiters_company_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.recruiters
    ADD CONSTRAINT recruiters_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.companies(id);
 O   ALTER TABLE ONLY public.recruiters DROP CONSTRAINT recruiters_company_id_fkey;
       public          postgres    false    217    3541    215                                            3751.dat                                                                                            0000600 0004000 0002000 00000000021 14524343167 0014253 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	1
1	2
1	3
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               3748.dat                                                                                            0000600 0004000 0002000 00000000115 14524343167 0014265 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	Bhavesh	Purswani	8866624082	bhaveshpurswani10@gmail.com	AbraKaDabra	1
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                   3753.dat                                                                                            0000600 0004000 0002000 00000000005 14524343167 0014257 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           3744.dat                                                                                            0000600 0004000 0002000 00000000016 14524343167 0014261 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	DAIICT
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  3735.dat                                                                                            0000600 0004000 0002000 00000000005 14524343167 0014257 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           3750.dat                                                                                            0000600 0004000 0002000 00000000021 14524343167 0014252 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	Btech-ICT
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               3755.dat                                                                                            0000600 0004000 0002000 00000000043 14524343167 0014263 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	1	1	2020-09-01	2024-05-30	1
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             3742.dat                                                                                            0000600 0004000 0002000 00000000005 14524343167 0014255 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           3741.dat                                                                                            0000600 0004000 0002000 00000000005 14524343167 0014254 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           3737.dat                                                                                            0000600 0004000 0002000 00000000005 14524343167 0014261 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           3746.dat                                                                                            0000600 0004000 0002000 00000000021 14524343167 0014257 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	hello.pdf
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               3739.dat                                                                                            0000600 0004000 0002000 00000000033 14524343167 0014264 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	java
2	c++
3	python
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     restore.sql                                                                                         0000600 0004000 0002000 00000056573 14524343167 0015415 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        --
-- NOTE:
--
-- File paths need to be edited. Search for $$PATH$$ and
-- replace it with the path to the directory containing
-- the extracted data files.
--
--
-- PostgreSQL database dump
--

-- Dumped from database version 15.3
-- Dumped by pg_dump version 15.3

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

DROP DATABASE jobquest;
--
-- Name: jobquest; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE jobquest WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = icu LOCALE = 'en_US.UTF-8' ICU_LOCALE = 'en-US';


ALTER DATABASE jobquest OWNER TO postgres;

\connect jobquest

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
-- Name: location_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.location_type AS ENUM (
    'Remote',
    'Hybrid',
    'On_Site'
);


ALTER TYPE public.location_type OWNER TO postgres;

--
-- Name: phone_number; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN public.phone_number AS character varying(10)
	CONSTRAINT phone_number_check CHECK (((VALUE)::text ~ '^[0-9]{10}$'::text));


ALTER DOMAIN public.phone_number OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: applicant_skills; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.applicant_skills (
    applicant_id integer NOT NULL,
    skill_id integer NOT NULL
);


ALTER TABLE public.applicant_skills OWNER TO postgres;

--
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
-- Name: applicants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.applicants_id_seq OWNED BY public.applicants.id;


--
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
-- Name: applications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.applications_id_seq OWNED BY public.applications.id;


--
-- Name: colleges; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.colleges (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.colleges OWNER TO postgres;

--
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
-- Name: college_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.college_id_seq OWNED BY public.colleges.id;


--
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
-- Name: companies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.companies_id_seq OWNED BY public.companies.id;


--
-- Name: degrees; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.degrees (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.degrees OWNER TO postgres;

--
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
-- Name: degrees_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.degrees_id_seq OWNED BY public.degrees.id;


--
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
-- Name: educations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.educations_id_seq OWNED BY public.educations.id;


--
-- Name: job_skills; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.job_skills (
    job_id integer NOT NULL,
    skill_id integer NOT NULL
);


ALTER TABLE public.job_skills OWNER TO postgres;

--
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
-- Name: jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.jobs_id_seq OWNED BY public.jobs.id;


--
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
-- Name: recruiters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.recruiters_id_seq OWNED BY public.recruiters.id;


--
-- Name: resumes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resumes (
    id integer NOT NULL,
    pdf text NOT NULL
);


ALTER TABLE public.resumes OWNER TO postgres;

--
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
-- Name: resumes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.resumes_id_seq OWNED BY public.resumes.id;


--
-- Name: skills; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.skills (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.skills OWNER TO postgres;

--
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
-- Name: skills_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.skills_id_seq OWNED BY public.skills.id;


--
-- Name: applicants id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.applicants ALTER COLUMN id SET DEFAULT nextval('public.applicants_id_seq'::regclass);


--
-- Name: applications id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.applications ALTER COLUMN id SET DEFAULT nextval('public.applications_id_seq'::regclass);


--
-- Name: colleges id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.colleges ALTER COLUMN id SET DEFAULT nextval('public.college_id_seq'::regclass);


--
-- Name: companies id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.companies ALTER COLUMN id SET DEFAULT nextval('public.companies_id_seq'::regclass);


--
-- Name: degrees id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.degrees ALTER COLUMN id SET DEFAULT nextval('public.degrees_id_seq'::regclass);


--
-- Name: educations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.educations ALTER COLUMN id SET DEFAULT nextval('public.educations_id_seq'::regclass);


--
-- Name: jobs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobs ALTER COLUMN id SET DEFAULT nextval('public.jobs_id_seq'::regclass);


--
-- Name: recruiters id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recruiters ALTER COLUMN id SET DEFAULT nextval('public.recruiters_id_seq'::regclass);


--
-- Name: resumes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resumes ALTER COLUMN id SET DEFAULT nextval('public.resumes_id_seq'::regclass);


--
-- Name: skills id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.skills ALTER COLUMN id SET DEFAULT nextval('public.skills_id_seq'::regclass);


--
-- Data for Name: applicant_skills; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.applicant_skills (applicant_id, skill_id) FROM stdin;
\.
COPY public.applicant_skills (applicant_id, skill_id) FROM '$$PATH$$/3751.dat';

--
-- Data for Name: applicants; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.applicants (id, first_name, last_name, phone_number, email, password, resume_id) FROM stdin;
\.
COPY public.applicants (id, first_name, last_name, phone_number, email, password, resume_id) FROM '$$PATH$$/3748.dat';

--
-- Data for Name: applications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.applications (id, applicant_id, recruiter_id, job_id, resume_id, status, date_of_applied, date_of_join) FROM stdin;
\.
COPY public.applications (id, applicant_id, recruiter_id, job_id, resume_id, status, date_of_applied, date_of_join) FROM '$$PATH$$/3753.dat';

--
-- Data for Name: colleges; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.colleges (id, name) FROM stdin;
\.
COPY public.colleges (id, name) FROM '$$PATH$$/3744.dat';

--
-- Data for Name: companies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.companies (id, name, description, website_link) FROM stdin;
\.
COPY public.companies (id, name, description, website_link) FROM '$$PATH$$/3735.dat';

--
-- Data for Name: degrees; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.degrees (id, name) FROM stdin;
\.
COPY public.degrees (id, name) FROM '$$PATH$$/3750.dat';

--
-- Data for Name: educations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.educations (id, college_id, degree_id, college_start_date, college_end_date, applicant_id) FROM stdin;
\.
COPY public.educations (id, college_id, degree_id, college_start_date, college_end_date, applicant_id) FROM '$$PATH$$/3755.dat';

--
-- Data for Name: job_skills; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.job_skills (job_id, skill_id) FROM stdin;
\.
COPY public.job_skills (job_id, skill_id) FROM '$$PATH$$/3742.dat';

--
-- Data for Name: jobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.jobs (id, title, job_type, year_of_experience, ctc, date_of_posting, deadline, location_type, location, recruiter_id, description) FROM stdin;
\.
COPY public.jobs (id, title, job_type, year_of_experience, ctc, date_of_posting, deadline, location_type, location, recruiter_id, description) FROM '$$PATH$$/3741.dat';

--
-- Data for Name: recruiters; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.recruiters (id, first_name, last_name, phone_number, email, password, company_id) FROM stdin;
\.
COPY public.recruiters (id, first_name, last_name, phone_number, email, password, company_id) FROM '$$PATH$$/3737.dat';

--
-- Data for Name: resumes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resumes (id, pdf) FROM stdin;
\.
COPY public.resumes (id, pdf) FROM '$$PATH$$/3746.dat';

--
-- Data for Name: skills; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.skills (id, name) FROM stdin;
\.
COPY public.skills (id, name) FROM '$$PATH$$/3739.dat';

--
-- Name: applicants_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.applicants_id_seq', 1, false);


--
-- Name: applications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.applications_id_seq', 1, false);


--
-- Name: college_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.college_id_seq', 1, false);


--
-- Name: companies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.companies_id_seq', 1, false);


--
-- Name: degrees_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.degrees_id_seq', 1, false);


--
-- Name: educations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.educations_id_seq', 1, false);


--
-- Name: jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.jobs_id_seq', 1, false);


--
-- Name: recruiters_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.recruiters_id_seq', 1, false);


--
-- Name: resumes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.resumes_id_seq', 1, false);


--
-- Name: skills_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.skills_id_seq', 1, false);


--
-- Name: applicant_skills applicant_skills_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.applicant_skills
    ADD CONSTRAINT applicant_skills_pkey PRIMARY KEY (applicant_id, skill_id);


--
-- Name: applicants applicants_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.applicants
    ADD CONSTRAINT applicants_email_key UNIQUE (email);


--
-- Name: applicants applicants_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.applicants
    ADD CONSTRAINT applicants_pkey PRIMARY KEY (id);


--
-- Name: applicants applicants_resume_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.applicants
    ADD CONSTRAINT applicants_resume_id_key UNIQUE (resume_id);


--
-- Name: applications applications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.applications
    ADD CONSTRAINT applications_pkey PRIMARY KEY (id);


--
-- Name: colleges college_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.colleges
    ADD CONSTRAINT college_name_key UNIQUE (name);


--
-- Name: colleges college_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.colleges
    ADD CONSTRAINT college_pkey PRIMARY KEY (id);


--
-- Name: companies companies_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.companies
    ADD CONSTRAINT companies_name_key UNIQUE (name);


--
-- Name: companies companies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.companies
    ADD CONSTRAINT companies_pkey PRIMARY KEY (id);


--
-- Name: degrees degrees_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.degrees
    ADD CONSTRAINT degrees_name_key UNIQUE (name);


--
-- Name: degrees degrees_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.degrees
    ADD CONSTRAINT degrees_pkey PRIMARY KEY (id);


--
-- Name: educations educations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.educations
    ADD CONSTRAINT educations_pkey PRIMARY KEY (id);


--
-- Name: job_skills job_skills_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_skills
    ADD CONSTRAINT job_skills_pkey PRIMARY KEY (job_id, skill_id);


--
-- Name: jobs jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);


--
-- Name: recruiters recruiters_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recruiters
    ADD CONSTRAINT recruiters_email_key UNIQUE (email);


--
-- Name: recruiters recruiters_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recruiters
    ADD CONSTRAINT recruiters_pkey PRIMARY KEY (id);


--
-- Name: resumes resumes_pdf_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resumes
    ADD CONSTRAINT resumes_pdf_key UNIQUE (pdf);


--
-- Name: resumes resumes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resumes
    ADD CONSTRAINT resumes_pkey PRIMARY KEY (id);


--
-- Name: skills skills_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.skills
    ADD CONSTRAINT skills_name_key UNIQUE (name);


--
-- Name: skills skills_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.skills
    ADD CONSTRAINT skills_pkey PRIMARY KEY (id);


--
-- Name: applicant_skills applicant_skills_applicant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.applicant_skills
    ADD CONSTRAINT applicant_skills_applicant_id_fkey FOREIGN KEY (applicant_id) REFERENCES public.applicants(id);


--
-- Name: applicant_skills applicant_skills_skill_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.applicant_skills
    ADD CONSTRAINT applicant_skills_skill_id_fkey FOREIGN KEY (skill_id) REFERENCES public.skills(id);


--
-- Name: applicants applicants_resume_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.applicants
    ADD CONSTRAINT applicants_resume_id_fkey FOREIGN KEY (resume_id) REFERENCES public.resumes(id);


--
-- Name: applications applications_applicant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.applications
    ADD CONSTRAINT applications_applicant_id_fkey FOREIGN KEY (applicant_id) REFERENCES public.applicants(id);


--
-- Name: applications applications_job_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.applications
    ADD CONSTRAINT applications_job_id_fkey FOREIGN KEY (job_id) REFERENCES public.jobs(id);


--
-- Name: applications applications_recruiter_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.applications
    ADD CONSTRAINT applications_recruiter_id_fkey FOREIGN KEY (recruiter_id) REFERENCES public.recruiters(id);


--
-- Name: applications applications_resume_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.applications
    ADD CONSTRAINT applications_resume_id_fkey FOREIGN KEY (resume_id) REFERENCES public.resumes(id);


--
-- Name: educations educations_applicant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.educations
    ADD CONSTRAINT educations_applicant_id_fkey FOREIGN KEY (applicant_id) REFERENCES public.applicants(id);


--
-- Name: educations educations_college_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.educations
    ADD CONSTRAINT educations_college_id_fkey FOREIGN KEY (college_id) REFERENCES public.colleges(id);


--
-- Name: educations educations_degree_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.educations
    ADD CONSTRAINT educations_degree_id_fkey FOREIGN KEY (degree_id) REFERENCES public.degrees(id);


--
-- Name: job_skills job_skills_job_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_skills
    ADD CONSTRAINT job_skills_job_id_fkey FOREIGN KEY (job_id) REFERENCES public.jobs(id);


--
-- Name: job_skills job_skills_skill_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_skills
    ADD CONSTRAINT job_skills_skill_id_fkey FOREIGN KEY (skill_id) REFERENCES public.skills(id);


--
-- Name: jobs jobs_recruiter_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_recruiter_id_fkey FOREIGN KEY (recruiter_id) REFERENCES public.recruiters(id);


--
-- Name: recruiters recruiters_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recruiters
    ADD CONSTRAINT recruiters_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.companies(id);


--
-- PostgreSQL database dump complete
--

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     