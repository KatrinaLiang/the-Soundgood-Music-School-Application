# Project-in-IV1351

The purpose is to facilitate information handling and business transactions for the Soundgood music school company, by developing an application which handles all the school's data and all its transactions.

1.1 Business Overview
Soundgood sells music lessons to students who want to learn to play an instrument. When someone wants to attend the school, they submit an application, specifying instrument and present skill. If there is room, the student is offered a place, which can be accepted or rejected. There is no concept like 'course' or sets of lessons. Instead, students continue to take lessons as long as they wish. Students pay per lesson and instructors are payed per given lesson.

1.2 Detailed Descriptions
Lesson
There are individual lessons and group lessons. A group lesson has a specified number of places (which may vary), and is not given unless a minimum number of students enroll. A lesson is given for a particular instrument and a particular level. There are three levels, beginner, intermediate and advanced, students have to audition to participate in advanced lessons. Besides lessons for a particular instrument, there are also ensembles, where students playing different instruments participate at the same lesson. Ensembles have a specific target genre (e.g., punk rock, gospel band), and there is a  maximum and minimum number of students also for ensembles.

Group lessons and ensembles are given at scheduled time slots. Individual lessons do not have a fixed schedule, but are rather to be seen as appointments, like for example an appointment with a dentist. Administrative staff must be able to make bookings, it must therefore be possible to understand which instructor is available when, and for which instruments, and to create a booking.

There is no concept like 'course' or sets of lessons, a student who has been offered a place, and accepted, continue to take lessons as long as desired, and can either book one lesson at the time or book many lessons during a longer time period.

Student
A student can take any number of lessons, for any number of instruments. For each student, the application must store person number, name, age, address, contact details and contact details for parents. It must also be possible to see which students are siblings, since there is a discount for siblings. There is a minimum age for students.

Instructor
An instructor can be assigned to group lessons and ensembles, and can also be available to give individual lessons during specified time periods. An instructor can teach a specified set of instruments, and may also be able to teach ensembles. For each instructor, the application must store person number, name, age, address and contact details. 

Student Enrollment
When someone wants to attend the school, they apply by submitting personal data (like name and contact details), which instrument (or ensemble) they apply for, and how skilled they are at playing that instrument. If there is a place available in the desired kind of lesson, the student is offered to participate. If the student wants to take lessons at the advanced level, it is required to audition before a place is granted. If there is no free place in the desired kind of lesson, there is the option to let soundgood keep the application, and be contacted if there later is a free place.

Administrative staff must be able to register student applications, make appointments for audition when required, register if the audition is passed or failed, and register whether the student is accepted or not.

Student Payment
Students are charged monthly for all lessons taken during the previous month. Currently, there is one price for beginner and intermediate levels, and another price for the advanced level. Also, there are different prices for individual and group lessons, and there is an extra charge for taking lessons on certain days (like Saturdays and Sundays). There is also a discount for siblings, if two or more siblings have taken lessons during the same month, they all get a certain percentage discount. Soundgood wants to have a high level of flexibility to change not just prices, but also pricing scheme. They might, for example, not always have the same price for beginner and intermediate lessons.

Instructor Payment
There are no instructors with fixed monthly salaries, instead they are payed monthly for all lessons given during the previous month. Instructor payments depend on the same things as student fees (see above), namely level of lesson, group or individual lesson, and whether the lesson was given on a more expensive day. Instructor payments are not affected by sibling discounts.

Renting Instruments
Soundgood offers students the ability to rent instruments to be delivered at their home. There is a wide selection of instruments, wind, string etc., supporting different brands and in different quantities in stock at the soundgood music school. Each student can rent up to two specific instruments at any given period, the renting happens with a lease up to 12 month period. Students can list and search current instruments and rent them if they don't exceed their two-instrument quota. Instruments are rented per month. The fee is payed the same way lessons are payed, each month students are charged for the instruments that where rented the previous month.

1.3 Requirements on the Soundgood Music School Application
The application must store all data described above, in sections 1.1 and 1.2, but no other data. It shall provide a user interface that can be used by administrative staff to manage student enrollments, auditions, bookings and payments. In addition, the application will also be used to retrieve reports and statistics of all possible kinds, but a user interface is not required for that purpose. It will instead be done by manually querying the data store.

The application will not be used for any financial purpose like bookkeeping, taxes or bank contacts. What is written above regarding student fees and instructor payments is only about calculating what sum shall be payed to or by who, and sending that information to Soundgood's financial system.
