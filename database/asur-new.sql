-- drop database sql12657868;
-- create database sql12657868;
use sql12657868;
DROP TABLE IF EXISTS attendance_details;
-- Create table attendance_details
CREATE TABLE attendance_details (
    Roll_No int NOT NULL,
    Subject_ID varchar(10) NOT NULL,
    Date_marked date NOT NULL,
    PorA varchar(5) DEFAULT NULL,
    Percentage double DEFAULT '0',
    PRIMARY KEY (Roll_No, Subject_ID, Date_marked),
    KEY index_date (Date_marked)
);
INSERT INTO attendance_details
VALUES (100, 'CCC708', '2023-09-11', 'A', 0),
    (100, 'CSD101', '2023-09-10', 'P', 0),
    (100, 'CSD101', '2023-09-11', 'A', 0),
    (100, 'CSD101', '2023-09-14', 'A', 0),
    (100, 'CSD102', '2023-09-11', 'P', 0),
    (100, 'CSD311', '2023-08-11', 'A', 0),
    (100, 'CSD311', '2023-08-12', 'P', 0),
    (100, 'MAT376', '2023-08-12', 'P', 0),
    (101, 'CSD101', '2023-09-10', 'P', 0),
    (101, 'CSD101', '2023-09-11', 'P', 0),
    (102, 'CSD101', '2023-09-10', 'P', 0),
    (103, 'CSD101', '2023-09-10', 'A', 0),
    (105, 'CSD101', '2023-09-10', 'A', 0);
--
-- Table structure for table classroom
DROP TABLE IF EXISTS classroom;
-- Create table classroom
CREATE TABLE classroom (
    Room_ID varchar(10) NOT NULL,
    centerX double DEFAULT NULL,
    centerY double DEFAULT NULL,
    Semi_Major_Axis double DEFAULT NULL,
    Semi_Minor_Axis double DEFAULT NULL,
    Altitude double DEFAULT NULL,
    Error double DEFAULT NULL,
    Capacity int DEFAULT NULL,
    PRIMARY KEY (Room_ID)
);
INSERT INTO classroom
VALUES (
        'D007',
        28.5254083,
        77.5755172,
        6.05,
        4,
        0,
        0,
        80
    );
--
-- Table structure for table student
--
DROP TABLE IF EXISTS student;
CREATE TABLE student (
    Roll_No int NOT NULL AUTO_INCREMENT,
    First_Name varchar(50) NOT NULL,
    Last_Name varchar(50) DEFAULT NULL,
    DOB date DEFAULT NULL,
    Picture_URL varchar(255) DEFAULT NULL,
    Net_ID varchar(10) NOT NULL,
    PRIMARY KEY (Roll_No)
);
INSERT INTO student
VALUES (
        100,
        'Rahul',
        'Kohli',
        '2002-11-05',
        'www.google.com',
        'rk123'
    ),
    (
        101,
        'Rahul',
        'Kohli',
        '2002-11-05',
        'www.google.com',
        'rk123'
    ),
    (
        102,
        'Rahul',
        'Gupta',
        '2002-11-05',
        NULL,
        'rk123'
    ),
    (
        103,
        'Aayush',
        'Arora',
        '2003-02-11',
        NULL,
        'undefined'
    ),
    (
        104,
        'Aayush',
        'Arora',
        '2003-02-11',
        NULL,
        'undefined'
    ),
    (
        105,
        'Aayush',
        'Arora',
        '2003-02-11',
        NULL,
        'aa373'
    ),
    (
        106,
        'Aayush',
        'Gupta',
        '2004-02-11',
        NULL,
        'aa921'
    ),
    (
        107,
        'Aayush',
        'Gupta',
        '2004-02-11',
        NULL,
        'aa921'
    ),
    (
        108,
        'Punyam',
        'Gupta',
        '2004-11-11',
        NULL,
        'pg987'
    ),
    (
        117,
        'Arnav',
        'Verma',
        '2001-12-11',
        NULL,
        'av234'
    );

--
DROP TABLE IF EXISTS subject;
CREATE TABLE subject (
    Subject_ID varchar(10) NOT NULL,
    Subject_Name varchar(50) NOT NULL,
    Classroom_ID varchar(10) NOT NULL,
    Teacher_ID varchar(10) NOT NULL,
    Start_Time time NOT NULL,
    End_Time time NOT NULL,
    Seats int DEFAULT NULL,
    LIVE enum('L', 'NL') DEFAULT 'NL',
    TeacherName varchar(30) DEFAULT NULL,
    PRIMARY KEY (Subject_ID),
    KEY index_start_time (Start_Time)
);
INSERT INTO subject
VALUES (
        'CCC708',
        'Genetic Engineering',
        'B012',
        'zJS104',
        '16:00:00',
        '17:00:00',
        60,
        'NL',
        'Deepak Sehgal'
    ),
    (
        'CSD101',
        'Intro to C',
        'D007',
        'zAS100',
        '09:00:00',
        '10:30:00',
        130,
        'NL',
        'Snehasis Mukherjee'
    ),
    (
        'CSD102',
        'Data Structures & Algo.',
        'C309',
        'zPT101',
        '10:30:00',
        '12:00:00',
        140,
        'NL',
        'Saurabh Shigwan'
    ),
    (
        'CSD311',
        'Artifical Intelligence',
        'B315',
        'zBL102',
        '14:00:00',
        '15:00:00',
        150,
        'NL',
        'Snehasis Mukherjee'
    ),
    (
        'MAT376',
        'Machine Learning - Hands on',
        'D313',
        'zRM103',
        '15:00:00',
        '16:00:00',
        60,
        'L',
        'Snehasis Mukherjee'
    );
--
-- Table structure for table studenttosubject
--
DROP TABLE IF EXISTS studenttosubject;
CREATE TABLE studenttosubject (
    Roll_No int NOT NULL,
    Subject_id varchar(10) NOT NULL,
    PRIMARY KEY (Roll_No, Subject_id),
    KEY Subject_id (Subject_id),
    FOREIGN KEY (Roll_No) REFERENCES student (Roll_No),
    FOREIGN KEY (Subject_id) REFERENCES subject (Subject_ID)
);
INSERT INTO studenttosubject
VALUES (108, 'CCC708'),
    (117, 'CCC708'),
    (108, 'CSD101'),
    (117, 'CSD101'),
    (108, 'CSD102'),
    (117, 'CSD102'),
    (108, 'CSD311'),
    (117, 'CSD311'),
    (108, 'MAT376'),
    (117, 'MAT376');
--
-- Table structure for table subject