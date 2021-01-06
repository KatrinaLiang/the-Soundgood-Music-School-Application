CREATE TABLE email (
 id SERIAL NOT NULL,
 email  VARCHAR(100) NOT NULL
);

ALTER TABLE email ADD CONSTRAINT PK_email PRIMARY KEY (id);


CREATE TABLE instrument (
 id SERIAL NOT NULL,
 type VARCHAR(100),
 brand VARCHAR(100),
 quantity_in_stock INT,
 rent_per_month INT
);

ALTER TABLE instrument ADD CONSTRAINT PK_instrument PRIMARY KEY (id);


CREATE TABLE person (
 person_number VARCHAR(12) NOT NULL,
 first_name VARCHAR(100),
 last_name VARCHAR(100),
 birth DATE,
 street VARCHAR(100),
 zip VARCHAR(10),
 city VARCHAR(100)
);

ALTER TABLE person ADD CONSTRAINT PK_person PRIMARY KEY (person_number);


CREATE TABLE person_email (
 person_number VARCHAR(12) NOT NULL,
 email_id INT NOT NULL
);

ALTER TABLE person_email ADD CONSTRAINT PK_person_email PRIMARY KEY (person_number,email_id);


CREATE TABLE phone (
 id SERIAL NOT NULL,
 phone_no VARCHAR(22) NOT NULL
);

ALTER TABLE phone ADD CONSTRAINT PK_phone PRIMARY KEY (id);


CREATE TABLE price_for_student (
 price_id SERIAL NOT NULL,
 type VARCHAR(40),
 price_per_lesson INT,
 extra_charge INT
);

ALTER TABLE price_for_student ADD CONSTRAINT PK_price_for_student PRIMARY KEY (price_id);


CREATE TABLE salary_for_instructor (
 id SERIAL NOT NULL,
 type VARCHAR(40),
 salary_per_lesson INT,
 extra_pay INT
);

ALTER TABLE salary_for_instructor ADD CONSTRAINT PK_salary_for_instructor PRIMARY KEY (id);


CREATE TABLE sibling (
 id SERIAL NOT NULL,
 student_id VARCHAR(12)
);

ALTER TABLE sibling ADD CONSTRAINT PK_sibling PRIMARY KEY (id);


CREATE TABLE student (
 student_id SERIAL NOT NULL,
 person_number VARCHAR(12) NOT NULL,
 nr_of_rented_instrument INT
);

ALTER TABLE student ADD CONSTRAINT PK_student PRIMARY KEY (student_id);


CREATE TABLE student_enrollment (
 id SERIAL NOT NULL,
 level VARCHAR(100),
 instrument VARCHAR(100),
 audition TIMESTAMP(10),
 result_of_audition VARCHAR(100),
 accepted VARCHAR(3),
 person_number VARCHAR(12) NOT NULL,
 student_id INT NOT NULL
);

ALTER TABLE student_enrollment ADD CONSTRAINT PK_student_enrollment PRIMARY KEY (id);


CREATE TABLE student_instrument (
 student_id INT NOT NULL,
 instrument_id INT NOT NULL
);

ALTER TABLE student_instrument ADD CONSTRAINT PK_student_instrument PRIMARY KEY (student_id,instrument_id);


CREATE TABLE student_payment (
 pay_id SERIAL NOT NULL,
 pay_date DATE,
 siblings_discount INT,
 student_id INT,
 price_id SERIAL NOT NULL
);

ALTER TABLE student_payment ADD CONSTRAINT PK_student_payment PRIMARY KEY (pay_id);


CREATE TABLE student_sibling (
 student_id  INT NOT NULL,
 sibling_id INT NOT NULL
);

ALTER TABLE student_sibling ADD CONSTRAINT PK_student_sibling PRIMARY KEY (student_id ,sibling_id);


CREATE TABLE enrollment_parents (
 enrollement_id INT NOT NULL,
 person_number VARCHAR(12) NOT NULL
);

ALTER TABLE enrollment_parents ADD CONSTRAINT PK_enrollment_parents PRIMARY KEY (enrollement_id,person_number);


CREATE TABLE instructor (
 employment_id SERIAL NOT NULL,
 person_number VARCHAR(12) NOT NULL
);

ALTER TABLE instructor ADD CONSTRAINT PK_instructor PRIMARY KEY (employment_id);


CREATE TABLE instructor_salary (
 salary_id SERIAL NOT NULL,
 pay_date DATE,
 employment_id INT,
 price_id INT NOT NULL
);

ALTER TABLE instructor_salary ADD CONSTRAINT PK_instructor_salary PRIMARY KEY (salary_id);


CREATE TABLE instrument_rental (
 renting_id SERIAL NOT NULL,
 rent_date DATE,
 rent_due DATE,
 student_id INT NOT NULL,
 instrument_id INT
);

ALTER TABLE instrument_rental ADD CONSTRAINT PK_instrument_rental PRIMARY KEY (renting_id);


CREATE TABLE instruments_instructor (
 employment_id INT NOT NULL,
 instrument_id INT NOT NULL
);

ALTER TABLE instruments_instructor ADD CONSTRAINT PK_instruments_instructor PRIMARY KEY (employment_id,instrument_id);


CREATE TABLE lesson (
 lesson_id SERIAL NOT NULL,
 level VARCHAR(100),
 start_time TIMESTAMP(10),
 end_time TIMESTAMP(10),
 employment_id INT NOT NULL,
 is_individual_lesson VARCHAR(3)
);

ALTER TABLE lesson ADD CONSTRAINT PK_lesson PRIMARY KEY (lesson_id);


CREATE TABLE lesson_instrument (
 lesson_id INT NOT NULL,
 instrument_id INT NOT NULL
);

ALTER TABLE lesson_instrument ADD CONSTRAINT PK_lesson_instrument PRIMARY KEY (lesson_id,instrument_id);


CREATE TABLE person_phone (
 phone_id INT NOT NULL,
 person_number VARCHAR(12) NOT NULL
);

ALTER TABLE person_phone ADD CONSTRAINT PK_person_phone PRIMARY KEY (phone_id,person_number);


CREATE TABLE student_lesson (
 lesson_id INT NOT NULL,
 student_id INT NOT NULL
);

ALTER TABLE student_lesson ADD CONSTRAINT PK_student_lesson PRIMARY KEY (lesson_id,student_id);


CREATE TABLE time_slot (
 employment_id SERIAL NOT NULL,
 from_time TIMESTAMP(10),
 to_time TIMESTAMP(10)
);

ALTER TABLE time_slot ADD CONSTRAINT PK_time_slot PRIMARY KEY (employment_id);


CREATE TABLE group_lesson (
 group_lesson_id SERIAL NOT NULL,
 lesson_id INT NOT NULL,
 nr_of_places INT,
 min_nr_of_student INT
);

ALTER TABLE group_lesson ADD CONSTRAINT PK_group_lesson PRIMARY KEY (group_lesson_id,lesson_id);


CREATE TABLE ensemble (
 ensemble_id SERIAL NOT NULL,
 group_lesson_id INT NOT NULL,
 lesson_id INT NOT NULL,
 genre VARCHAR(100)
);

ALTER TABLE ensemble ADD CONSTRAINT PK_ensemble PRIMARY KEY (ensemble_id,group_lesson_id,lesson_id);


ALTER TABLE person_email ADD CONSTRAINT FK_person_email_0 FOREIGN KEY (person_number) REFERENCES person (person_number);
ALTER TABLE person_email ADD CONSTRAINT FK_person_email_1 FOREIGN KEY (email_id) REFERENCES email (id);


ALTER TABLE student ADD CONSTRAINT FK_student_0 FOREIGN KEY (person_number) REFERENCES person (person_number);


ALTER TABLE student_enrollment ADD CONSTRAINT FK_student_enrollment_0 FOREIGN KEY (person_number) REFERENCES person (person_number);
ALTER TABLE student_enrollment ADD CONSTRAINT FK_student_enrollment_1 FOREIGN KEY (student_id) REFERENCES student (student_id);


ALTER TABLE student_instrument ADD CONSTRAINT FK_student_instrument_0 FOREIGN KEY (student_id) REFERENCES student (student_id);
ALTER TABLE student_instrument ADD CONSTRAINT FK_student_instrument_1 FOREIGN KEY (instrument_id) REFERENCES instrument (id);


ALTER TABLE student_payment ADD CONSTRAINT FK_student_payment_0 FOREIGN KEY (student_id) REFERENCES student (student_id);
ALTER TABLE student_payment ADD CONSTRAINT FK_student_payment_1 FOREIGN KEY (price_id) REFERENCES price_for_student (price_id);


ALTER TABLE student_sibling ADD CONSTRAINT FK_student_sibling_0 FOREIGN KEY (student_id ) REFERENCES student (student_id);
ALTER TABLE student_sibling ADD CONSTRAINT FK_student_sibling_1 FOREIGN KEY (sibling_id) REFERENCES sibling (id);


ALTER TABLE enrollment_parents ADD CONSTRAINT FK_enrollment_parents_0 FOREIGN KEY (enrollement_id) REFERENCES student_enrollment (id);
ALTER TABLE enrollment_parents ADD CONSTRAINT FK_enrollment_parents_1 FOREIGN KEY (person_number) REFERENCES person (person_number);


ALTER TABLE instructor ADD CONSTRAINT FK_instructor_0 FOREIGN KEY (person_number) REFERENCES person (person_number);


ALTER TABLE instructor_salary ADD CONSTRAINT FK_instructor_salary_0 FOREIGN KEY (employment_id) REFERENCES instructor (employment_id);
ALTER TABLE instructor_salary ADD CONSTRAINT FK_instructor_salary_1 FOREIGN KEY (price_id) REFERENCES salary_for_instructor (id);


ALTER TABLE instrument_rental ADD CONSTRAINT FK_instrument_rental_0 FOREIGN KEY (student_id) REFERENCES student (student_id);
ALTER TABLE instrument_rental ADD CONSTRAINT FK_instrument_rental_1 FOREIGN KEY (instrument_id) REFERENCES instrument (id);


ALTER TABLE instruments_instructor ADD CONSTRAINT FK_instruments_instructor_0 FOREIGN KEY (employment_id) REFERENCES instructor (employment_id);
ALTER TABLE instruments_instructor ADD CONSTRAINT FK_instruments_instructor_1 FOREIGN KEY (instrument_id) REFERENCES instrument (id);


ALTER TABLE lesson ADD CONSTRAINT FK_lesson_0 FOREIGN KEY (employment_id) REFERENCES instructor (employment_id);


ALTER TABLE lesson_instrument ADD CONSTRAINT FK_lesson_instrument_0 FOREIGN KEY (lesson_id) REFERENCES lesson (lesson_id);
ALTER TABLE lesson_instrument ADD CONSTRAINT FK_lesson_instrument_1 FOREIGN KEY (instrument_id) REFERENCES instrument (id);


ALTER TABLE person_phone ADD CONSTRAINT FK_person_phone_0 FOREIGN KEY (phone_id) REFERENCES phone (id);
ALTER TABLE person_phone ADD CONSTRAINT FK_person_phone_1 FOREIGN KEY (person_number) REFERENCES person (person_number);


ALTER TABLE student_lesson ADD CONSTRAINT FK_student_lesson_0 FOREIGN KEY (lesson_id) REFERENCES lesson (lesson_id);
ALTER TABLE student_lesson ADD CONSTRAINT FK_student_lesson_1 FOREIGN KEY (student_id) REFERENCES student (student_id);


ALTER TABLE time_slot ADD CONSTRAINT FK_time_slot_0 FOREIGN KEY (employment_id) REFERENCES instructor (employment_id);


ALTER TABLE group_lesson ADD CONSTRAINT FK_group_lesson_0 FOREIGN KEY (lesson_id) REFERENCES lesson (lesson_id);


ALTER TABLE ensemble ADD CONSTRAINT FK_ensemble_0 FOREIGN KEY (group_lesson_id,lesson_id) REFERENCES group_lesson (group_lesson_id,lesson_id);


