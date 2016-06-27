-- script to create accommodation office database
-- create 7/18/2012 JM

DROP TABLE next_of_kin CASCADE CONSTRAINTS;
DROP TABLE leases CASCADE CONSTRAINTS;
DROP TABLE program CASCADE CONSTRAINTS;
DROP TABLE student CASCADE CONSTRAINTS;
DROP TABLE inspection CASCADE CONSTRAINTS;
--DROP TABLE hall_room CASCADE CONSTRAINTS;
--DROP TABLE flat_room CASCADE CONSTRAINTS;
DROP TABLE flat CASCADE CONSTRAINTS;
DROP TABLE hall CASCADE CONSTRAINTS;
DROP TABLE room CASCADE CONSTRAINTS;
DROP TABLE advisor CASCADE CONSTRAINTS;
DROP TABLE accommodation_staff CASCADE CONSTRAINTS;

create table accommodation_staff
(
staff_id NUMBER(3),
L_name VARCHAR2(10) constraint accommodation_L_name_nn NOT NULL,
F_name VARCHAR2(10) constraint accommodation_F_name_nn NOT NULL,
sex CHAR constraint accommodation_staff_sex_cc check ((sex='M')or(sex='F')),
date_of_birth DATE,
address VARCHAR2(35),
position VARCHAR2(15),
location VARCHAR2(20),
constraint accommodation_staff_id_pk PRIMARY KEY(staff_id)
);

create table advisor
(
staff_id NUMBER(3),
department VARCHAR2(10),
room_number NUMBER(3),
telephone NUMBER(10),
constraint advisor_staff_id_fk FOREIGN KEY(staff_id) references accommodation_staff(staff_id),
constraint advisor_staff_id_pk PRIMARY KEY(staff_id)
);

create table flat
(
flat_id NUMBER(4),
address VARCHAR2(30) constraint flat_address_nn NOT NULL,
num_available NUMBER(4),
constraint flat_flat_id_pk PRIMARY KEY(flat_id)
);


create table hall
(
hall_id NUMBER(4),
name VARCHAR2(10) constraint hall_name_nn NOT NULL,
address VARCHAR2(30) constraint hall_address_nn NOT NULL,
telephone NUMBER(10),
manager_id NUMBER(3),
constraint hall_manager_id_fk FOREIGN KEY (manager_id) references accommodation_staff(staff_id),
constraint hall_hall_id_pk PRIMARY KEY(hall_id)
);

create table room
(
place_id NUMBER(4),
room_number VARCHAR2(4),
rent_fee NUMBER(4),
type VARCHAR2(4),
flat_id NUMBER(4), 
hall_id NUMBER(4),
constraint room_flat_id_fk FOREIGN KEY (flat_id) references flat(flat_id),
constraint room_hall_id_fk FOREIGN KEY (hall_id) references hall(hall_id),
constraint room_place_id_pk PRIMARY KEY(place_id)
);

create table inspection
(
flat_id NUMBER(4),
inspect_id NUMBER(3),
satisfactory VARCHAR2(3) constraint inspection_satisfactory_cc check ((satisfactory='Yes')or(satisfactory='No')),
date_inspect DATE,
constraint inspection_flat_id_fk FOREIGN KEY (flat_id) references flat(flat_id),
constraint inspection_inspector_id_fk FOREIGN KEY (inspect_id) references accommodation_staff(staff_id),
constraint inspection_flat_inspect_id_pk primary key(flat_id,inspect_id)
);

create table program
(
program_id NUMBER(3),
title VARCHAR2(20) constraint program_title_nn NOT NULL,
constraint program_program_id_pk primary key(program_id)
);


create table student
(
matriculation_no NUMBER(9),
l_name VARCHAR2(15) constraint student_name_nn NOT NULL,
f_name VARCHAR2(15) constraint student_Lastname_nn NOT NULL,
home_address VARCHAR2(30),
date_of_birth DATE,
sex CHAR constraint student_sex_cc check ((sex='M')or(sex='F')),
category VARCHAR2(3) constraint student_category_cc check ((category='1UG')or(category='2UG')or(category='3UG')or(category='4UG')or(category='PG')),
nationality VARCHAR2(15),
smoker VARCHAR2(3) constraint student_smoker_cc check ((smoker='Yes')or(smoker='No')),
special_needs VARCHAR2(30),
status VARCHAR2(8) constraint student_status_cc check ((status='placed')or(status='waiting')),
program_id NUMBER(3),
advisor_id NUMBER(3),
constraint student_program_id_fk FOREIGN KEY (program_id) references program(program_id),
constraint student_advisor_id_fk FOREIGN KEY (advisor_id) references accommodation_staff(staff_id),
constraint student_matriculation_no_pk PRIMARY KEY (matriculation_no)
);

create table next_of_kin
(
l_name VARCHAR2(15),
f_name VARCHAR2(15),
student_id NUMBER(9),
relationship VARCHAR2(15),
telephone NUMBER(10),
CONSTRAINT next_of_kin_student_id_fk FOREIGN KEY (student_id) references student(matriculation_no),
CONSTRAINT next_of_kin_name_student_id_pk PRIMARY KEY (l_name,f_name,student_id)
);


create table leases
(
lease_id NUMBER(5),
assistant_id NUMBER(3),
place_id NUMBER(4),
matriculation_no NUMBER(9),
lease_name VARCHAR2(20),
duration_semester NUMBER(1)
constraint leases_duration_semester_cc check ((duration_semester>=1)and(duration_semester<=3)),
enter_date DATE,
leave_date DATE,
CONSTRAINT leases_assistant_id_fk FOREIGN KEY (assistant_id) references accommodation_staff(staff_id),
CONSTRAINT leases_place_id_fk FOREIGN KEY (place_id) references room(place_id),
CONSTRAINT leases_matriculation_no_fk FOREIGN KEY (matriculation_no) references student(matriculation_no),
CONSTRAINT leases_lease_id_pk primary key(lease_id)
);


---inserting records into ACCOMMODATION_STAFF
INSERT into accommodation_staff values
(101,'Hurska','Kim','F',TO_DATE('05-23-82','MM/DD/YY'),'900 McGill Road, Kamloops','Hall Manager','hall');

INSERT into accommodation_staff values
(102,'Bornau','Ruth','F',TO_DATE('12-05-75','MM/DD/YY'),'559 West Pender Street, Vancouver','Assistant','accommodation office');

INSERT into accommodation_staff values
(103,'John','Peter','M',TO_DATE('07-29-60','MM/DD/YY'),'1055 West Hastings Street Vancouver','Advisor','university');

INSERT into accommodation_staff values
(104,'McGill','Scott','M',TO_DATE('12-12-81','MM/DD/YY'),'8388 Capstan Way, #1488 Richmond','Hall Manager','hall');

INSERT into accommodation_staff values
(105,'Lise','Albert','F',TO_DATE('03-14-80','MM/DD/YY'),'404 Wood St Whitehorse','Inspector','flat');

INSERT into accommodation_staff values
(106,'Font','Susan','F',TO_DATE('03-16-83','MM/DD/YY'),'100 West 49th Avenue, Vancouver','Advisor','university');

INSERT into accommodation_staff values
(107,'Chanoff','Toby','M',TO_DATE('12-09-79','MM/DD/YY'),'103 West 29th Avenue, Vancouver','Advisor','university');

INSERT into accommodation_staff values
(108,'Heather','Burt','F',TO_DATE('02-13-62','MM/DD/YY'),'8880 NO.5 Rd. Richmond','Cleaner','university');

INSERT into accommodation_staff values
(109,'Hedrik','Paul','M',TO_DATE('08-05-64','MM/DD/YY'),'103 Victoria Ave. Vancouver','Inspector','flat');

INSERT into accommodation_staff values
(110,'Wang','Brian','M',TO_DATE('09-28-68','MM/DD/YY'),'11590 Cambie Road, Richmond','Hall Manager','hall');

INSERT into accommodation_staff values
(111,'Elizabeth','Gladys','F',TO_DATE('07-16-70','MM/DD/YY'),'6428 Fraser Street, Vancouver','Assistant','accommodation office');

INSERT into accommodation_staff values
(112,'Zhang','Jack','M',TO_DATE('09-08-77','MM/DD/YY'),'5888 Cambie St, Vancouver','Inspector','flat');

INSERT into accommodation_staff values
(113,'Marry','Cathy','F',TO_DATE('06-20-67','MM/DD/YY'),'3096 Cambie Street, Vancouver','Assistant','accommodation office');

INSERT into accommodation_staff values
(114,'Zhao','Wilson','M',TO_DATE('05-18-90','MM/DD/YY'),'8219 Cambie Road, Richmond','Advisor','university');

---inserting records into ACCOMMODATION_STAFF
INSERT into advisor values
(103,'Computer Science',216,7782629087);

INSERT into advisor values
(106,'English',206,6048909976);

INSERT into advisor values
(107,'English',310,6045385678);

INSERT into advisor values
(114,'Fine Arts',227,7788289019);
