/* Show the number of instruments rented per month during a specified year.*/
CREATE VIEW rentals_per_month AS
SELECT EXTRACT(MONTH FROM rent_date) AS month, COUNT(EXTRACT(MONTH FROM rent_date)) AS nr_of_instruments_rented
FROM instrument_rental
WHERE EXTRACT(YEAR FROM rent_date)='2020'
GROUP BY EXTRACT(MONTH FROM rent_date);

/*total number of rented instruments (just one number) */
CREATE VIEW tot_rentals AS
SELECT COUNT(*) AS tot_rental
FROM instrument_rental
WHERE EXTRACT(YEAR FROM rent_date)='2020';

/*rented instruments of each kind
CREATE VIEW rentals_by_type AS
SELECT type AS "Type of instrument",
COUNT(*) AS "No of rentals"
FROM instrument
INNER JOIN instrument_rental
ON instrument_rental.instrument_id = instrument.id  AND
EXTRACT(YEAR FROM rent_date)='2020'
GROUP BY instrument_rental.instrument_id, type
ORDER BY "No of rentals";

/* the average number of rentals per month during the entire year */
CREATE VIEW avg_rentals_per_month AS
SELECT COUNT(*)/12::float AS "Avg no of rentals per month"
FROM instrument_rental
WHERE EXTRACT(YEAR FROM rent_date)='2020';

/* Show the number of lessons given per month during a specified year. */
CREATE VIEW lessons_per_month AS
SELECT EXTRACT (MONTH FROM start_time) AS month, COUNT (EXTRACT (MONTH FROM start_time)) AS "Number of lessons"
FROM lesson
WHERE EXTRACT (YEAR FROM start_time)='2020'
GROUP BY EXTRACT(MONTH FROM start_time);

/* Show the number of lessons. */
CREATE VIEW tot_lessons AS
SELECT (SELECT COUNT(*) AS "Total no of lessons" FROM group_lesson)
+
(SELECT COUNT(*) AS "Total no of lessons" FROM individual_lesson)
AS "Tot number of lessons";

/* Show the number of group lessons. */
CREATE VIEW tot_group_lessons AS
SELECT COUNT(*) AS "Total no of group lessons"
FROM group_lesson;

/* Show the number of ensembles. */
CREATE VIEW tot_ensembles AS
SELECT COUNT(*) AS "Total no of ensembles"
FROM ensemble;

/* Show the number of individual lessons. */
CREATE VIEW tot_individual_lessons AS
SELECT COUNT(*) AS "Total no of individual lessons"
FROM individual_lesson;

/*the average number of lessons per month during the entire year*/
CREATE VIEW avg_lessons_per_month AS
SELECT COUNT(*)/12::float AS "Avg no of lessons per month"
FROM group_lesson, individual_lesson
WHERE EXTRACT(YEAR FROM group_lesson.start_time)='2020'
AND EXTRACT(YEAR FROM individual_lesson.start_time)='2020';

--- List all instructors who has given more than a specific number of lessons during the current month
CREATE VIEW instructor_lessons AS
SELECT
person.first_name AS "First name",
person.last_name AS "Last name",
instructor.employment_id AS "Employment ID",
COUNT(*) AS "Number of lessons during the current month"

FROM person
 JOIN instructor
ON person.person_number = instructor.person_number

JOIN ((SELECT employment_id, start_time, group_lesson_id FROM group_lesson
WHERE start_time > date_trunc('month', current_date) AND start_time < CURRENT_TIMESTAMP)
UNION ALL
(SELECT employment_id, start_time, id FROM individual_lesson
WHERE start_time > date_trunc('month', current_date) AND start_time < CURRENT_TIMESTAMP))l

on l.employment_id = instructor.employment_id

GROUP BY instructor.employment_id, person.first_name,
person.last_name
HAVING COUNT(*) > 1 --- more than 1 lessons
ORDER BY "Number of lessons during the current month" DESC;

-- the three instructors having given most lessons (independent of lesson type) during the last month
CREATE MATERIALIZED VIEW instructors_with_most_lessons AS
SELECT
person.first_name AS "First name",
person.last_name AS "Last name",
instructor.employment_id AS "Employment ID",
COUNT(*) AS "Number of lessons during the last month"

FROM person
 JOIN instructor
ON person.person_number = instructor.person_number

JOIN ((SELECT employment_id, start_time, group_lesson_id FROM group_lesson
WHERE date_trunc('month', start_time)=date_trunc('month', current_date - interval '1' month))
UNION ALL
(SELECT employment_id, start_time, id FROM individual_lesson
WHERE date_trunc('month', start_time)=date_trunc('month', current_date - interval '1' month)))
l

ON l.employment_id = instructor.employment_id

GROUP BY instructor.employment_id, person.first_name,
person.last_name
ORDER BY "Number of lessons during the last month" DESC
limit 3;

--- show nr of lessons for next week
CREATE VIEW nr_lessons_next_week AS
SELECT COUNT(*)
FROM
(SELECT start_time FROM individual_lesson
UNION ALL SELECT start_time FROM group_lesson)l
WHERE(l.start_time >= date_trunc('week', CURRENT_TIMESTAMP + interval '1 week')
AND l.start_time < date_trunc('week', CURRENT_TIMESTAMP + interval '2 week'));

---List all ensembles held during the next week, sorted by music genre and weekday.
CREATE VIEW list_ensembles_next_week AS
SELECT
group_lesson.group_lesson_id AS "lesson ID",
ensemble.genre AS "genre",
to_char(group_lesson.start_time, 'Day') AS "weekday",
group_lesson.nr_of_places AS "number of seats",

CASE WHEN group_lesson.nr_of_places=0 OR group_lesson.nr_of_places IS NULL THEN 'fully booked'
WHEN group_lesson.nr_of_places=1 OR group_lesson.nr_of_places=2 THEN 'almost fully booked'
ELSE 'many seats left'
END AS statue

FROM group_lesson
INNER JOIN ensemble
ON group_lesson.group_lesson_id=ensemble.group_lesson_id
AND start_time >= date_trunc('week', CURRENT_TIMESTAMP + interval '1 week')
AND start_time < date_trunc('week', CURRENT_TIMESTAMP + interval '2 week')

GROUP BY group_lesson.group_lesson_id, ensemble.genre, group_lesson.nr_of_places
ORDER BY "weekday", "genre";

/*List the three instruments with the lowest monthly rental fee.
For each instrument tell whether it is rented or available to rent.
Also tell when the next group lesson for each listed instrument is scheduled.*/
CREATE VIEW InstrumentsWithLowestFee AS
SELECT
i.type AS "instrument",
i.rent_per_month AS "rent/month",
group_lesson.start_time AS "next lesson",

CASE WHEN i.quantity_in_stock=0 THEN 'rented'
WHEN i.quantity_in_stock>0 THEN 'available for rent'
END AS statue

FROM instrument i
LEFT JOIN LATERAL (
    SELECT group_lesson.*
    FROM group_lesson
    WHERE  group_lesson.instrument_type = i.type AND
           group_lesson.start_time >= current_timestamp
    ORDER BY group_lesson.start_time
    limit 1
) lesson ON true
WHERE i.quantity_in_stock > 0
ORDER BY "rent/month"
limit 3;
