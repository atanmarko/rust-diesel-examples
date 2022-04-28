-- Your SQL goes here
CREATE TABLE public.students (
                                id uuid NOT NULL,
                                first_name varchar NOT NULL,
                                last_name varchar NOT NULL,
                                address varchar NOT NULL,
                                age int8 NULL,
                                date_of_birth date NULL,
                                CONSTRAINT student_pk PRIMARY KEY (id)
);


CREATE TABLE public.teachers (
                                id uuid NOT NULL,
                                first_name varchar NOT NULL,
                                last_name varchar NOT NULL,
                                "degree" varchar NOT NULL,
                                fully_employed bool NULL,
                                "contract_timestamp" timestamp with time zone default current_timestamp NOT NULL,
                                CONSTRAINT teacher_pk PRIMARY KEY (id)
);

CREATE TABLE public.subjects (
                                "index" int4 NOT NULL,
                                subject varchar NOT NULL,
                                teacher uuid NULL,
                                CONSTRAINT subject_pk PRIMARY KEY (index)
);
CREATE INDEX subject_index_idx ON public.subjects USING btree (index);
ALTER TABLE public.subjects ADD CONSTRAINT subject_fk FOREIGN KEY (teacher) REFERENCES public.teachers(id);



CREATE TABLE public.grades (
                              student uuid NOT NULL,
                              subject int4 NOT NULL,
                              grade float4 NOT NULL,
                              "time" time NOT NULL,
                              CONSTRAINT grades_pk PRIMARY KEY (student,subject,grade,"time")
);


-- public.grades foreign keys

ALTER TABLE public.grades ADD CONSTRAINT grades_fk FOREIGN KEY (student) REFERENCES public.students(id);
ALTER TABLE public.grades ADD CONSTRAINT grades_fk_1 FOREIGN KEY (subject) REFERENCES public.subjects("index");


INSERT INTO public.students (id,first_name,last_name,address,age,date_of_birth) VALUES
                                                                                   ('9195657e-c6d1-11ec-9d64-0242ac120002','John','Smith','9473 Maggie Harbors, Suite 249, 61545, New Foster, Alaska, United States
',15,'2007-06-12'),
                                                                                   ('91956ace-c6d1-11ec-9d64-0242ac120002','Jack','Bears','9095 Crona Point, Suite 447, 34402-3167, West Zenaland, Massachusetts, United States
',16,'2006-07-23'),
                                                                                   ('91956f88-c6d1-11ec-9d64-0242ac120002','Lucy','Frankel','43209 Fritsch Viaduct, Suite 391, 78945-4689, Wehnermouth, New Mexico, United States
',14,'2008-04-22'),
                                                                                   ('91957140-c6d1-11ec-9d64-0242ac120002','Sofia','Matulewicz','00943 Otho Roads, Suite 284, 84711, Kshlerinbury, North Carolina, United States
',15,'2007-01-31'),
                                                                                   ('91957618-c6d1-11ec-9d64-0242ac120002','Laura','Sekler','408 Bergnaum Points, Suite 029, 33671-8950, Port Jonatan, Massachusetts, United States
',13,'2008-12-31'),
                                                                                   ('919577da-c6d1-11ec-9d64-0242ac120002','Dionysus','Mccorkle','547 Heathcote Trail, Suite 598, 65447, Nolanport, New Jersey, United States
',15,'2007-07-02'),
                                                                                   ('91957956-c6d1-11ec-9d64-0242ac120002','Elayne','Dwyer','881 Theodora Mountains, Apt. 920, 24755, South Colby, Wyoming, United States
',14,'2008-02-27'),
                                                                                   ('91957bc2-c6d1-11ec-9d64-0242ac120002','Eustacia','Cignetti','937 Fahey Mall, Apt. 421, 96490, East Winifred, Montana, United States
',13,'2009-01-12'),
                                                                                   ('91957cee-c6d1-11ec-9d64-0242ac120002','Ollie','Calotychos','71456 Armstrong Key, Suite 635, 42657, Wavamouth, Wisconsin, United States
',16,'2006-11-11'),
                                                                                   ('1bdfbe4a-c6d3-11ec-9d64-0242ac120002','Anita','Scheibner','40389 Donny Flats, Apt. 774, 34247, North Samantha, Hawaii, United States
',14,'2008-05-20');
INSERT INTO public.students (id,first_name,last_name,address,age,date_of_birth) VALUES
    ('1bdfbff8-c6d3-11ec-9d64-0242ac120002','Jasmine','Scheibner','40389 Donny Flats, Apt. 774, 34247, North Samantha, Hawaii, United States
',14,'2008-05-20');


INSERT INTO public.teachers
(id, first_name, last_name, "degree", fully_employed)
VALUES('c1bad5c0-c6d3-11ec-9d64-0242ac120002'::uuid, 'Devlen', 'Sanjuan', 'Biology', true);
INSERT INTO public.teachers
(id, first_name, last_name, "degree", fully_employed)
VALUES('0c4d2200-c6d4-11ec-9d64-0242ac120002'::uuid, 'Dennison', 'Veder', 'Sociology', false);
INSERT INTO public.teachers
(id, first_name, last_name, "degree", fully_employed)
VALUES('27a8e14c-c6d4-11ec-9d64-0242ac120002'::uuid, 'Wandis', 'Amos', 'Art', true);
INSERT INTO public.teachers
(id, first_name, last_name, "degree", fully_employed)
VALUES('27a8e4e4-c6d4-11ec-9d64-0242ac120002'::uuid, 'Theodor', 'Bernfield', 'Mathematics', true);
INSERT INTO public.teachers
(id, first_name, last_name, "degree", fully_employed)
VALUES('4d707bba-c6d4-11ec-9d64-0242ac120002'::uuid, 'Rowney', 'Mcelroy', 'Geopgraphy', false);
INSERT INTO public.teachers
(id, first_name, last_name, "degree", fully_employed)
VALUES('6a0df90a-c6d4-11ec-9d64-0242ac120002'::uuid, 'Paule', 'Crum', 'English', true);


INSERT INTO public.subjects
("index", subject, teacher)
VALUES(1, 'Biology', 'c1bad5c0-c6d3-11ec-9d64-0242ac120002'::uuid);
INSERT INTO public.subjects
("index", subject, teacher)
VALUES(2, 'Mathematics', '27a8e4e4-c6d4-11ec-9d64-0242ac120002'::uuid);
INSERT INTO public.subjects
("index", subject, teacher)
VALUES(3, 'Music', '27a8e14c-c6d4-11ec-9d64-0242ac120002'::uuid);
INSERT INTO public.subjects
("index", subject, teacher)
VALUES(4, 'Art', '27a8e14c-c6d4-11ec-9d64-0242ac120002'::uuid);
INSERT INTO public.subjects
("index", subject, teacher)
VALUES(5, 'Geography', '4d707bba-c6d4-11ec-9d64-0242ac120002'::uuid);
INSERT INTO public.subjects
("index", subject, teacher)
VALUES(6, 'History', '4d707bba-c6d4-11ec-9d64-0242ac120002'::uuid);
INSERT INTO public.subjects
("index", subject, teacher)
VALUES(7, 'English', '6a0df90a-c6d4-11ec-9d64-0242ac120002'::uuid);
INSERT INTO public.subjects
("index", subject, teacher)
VALUES(8, 'Latin', '6a0df90a-c6d4-11ec-9d64-0242ac120002'::uuid);
INSERT INTO public.subjects
("index", subject, teacher)
VALUES(9, 'Physics', '27a8e4e4-c6d4-11ec-9d64-0242ac120002'::uuid);



INSERT INTO public.grades
(student, subject, grade, "time")
VALUES('1bdfbe4a-c6d3-11ec-9d64-0242ac120002'::uuid, 1, 4.5, '2022-04-28 12:48:47.038');
INSERT INTO public.grades
(student, subject, grade, "time")
VALUES('1bdfbe4a-c6d3-11ec-9d64-0242ac120002'::uuid, 2, 4.0, '2022-04-28 12:38:46.038');
INSERT INTO public.grades
(student, subject, grade, "time")
VALUES('1bdfbe4a-c6d3-11ec-9d64-0242ac120002'::uuid, 3, 5.0, '2022-04-27 12:38:45.038');
INSERT INTO public.grades
(student, subject, grade, "time")
VALUES('1bdfbe4a-c6d3-11ec-9d64-0242ac120002'::uuid, 4, 3.0, '2022-03-27 12:38:44.038');
INSERT INTO public.grades
(student, subject, grade, "time")
VALUES('91956f88-c6d1-11ec-9d64-0242ac120002'::uuid, 5, 4.0, '2022-03-27 12:33:43.038');
INSERT INTO public.grades
(student, subject, grade, "time")
VALUES('91956f88-c6d1-11ec-9d64-0242ac120002'::uuid, 5, 3.0, '2022-03-27 12:18:42.038');
INSERT INTO public.grades
(student, subject, grade, "time")
VALUES('91956f88-c6d1-11ec-9d64-0242ac120002'::uuid, 1, 4.5, '2022-04-28 12:48:41.038');
INSERT INTO public.grades
(student, subject, grade, "time")
VALUES('1bdfbe4a-c6d3-11ec-9d64-0242ac120002'::uuid, 2, 4.0, '2022-04-28 12:38:40.038');
INSERT INTO public.grades
(student, subject, grade, "time")
VALUES('919577da-c6d1-11ec-9d64-0242ac120002'::uuid, 3, 5.0, '2022-04-27 12:38:39.038');
INSERT INTO public.grades
(student, subject, grade, "time")
VALUES('91957bc2-c6d1-11ec-9d64-0242ac120002'::uuid, 4, 3.0, '2022-03-27 12:38:38.038');
INSERT INTO public.grades
(student, subject, grade, "time")
VALUES('91957cee-c6d1-11ec-9d64-0242ac120002'::uuid, 5, 4.0, '2022-03-27 12:33:37.038');
INSERT INTO public.grades
(student, subject, grade, "time")
VALUES('1bdfbff8-c6d3-11ec-9d64-0242ac120002'::uuid, 5, 3.0, '2022-03-27 12:18:36.038');
INSERT INTO public.grades
(student, subject, grade, "time")
VALUES('9195657e-c6d1-11ec-9d64-0242ac120002'::uuid, 5, 4.0, '2022-03-27 12:33:35.038');
INSERT INTO public.grades
(student, subject, grade, "time")
VALUES('91956f88-c6d1-11ec-9d64-0242ac120002'::uuid, 3, 4.0, '2022-03-27 12:38:34.038');
INSERT INTO public.grades
(student, subject, grade, "time")
VALUES('91957618-c6d1-11ec-9d64-0242ac120002'::uuid, 2, 2.0, '2022-03-27 12:38:33.038');
INSERT INTO public.grades
(student, subject, grade, "time")
VALUES('91957618-c6d1-11ec-9d64-0242ac120002'::uuid, 2, 2.0, '2022-03-27 12:38:32.038');
INSERT INTO public.grades
(student, subject, grade, "time")
VALUES('91957618-c6d1-11ec-9d64-0242ac120002'::uuid, 5, 4.0, '2022-03-27 12:33:31.038');
INSERT INTO public.grades
(student, subject, grade, "time")
VALUES('91957956-c6d1-11ec-9d64-0242ac120002'::uuid, 5, 3.2, '2022-03-27 12:18:30.038');
INSERT INTO public.grades
(student, subject, grade, "time")
VALUES('91957bc2-c6d1-11ec-9d64-0242ac120002'::uuid, 5, 5.0, '2022-03-27 12:33:28.038');
INSERT INTO public.grades
(student, subject, grade, "time")
VALUES('91957cee-c6d1-11ec-9d64-0242ac120002'::uuid, 3, 4.1, '2022-03-27 12:38:27.038');
INSERT INTO public.grades
(student, subject, grade, "time")
VALUES('9195657e-c6d1-11ec-9d64-0242ac120002'::uuid, 2, 4.2, '2022-03-27 12:38:26.038');
INSERT INTO public.grades
(student, subject, grade, "time")
VALUES('91956ace-c6d1-11ec-9d64-0242ac120002'::uuid, 2, 2.0, '2022-03-27 12:38:25.038');
INSERT INTO public.grades
(student, subject, grade, "time")
VALUES('1bdfbff8-c6d3-11ec-9d64-0242ac120002'::uuid, 7, 2.0, '2022-03-27 12:38:24.038');
INSERT INTO public.grades
(student, subject, grade, "time")
VALUES('9195657e-c6d1-11ec-9d64-0242ac120002'::uuid, 7, 2.0, '2022-03-27 12:38:23.038');
INSERT INTO public.grades
(student, subject, grade, "time")
VALUES('919577da-c6d1-11ec-9d64-0242ac120002'::uuid, 7, 4.0, '2022-03-27 12:33:22.038');
INSERT INTO public.grades
(student, subject, grade, "time")
VALUES('91957bc2-c6d1-11ec-9d64-0242ac120002'::uuid, 7, 3.2, '2022-03-27 12:18:21.038');
INSERT INTO public.grades
(student, subject, grade, "time")
VALUES('91957bc2-c6d1-11ec-9d64-0242ac120002'::uuid, 7, 5.0, '2022-03-27 12:33:20.038');
INSERT INTO public.grades
(student, subject, grade, "time")
VALUES('91957cee-c6d1-11ec-9d64-0242ac120002'::uuid, 6, 4.1, '2022-03-27 12:38:19.038');
INSERT INTO public.grades
(student, subject, grade, "time")
VALUES('9195657e-c6d1-11ec-9d64-0242ac120002'::uuid, 3, 4.2, '2022-03-27 12:38:18.038');
INSERT INTO public.grades
(student, subject, grade, "time")
VALUES('91956ace-c6d1-11ec-9d64-0242ac120002'::uuid, 3, 2.0, '2022-03-27 12:38:17.038');
INSERT INTO public.grades
(student, subject, grade, "time")
VALUES('1bdfbff8-c6d3-11ec-9d64-0242ac120002'::uuid, 6, 2.0, '2022-03-27 12:38:16.038');
INSERT INTO public.grades
(student, subject, grade, "time")
VALUES('9195657e-c6d1-11ec-9d64-0242ac120002'::uuid, 6, 2.0, '2022-03-27 12:38:15.038');
INSERT INTO public.grades
(student, subject, grade, "time")
VALUES('919577da-c6d1-11ec-9d64-0242ac120002'::uuid, 6, 4.0, '2022-03-27 12:33:14.038');
INSERT INTO public.grades
(student, subject, grade, "time")
VALUES('91957bc2-c6d1-11ec-9d64-0242ac120002'::uuid, 6, 3.2, '2022-03-27 12:18:13.038');
INSERT INTO public.grades
(student, subject, grade, "time")
VALUES('91957bc2-c6d1-11ec-9d64-0242ac120002'::uuid, 6, 5.0, '2022-03-27 12:33:12.038');
INSERT INTO public.grades
(student, subject, grade, "time")
VALUES('91957cee-c6d1-11ec-9d64-0242ac120002'::uuid, 8, 4.1, '2022-03-27 12:38:11.038');
INSERT INTO public.grades
(student, subject, grade, "time")
VALUES('9195657e-c6d1-11ec-9d64-0242ac120002'::uuid, 8, 4.2, '2022-03-27 12:19:10.038');
INSERT INTO public.grades
(student, subject, grade, "time")
VALUES('91956ace-c6d1-11ec-9d64-0242ac120002'::uuid, 8, 3.0, '2022-03-27 12:18:21.038');
INSERT INTO public.grades
(student, subject, grade, "time")
VALUES('1bdfbff8-c6d3-11ec-9d64-0242ac120002'::uuid, 8, 4.0, '2022-03-27 12:17:21.038');
INSERT INTO public.grades
(student, subject, grade, "time")
VALUES('9195657e-c6d1-11ec-9d64-0242ac120002'::uuid, 8, 5.0, '2022-03-27 12:16:21.038');
INSERT INTO public.grades
(student, subject, grade, "time")
VALUES('919577da-c6d1-11ec-9d64-0242ac120002'::uuid, 8, 3.4, '2022-03-27 12:15:21.038');
INSERT INTO public.grades
(student, subject, grade, "time")
VALUES('91957bc2-c6d1-11ec-9d64-0242ac120002'::uuid, 8, 3.2, '2022-03-27 12:14:21.038');
INSERT INTO public.grades
(student, subject, grade, "time")
VALUES('91957bc2-c6d1-11ec-9d64-0242ac120002'::uuid, 8, 4.0, '2022-03-27 12:13:21.038');
INSERT INTO public.grades
(student, subject, grade, "time")
VALUES('91957cee-c6d1-11ec-9d64-0242ac120002'::uuid, 8, 4.1, '2022-03-27 12:12:21.038');
INSERT INTO public.grades
(student, subject, grade, "time")
VALUES('9195657e-c6d1-11ec-9d64-0242ac120002'::uuid, 8, 4.2, '2022-03-27 12:11:21.038');
INSERT INTO public.grades
(student, subject, grade, "time")
VALUES('91956ace-c6d1-11ec-9d64-0242ac120002'::uuid, 8, 1.0, '2022-03-27 12:18:21.038');
