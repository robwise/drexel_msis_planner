-- QUARTER Inserts
INSERT INTO QUARTER (ACADEMIC_YEAR, QUARTER_CODE) VALUES ('2012','15');
INSERT INTO QUARTER (ACADEMIC_YEAR, QUARTER_CODE) VALUES ('2012','25');
INSERT INTO QUARTER (ACADEMIC_YEAR, QUARTER_CODE) VALUES ('2012','35');
INSERT INTO QUARTER (ACADEMIC_YEAR, QUARTER_CODE) VALUES ('2012','45');
INSERT INTO QUARTER (ACADEMIC_YEAR, QUARTER_CODE) VALUES ('2013','15');
INSERT INTO QUARTER (ACADEMIC_YEAR, QUARTER_CODE) VALUES ('2013','25');
INSERT INTO QUARTER (ACADEMIC_YEAR, QUARTER_CODE) VALUES ('2013','35');
INSERT INTO QUARTER (ACADEMIC_YEAR, QUARTER_CODE) VALUES ('2013','45');
INSERT INTO QUARTER (ACADEMIC_YEAR, QUARTER_CODE) VALUES ('2014','15');
INSERT INTO QUARTER (ACADEMIC_YEAR, QUARTER_CODE) VALUES ('2014','25');
INSERT INTO QUARTER (ACADEMIC_YEAR, QUARTER_CODE) VALUES ('2014','35');
INSERT INTO QUARTER (ACADEMIC_YEAR, QUARTER_CODE) VALUES ('2014','45');
INSERT INTO QUARTER (ACADEMIC_YEAR, QUARTER_CODE) VALUES ('2015','15');
INSERT INTO QUARTER (ACADEMIC_YEAR, QUARTER_CODE) VALUES ('2015','25');
INSERT INTO QUARTER (ACADEMIC_YEAR, QUARTER_CODE) VALUES ('2015','35');
INSERT INTO QUARTER (ACADEMIC_YEAR, QUARTER_CODE) VALUES ('2015','45');

-- GRADE Inserts
INSERT INTO GRADE_STATUS (GRADE_STATUS, GPA_VALUE) VALUES ('A+', 4.0);
INSERT INTO GRADE_STATUS (GRADE_STATUS, GPA_VALUE) VALUES ('A' , 3.7);
INSERT INTO GRADE_STATUS (GRADE_STATUS, GPA_VALUE) VALUES ('A-', 3.4);
INSERT INTO GRADE_STATUS (GRADE_STATUS, GPA_VALUE) VALUES ('B+', 3.3);
INSERT INTO GRADE_STATUS (GRADE_STATUS, GPA_VALUE) VALUES ('B' , 3.0);
INSERT INTO GRADE_STATUS (GRADE_STATUS, GPA_VALUE) VALUES ('B-', 2.7);
INSERT INTO GRADE_STATUS (GRADE_STATUS, GPA_VALUE) VALUES ('C+', 2.3);
INSERT INTO GRADE_STATUS (GRADE_STATUS, GPA_VALUE) VALUES ('C' , 2.0);
INSERT INTO GRADE_STATUS (GRADE_STATUS, GPA_VALUE) VALUES ('C-', 1.7);
INSERT INTO GRADE_STATUS (GRADE_STATUS, GPA_VALUE) VALUES ('D+', 1.5);
INSERT INTO GRADE_STATUS (GRADE_STATUS, GPA_VALUE) VALUES ('D' , 1.0);
INSERT INTO GRADE_STATUS (GRADE_STATUS, GPA_VALUE) VALUES ('D-', 0.5);
INSERT INTO GRADE_STATUS (GRADE_STATUS, GPA_VALUE) VALUES ('F' , 0.0);
INSERT INTO GRADE_STATUS (GRADE_STATUS, GPA_VALUE) VALUES ('W' , NULL);
INSERT INTO GRADE_STATUS (GRADE_STATUS, GPA_VALUE) VALUES ('IP', NULL);
INSERT INTO GRADE_STATUS (GRADE_STATUS, GPA_VALUE) VALUES ('I' , NULL);

--DEGREE_REQUIREMENT Inserts
INSERT INTO DEGREE_REQUIREMENT (REQUIREMENT_NAME) VALUES ('REQUIRED');
INSERT INTO DEGREE_REQUIREMENT (REQUIREMENT_NAME) VALUES ('DISTRIBUTION');
INSERT INTO DEGREE_REQUIREMENT (REQUIREMENT_NAME) VALUES ('ELECTIVE');

--STUDENT Inserts
INSERT INTO STUDENT (STUDENT_ID,F_NAME,L_NAME,MID_INITIAL,STREET,
    CITY,STATE,ZIP,COUNTRY,GENDER,DOB)
VALUES ('LHP37','Lisa','Perez','H','P.O. Box 977, 8621 Lobortis, Rd.',
    'Bozeman','MT','18639','United States','F','12-Jan-2015');
--
INSERT INTO STUDENT (STUDENT_ID,F_NAME,L_NAME,MID_INITIAL,STREET,
    CITY,STATE,ZIP,COUNTRY,GENDER,DOB)
VALUES ('LUI90','Martha','Durham','T','6808 Risus. St.',
    'Idaho Falls','ID','93168','United States','M','20-May-2015');
--
INSERT INTO STUDENT (STUDENT_ID,F_NAME,L_NAME,MID_INITIAL,STREET,
    CITY,STATE,ZIP,COUNTRY,GENDER,DOB)
VALUES ('ZPC67','Kaitlin','Morris','B','5433 Interdum. Avenue',
    'Annapolis','MD','82514','United States','F','26-Sep-2014');
--
INSERT INTO STUDENT (STUDENT_ID,F_NAME,L_NAME,MID_INITIAL,STREET,
    CITY,STATE,ZIP,COUNTRY,GENDER,DOB)
VALUES ('WLC80','Kelsie','Mueller','I','122-6427 Mauris Street',
    'Helena','MT','79707','United States','M','05-Feb-2015');
--
INSERT INTO STUDENT (STUDENT_ID,F_NAME,L_NAME,MID_INITIAL,STREET,
    CITY,STATE,ZIP,COUNTRY,GENDER,DOB)
VALUES ('CTQ58','Nell','Santos','L','129-378 Fringilla, St.',
    'Bellevue','WA','19188','United States','M','16-Jun-2013');

-- INSTRUCTOR Inserts
INSERT INTO INSTRUCTOR (INSTRUCTOR_ID,F_NAME,L_NAME,MID_INITIAL,STREET,
    CITY,STATE,ZIP,COUNTRY,GENDER,DOB,AVAIL_NXT_QTR)
VALUES ('ONB81','Cain','Mcpherson','Y','Ap #837-4785 Vulputate, Av.',
    'New Orleans','LA','48503','United States','M','05-Dec-2013','N');
--
INSERT INTO INSTRUCTOR (INSTRUCTOR_ID,F_NAME,L_NAME,MID_INITIAL,STREET,
    CITY,STATE,ZIP,COUNTRY,GENDER,DOB,AVAIL_NXT_QTR)
VALUES ('UQK28','Eleanor','Nelson','V','Ap #491-8357 Tincidunt Rd.',
    'Baltimore','MD','51185','United States','F','14-May-2014','N');
--
INSERT INTO INSTRUCTOR (INSTRUCTOR_ID,F_NAME,L_NAME,MID_INITIAL,STREET,
    CITY,STATE,ZIP,COUNTRY,GENDER,DOB,AVAIL_NXT_QTR)
VALUES ('IVE64','Nolan','Avila','R','P.O. Box 672, 7248 Ornare. Avenue',
    'Kearney','NE','70548','United States','M','10-Dec-2014','Y');
--
INSERT INTO INSTRUCTOR (INSTRUCTOR_ID,F_NAME,L_NAME,MID_INITIAL,STREET,
    CITY,STATE,ZIP,COUNTRY,GENDER,DOB,AVAIL_NXT_QTR)
VALUES ('ZCA34','Kane','Juarez','Q','P.O. Box 300, 9868 Donec St.',
    'Miami','FL','20147','United States','F','08-Mar-2014','N');
--
INSERT INTO INSTRUCTOR (INSTRUCTOR_ID,F_NAME,L_NAME,MID_INITIAL,STREET,
    CITY,STATE,ZIP,COUNTRY,GENDER,DOB,AVAIL_NXT_QTR)
VALUES ('RQY56','Tarik','Warren','N','Ap #975-561 Tincidunt Street',
    'Aurora','IL','22533','United States','M','10-Sep-2013','N');

--COURSE_INFO Inserts
INSERT INTO COURSE_INFO (COURSE_NUMBER, COURSE_NAME, COURSE_DESCRIPTION, REQUIREMENT_NAME)
VALUES (530, 'Foundations of Information Systems', 'Introduction to concepts and applications of Information Systems (IS) and Information Technology (IT) as applied throughout library and information science. Topics include the structure of information systems, hardware and software concepts, basic principles of system analysis and design, and contemporary applications of computers in organizational environments.', 'REQUIRED');
INSERT INTO COURSE_INFO (COURSE_NUMBER, COURSE_NAME, COURSE_DESCRIPTION, REQUIREMENT_NAME)
VALUES (532, 'Software Development', 'Provides a hands-on introduction to software development. Includes programming concepts and a series of programming exercises done by students working in pairs or in small groups. Also covers general concepts and issues in software development to help students understand why creating high quality software is very difficult.', 'REQUIRED');
INSERT INTO COURSE_INFO (COURSE_NUMBER, COURSE_NAME, COURSE_DESCRIPTION, REQUIREMENT_NAME)
VALUES (552, 'Introduction to Web Design for Information Organizations', 'Introduction to creating websites that incorporate interactive web services to support users in information organizations. Students learn to establish websites that meet usability, accessibility and intellectual property standards, via composition of text and graphic files, and use of scripts for interactive application to support community information resource needs.', 'ELECTIVE');
INSERT INTO COURSE_INFO (COURSE_NUMBER, COURSE_NAME, COURSE_DESCRIPTION, REQUIREMENT_NAME)
VALUES (604, 'Object-Oriented Programming for Information Systems', 'This course provides a hands-on introduction to object-oriented programming language. The language will be a class-based object-oriented programming language in common usage in industry. The class will cover classes, objects, constructors and destructors, access control, inheritance, and use of object libraries and language specific features.', 'ELECTIVE');
INSERT INTO COURSE_INFO (COURSE_NUMBER, COURSE_NAME, COURSE_DESCRIPTION, REQUIREMENT_NAME)
VALUES (605, 'Introduction to Database Management', 'A first course in database management systems. Covers database design, data manipulation, and data-base integrity. Emphasizes concepts and techniques related to the entity-relationship model and relational database systems. Discusses normalization up to third normal form and commercial query languages.', 'REQUIRED');
INSERT INTO COURSE_INFO (COURSE_NUMBER, COURSE_NAME, COURSE_DESCRIPTION, REQUIREMENT_NAME)
VALUES (606, 'Advanced Database Management', 'Examines both traditional database systems and recent advances in database systems. Topics include formal treatment of normalization and denormalization, extended entity-relationship models, advanced query processing techniques, query optimization, physical database design and indexing, and object-oriented database systems.', 'DISTRIBUTION');
INSERT INTO COURSE_INFO (COURSE_NUMBER, COURSE_NAME, COURSE_DESCRIPTION, REQUIREMENT_NAME)
VALUES (607, 'Applied Database Technologies', 'Covers principles and techniques related to data warehousing and online analytic processing (OLAP) as well as advanced database programming. Discusses dimensional modeling, OLAP, aggregation, ETL, physical data warehouse design, optimization techniques such as partitioning, indexing, star schema query optimization, and materialized views. Advanced database programming includes stored procedures, functions, and triggers.', 'DISTRIBUTION');
INSERT INTO COURSE_INFO (COURSE_NUMBER, COURSE_NAME, COURSE_DESCRIPTION, REQUIREMENT_NAME)
VALUES (608, 'Human-Computer Interaction', 'Focuses on the physiological, psychological and engineering basis of design and evaluation of human-computer interfaces covering such topics as; theoretical foundation of HCI; cognitive modeling of user interactions; task analysis techniques for gathering design information; iterative design cycles; formative and summative usability testing; and project planning and report writing.', 'REQUIRED');
INSERT INTO COURSE_INFO (COURSE_NUMBER, COURSE_NAME, COURSE_DESCRIPTION, REQUIREMENT_NAME)
VALUES (610, 'Analysis of Interactive Systems', 'Examines current methods in the analysis of interactive systems. Topics address the rationale and practices associated with techniques for assessing and evaluating how well they fit social and institutional context of use. Provides opportunities for both hands-on analysis work and reflection on theoretical foundations of interactive-systems analysis.', 'DISTRIBUTION');
INSERT INTO COURSE_INFO (COURSE_NUMBER, COURSE_NAME, COURSE_DESCRIPTION, REQUIREMENT_NAME)
VALUES (611, 'Design of Interactive Systems', 'Examines current methods in the design of new interactive systems. Topics address the rationale and practices associated with techniques for assessing and modeling user and organizational needs, exploring design alternatives, communicating and justifying design choices, and prototyping designs. Provides opportunities for both hands-on design work and reflection on theoretical foundation of interactive systems design.', 'DISTRIBUTION');
INSERT INTO COURSE_INFO (COURSE_NUMBER, COURSE_NAME, COURSE_DESCRIPTION, REQUIREMENT_NAME)
VALUES (613, 'XML and Databases', 'Introduces background and basics of XML and XML Schema. Focuses on storing and extracting XML data in Relational Database Systems. Covers the process of modeling real-world problems in XML. Investigates native XML database management systems. Discusses current issues in XML and XML storage research.', 'DISTRIBUTION');
INSERT INTO COURSE_INFO (COURSE_NUMBER, COURSE_NAME, COURSE_DESCRIPTION, REQUIREMENT_NAME)
VALUES (614, 'Distributed Computing and Networking', 'Presents the fundamentals of data communications, networking, and distributed computing technologies. Focuses on the broad foundational coverage of key technologies as well as the key concepts in network planning, design, and management. Major topics include network models, data and voice communications, local-area and wide-area technologies, IP networks and their applications, internetworking (with an emphasis on the Internet), client/server systems, and distributed computing applications.', 'REQUIRED');
INSERT INTO COURSE_INFO (COURSE_NUMBER, COURSE_NAME, COURSE_DESCRIPTION, REQUIREMENT_NAME)
VALUES (620, 'Information Systems Analysis and Design', 'Offers an advanced treatment of systems analysis and design with special emphasis on object-oriented analysis and design techniques based on the Unified Modeling Language (UML). Discusses major modeling techniques of UML including use-case modeling, class modeling, object-interaction modeling, dynamic modeling and state diagrams and activity diagrams, subsystems developments, logical design, and physical design.', 'REQUIRED');
INSERT INTO COURSE_INFO (COURSE_NUMBER, COURSE_NAME, COURSE_DESCRIPTION, REQUIREMENT_NAME)
VALUES (627, 'Requirements Engineering and Management', 'Provides students with an opportunity to explore and experience methodologies, tools, and techniques for eliciting, analyzing, specifying, and managing requirements in modern software development organizations. Focuses on the intersection of requirements engineering, strategic IS and business planning, and business process reengineering. Students will also learn about change management in requirements engineering context in response to a fast-paced, changing world. Upon completion of the course, each student should have new skills and insights that are immediately applicable to the performance of the requirements engineering project function.', 'DISTRIBUTION');
INSERT INTO COURSE_INFO (COURSE_NUMBER, COURSE_NAME, COURSE_DESCRIPTION, REQUIREMENT_NAME)
VALUES (628, 'Information Systems Implementation', 'Addresses issues involved in implementing an information system in the context of a real organization, including ensuring quality in the delivered system. Focuses on the detailed design, coding, test, and distribution aspects of software system implementation.', 'DISTRIBUTION');
INSERT INTO COURSE_INFO (COURSE_NUMBER, COURSE_NAME, COURSE_DESCRIPTION, REQUIREMENT_NAME)
VALUES (629, 'Concepts in Artificial Intelligence', 'Introduces the concepts, principles, and techniques of artificial intelligence (AI), with emphasis on its application to information systems.', 'DISTRIBUTION');
INSERT INTO COURSE_INFO (COURSE_NUMBER, COURSE_NAME, COURSE_DESCRIPTION, REQUIREMENT_NAME)
VALUES (630, 'Evaluation of Information Systems', 'Focuses on the evaluation of software and software system development. Covers a variety of methodologies, techniques, and tools for measuring both software and software development attributes in modern software development organizations. Includes both graphical approaches for representing these attributes and statistical approaches for modeling various software relationships.', 'REQUIRED');
INSERT INTO COURSE_INFO (COURSE_NUMBER, COURSE_NAME, COURSE_DESCRIPTION, REQUIREMENT_NAME)
VALUES (631, 'Information Technology Integration', 'Focuses on integration of information technologies from an organizational perspective. Coverage includes IT Product and service selection and evaluation, impact of emerging technologies, standards, and vendor strategies. Emphasizes financial considerations including return on investment, time cost of money, depreciation, and system life.', 'DISTRIBUTION');
INSERT INTO COURSE_INFO (COURSE_NUMBER, COURSE_NAME, COURSE_DESCRIPTION, REQUIREMENT_NAME)
VALUES (634, 'Data Mining', 'This course introduces the concepts and principles of knowledge discovery in databases (KDD), with a focus on the techniques of data mining and its function in business, governmental, medical or other information-intensive environments.', 'DISTRIBUTION');
INSERT INTO COURSE_INFO (COURSE_NUMBER, COURSE_NAME, COURSE_DESCRIPTION, REQUIREMENT_NAME)
VALUES (636, 'Software Engineering Process I', 'Focuses on behaviors and activities of individuals developing software with a disciplined software engineering approach. Provides hands-on experience in which students complete programming exercises using a defined software engineering process. Requires students to plan, estimate, measure, and analyze their work, and to define, analyze, and improve development processes and create process documentation.', 'DISTRIBUTION');
INSERT INTO COURSE_INFO (COURSE_NUMBER, COURSE_NAME, COURSE_DESCRIPTION, REQUIREMENT_NAME)
VALUES (637, 'Software Engineering Process II', 'Focuses on behaviors and activities of teams developing software with a disciplined software engineering approach. Provides hands-on experience in which students complete team activities using a defined software engineering process. Covers topics including planning and estimating for team projects, reviews and inspections, standards, software reuse, and configuration management.', 'DISTRIBUTION');
INSERT INTO COURSE_INFO (COURSE_NUMBER, COURSE_NAME, COURSE_DESCRIPTION, REQUIREMENT_NAME)
VALUES (638, 'Software Project Management', 'Focuses on first-line management of software system development. Covers major themes including estimation (software cost factors, estimation models, and risk management), planning (work breakdown, scheduling, staffing, resource allocation, and creation of a project plan), and execution (team building, leadership, motivation, process tracking, control recovery, and communication within and outside the project).', 'REQUIRED');
INSERT INTO COURSE_INFO (COURSE_NUMBER, COURSE_NAME, COURSE_DESCRIPTION, REQUIREMENT_NAME)
VALUES (646, 'Information Systems Management', 'Addresses information technology-enabled change and policy issues in the management of information systems (IS). Stresses systems development, staffing and organization, technology infrastructure, project selection, justification and funding, and data. Studies the issues and their resolution in the context of an IS plan. Emphasizes communication about the issues to senior management.', 'REQUIRED');
INSERT INTO COURSE_INFO (COURSE_NUMBER, COURSE_NAME, COURSE_DESCRIPTION, REQUIREMENT_NAME)
VALUES (655, 'Intro to Web Programming', 'Provides a hands-on workshop in programming for Internet information systems using an appropriate programming language (Java is used currently). Covers fundamental concepts such as object-oriented programming, client-server programming, multi-threaded programming, graphical user interface design, and application development.', 'ELECTIVE');
INSERT INTO COURSE_INFO (COURSE_NUMBER, COURSE_NAME, COURSE_DESCRIPTION, REQUIREMENT_NAME)
VALUES (656, 'Internet Information Systems II', 'This course provides additional design and programming skills for the development of Internet information systems with an emphasis in server-side programming. It covers various web servers, applications servers, and other server technologies, as well as tools and methods for creating dynamic web-based information systems. It discusses issues related to the development of server-based information on the web.', 'ELECTIVE');
INSERT INTO COURSE_INFO (COURSE_NUMBER, COURSE_NAME, COURSE_DESCRIPTION, REQUIREMENT_NAME)
VALUES (712, 'Information Assurance', 'Describes how to protect an organization''s information resources and assets within national and international context. Topics include organizational policies and assurance requirements, relationships between assurance and security, and information assurance planning assessment and management.', 'DISTRIBUTION');

--SECTION Inserts
INSERT INTO SECTION (ACADEMIC_YEAR, QUARTER_CODE, COURSE_NUMBER, SECTION_NUMBER,
    IS_ONLINE, LOC_ROOM_NUMBER, DAY_OF_WEEK, START_HOUR, START_MINUTE, END_HOUR, END_MINUTE, INSTRUCTOR_ID, CAPACITY)
VALUES (2013,15,530,901,'Y',NULL,NULL,NULL,NULL,NULL,NULL,'UQK28',25);
INSERT INTO SECTION (ACADEMIC_YEAR, QUARTER_CODE, COURSE_NUMBER, SECTION_NUMBER,
    IS_ONLINE, LOC_ROOM_NUMBER, DAY_OF_WEEK, START_HOUR, START_MINUTE, END_HOUR, END_MINUTE, INSTRUCTOR_ID, CAPACITY)
VALUES (2013,15,532,901,'Y',NULL,NULL,NULL,NULL,NULL,NULL,'UQK28',35);
INSERT INTO SECTION (ACADEMIC_YEAR, QUARTER_CODE, COURSE_NUMBER, SECTION_NUMBER,
    IS_ONLINE, LOC_ROOM_NUMBER, DAY_OF_WEEK, START_HOUR, START_MINUTE, END_HOUR, END_MINUTE, INSTRUCTOR_ID, CAPACITY)
VALUES (2013,15,605,901,'Y',NULL,NULL,NULL,NULL,NULL,NULL,'IVE64',25);
INSERT INTO SECTION (ACADEMIC_YEAR, QUARTER_CODE, COURSE_NUMBER, SECTION_NUMBER,
    IS_ONLINE, LOC_ROOM_NUMBER, DAY_OF_WEEK, START_HOUR, START_MINUTE, END_HOUR, END_MINUTE, INSTRUCTOR_ID, CAPACITY)
VALUES (2013,25,608,901,'Y',NULL,NULL,NULL,NULL,NULL,NULL,'ONB81',16);
INSERT INTO SECTION (ACADEMIC_YEAR, QUARTER_CODE, COURSE_NUMBER, SECTION_NUMBER,
    IS_ONLINE, LOC_ROOM_NUMBER, DAY_OF_WEEK, START_HOUR, START_MINUTE, END_HOUR, END_MINUTE, INSTRUCTOR_ID, CAPACITY)
VALUES (2013,25,604,001,'N','RUSH 209','Tue',6,30,9,30,'UQK28',40);
INSERT INTO SECTION (ACADEMIC_YEAR, QUARTER_CODE, COURSE_NUMBER, SECTION_NUMBER,
    IS_ONLINE, LOC_ROOM_NUMBER, DAY_OF_WEEK, START_HOUR, START_MINUTE, END_HOUR, END_MINUTE, INSTRUCTOR_ID, CAPACITY)
VALUES (2013,25,614,001,'N','RUSH 009','Wed',6,00,9,00,'UQK28',200);
INSERT INTO SECTION (ACADEMIC_YEAR, QUARTER_CODE, COURSE_NUMBER, SECTION_NUMBER,
    IS_ONLINE, LOC_ROOM_NUMBER, DAY_OF_WEEK, START_HOUR, START_MINUTE, END_HOUR, END_MINUTE, INSTRUCTOR_ID, CAPACITY)
VALUES (2013,35,606,001,'N','RUSH 007','Wed',6,00,9,00,'IVE64',25);
INSERT INTO SECTION (ACADEMIC_YEAR, QUARTER_CODE, COURSE_NUMBER, SECTION_NUMBER,
    IS_ONLINE, LOC_ROOM_NUMBER, DAY_OF_WEEK, START_HOUR, START_MINUTE, END_HOUR, END_MINUTE, INSTRUCTOR_ID, CAPACITY)
VALUES (2013,35,620,901,'Y',NULL,NULL,NULL,NULL,NULL,NULL,'ONB81',25);
INSERT INTO SECTION (ACADEMIC_YEAR, QUARTER_CODE, COURSE_NUMBER, SECTION_NUMBER,
    IS_ONLINE, LOC_ROOM_NUMBER, DAY_OF_WEEK, START_HOUR, START_MINUTE, END_HOUR, END_MINUTE, INSTRUCTOR_ID)
VALUES (2014,45,530,001,'N','009','Mon',18,50,21,15,'ONB81');
INSERT INTO SECTION (ACADEMIC_YEAR, QUARTER_CODE, COURSE_NUMBER, SECTION_NUMBER,
    IS_ONLINE, LOC_ROOM_NUMBER, DAY_OF_WEEK, START_HOUR, START_MINUTE, END_HOUR, END_MINUTE, INSTRUCTOR_ID)
VALUES (2013,25,530,001,'N','209','Thu',18,50,21,15,'IVE64');
INSERT INTO SECTION (ACADEMIC_YEAR, QUARTER_CODE, COURSE_NUMBER, SECTION_NUMBER,
    IS_ONLINE, LOC_ROOM_NUMBER, DAY_OF_WEEK, START_HOUR, START_MINUTE, END_HOUR, END_MINUTE, INSTRUCTOR_ID)
VALUES (2013,35,627,001,'N','209','Thu',18,30,21,00,'UQK28');
INSERT INTO SECTION (ACADEMIC_YEAR, QUARTER_CODE, COURSE_NUMBER, SECTION_NUMBER,
    IS_ONLINE, LOC_ROOM_NUMBER, DAY_OF_WEEK, START_HOUR, START_MINUTE, END_HOUR, END_MINUTE, INSTRUCTOR_ID)
VALUES (2013,45,552,901,'N','014','Thu',18,00,22,50,'ONB81');
INSERT INTO SECTION (ACADEMIC_YEAR, QUARTER_CODE, COURSE_NUMBER, SECTION_NUMBER,
    IS_ONLINE, LOC_ROOM_NUMBER, DAY_OF_WEEK, START_HOUR, START_MINUTE, END_HOUR, END_MINUTE, INSTRUCTOR_ID)
VALUES (2013,35,634,901,'N','014','Thu',18,15,21,00, 'ZCA34');
INSERT INTO SECTION (ACADEMIC_YEAR, QUARTER_CODE, COURSE_NUMBER, SECTION_NUMBER,
    IS_ONLINE, LOC_ROOM_NUMBER, DAY_OF_WEEK, START_HOUR, START_MINUTE, END_HOUR, END_MINUTE, INSTRUCTOR_ID)
VALUES (2015,25,552,901,'N','009','Wed',18,15,21,00, 'ZCA34');
INSERT INTO SECTION (ACADEMIC_YEAR, QUARTER_CODE, COURSE_NUMBER, SECTION_NUMBER,
    IS_ONLINE, LOC_ROOM_NUMBER, DAY_OF_WEEK, START_HOUR, START_MINUTE, END_HOUR, END_MINUTE, INSTRUCTOR_ID)
VALUES (2012,25,608,001,'N','213','Tue',18,45,21,30,'UQK28');
INSERT INTO SECTION (ACADEMIC_YEAR, QUARTER_CODE, COURSE_NUMBER, SECTION_NUMBER,
    IS_ONLINE, LOC_ROOM_NUMBER, DAY_OF_WEEK, START_HOUR, START_MINUTE, END_HOUR, END_MINUTE, INSTRUCTOR_ID)
VALUES (2012,25,627,001,'N','213','Mon',18,45,21,30, 'ZCA34');
INSERT INTO SECTION (ACADEMIC_YEAR, QUARTER_CODE, COURSE_NUMBER, SECTION_NUMBER,
    IS_ONLINE, LOC_ROOM_NUMBER, DAY_OF_WEEK, START_HOUR, START_MINUTE, END_HOUR, END_MINUTE, INSTRUCTOR_ID)
VALUES (2012,35,627,001,'N','209','Tue',18,50,21,30,'IVE64');
INSERT INTO SECTION (ACADEMIC_YEAR, QUARTER_CODE, COURSE_NUMBER, SECTION_NUMBER,
    IS_ONLINE, LOC_ROOM_NUMBER, DAY_OF_WEEK, START_HOUR, START_MINUTE, END_HOUR, END_MINUTE, INSTRUCTOR_ID)
VALUES (2012,45,627,001,'N','213','Tue',18,00,20,50,'ONB81');
INSERT INTO SECTION (ACADEMIC_YEAR, QUARTER_CODE, COURSE_NUMBER, SECTION_NUMBER,
    IS_ONLINE, LOC_ROOM_NUMBER, DAY_OF_WEEK, START_HOUR, START_MINUTE, END_HOUR, END_MINUTE, INSTRUCTOR_ID)
VALUES (2014,45,627,001,'N','213','Tue',18,00,20,50,'IVE64');
INSERT INTO SECTION (ACADEMIC_YEAR, QUARTER_CODE, COURSE_NUMBER, SECTION_NUMBER,
    IS_ONLINE, LOC_ROOM_NUMBER, DAY_OF_WEEK, START_HOUR, START_MINUTE, END_HOUR, END_MINUTE, INSTRUCTOR_ID)
VALUES (2014,35,627,001,'N','213','Tue',18,00,20,50,'UQK28');
INSERT INTO SECTION (ACADEMIC_YEAR, QUARTER_CODE, COURSE_NUMBER, SECTION_NUMBER,
    IS_ONLINE, LOC_ROOM_NUMBER, DAY_OF_WEEK, START_HOUR, START_MINUTE, END_HOUR,
    END_MINUTE, INSTRUCTOR_ID, CAPACITY)
VALUES (2014,15,552,901,'Y',NULL,NULL,NULL,NULL,NULL,NULL,'UQK28',25);
INSERT INTO SECTION (ACADEMIC_YEAR, QUARTER_CODE, COURSE_NUMBER, SECTION_NUMBER,
    IS_ONLINE, LOC_ROOM_NUMBER, DAY_OF_WEEK, START_HOUR, START_MINUTE, END_HOUR,
    END_MINUTE, INSTRUCTOR_ID, CAPACITY)
VALUES (2014,15,655,901,'Y',NULL,NULL,NULL,NULL,NULL,NULL,'UQK28',25);
INSERT INTO SECTION (ACADEMIC_YEAR, QUARTER_CODE, COURSE_NUMBER, SECTION_NUMBER,
    IS_ONLINE, LOC_ROOM_NUMBER, DAY_OF_WEEK, START_HOUR, START_MINUTE, END_HOUR,
    END_MINUTE, INSTRUCTOR_ID, CAPACITY)
VALUES (2014,15,656,901,'Y',NULL,NULL,NULL,NULL,NULL,NULL,'UQK28',25);


--REGISTERED_SECTION Inserts
INSERT INTO REGISTERED_SECTION (ACADEMIC_YEAR, QUARTER_CODE, COURSE_NUMBER,
    SECTION_NUMBER, STUDENT_ID, GRADE_STATUS)
VALUES (2013,15,530,900,'LHP37','A');
INSERT INTO REGISTERED_SECTION (ACADEMIC_YEAR, QUARTER_CODE, COURSE_NUMBER,
    SECTION_NUMBER, STUDENT_ID, GRADE_STATUS)
VALUES (2013,15,532,900,'LHP37','W');
INSERT INTO REGISTERED_SECTION (ACADEMIC_YEAR, QUARTER_CODE, COURSE_NUMBER,
    SECTION_NUMBER, STUDENT_ID, GRADE_STATUS)
VALUES (2013,15,605,900,'LHP37','C');
INSERT INTO REGISTERED_SECTION (ACADEMIC_YEAR, QUARTER_CODE, COURSE_NUMBER,
    SECTION_NUMBER, STUDENT_ID, GRADE_STATUS)
VALUES (2013,25,604,001,'LHP37','D');
INSERT INTO REGISTERED_SECTION (ACADEMIC_YEAR, QUARTER_CODE, COURSE_NUMBER,
    SECTION_NUMBER, STUDENT_ID, GRADE_STATUS)
VALUES (2013,25,608,900,'LHP37','I');
INSERT INTO REGISTERED_SECTION (ACADEMIC_YEAR, QUARTER_CODE, COURSE_NUMBER,
    SECTION_NUMBER, STUDENT_ID, GRADE_STATUS)
VALUES (2013,25,614,001,'LHP37','A');
INSERT INTO REGISTERED_SECTION (ACADEMIC_YEAR, QUARTER_CODE, COURSE_NUMBER,
    SECTION_NUMBER, STUDENT_ID, GRADE_STATUS)
VALUES (2013,35,606,001,'LHP37','IP');
INSERT INTO REGISTERED_SECTION (ACADEMIC_YEAR, QUARTER_CODE, COURSE_NUMBER,
    SECTION_NUMBER, STUDENT_ID, GRADE_STATUS)
VALUES (2013,35,620,900,'LHP37','IP');
INSERT INTO REGISTERED_SECTION (ACADEMIC_YEAR, QUARTER_CODE, COURSE_NUMBER,
    SECTION_NUMBER, STUDENT_ID, GRADE_STATUS)
VALUES (2013,15,530,900,'LUI90','C');
INSERT INTO REGISTERED_SECTION (ACADEMIC_YEAR, QUARTER_CODE, COURSE_NUMBER,
    SECTION_NUMBER, STUDENT_ID, GRADE_STATUS)
VALUES (2013,15,530,900,'ZPC67','D');
INSERT INTO REGISTERED_SECTION (ACADEMIC_YEAR, QUARTER_CODE, COURSE_NUMBER,
    SECTION_NUMBER, STUDENT_ID, GRADE_STATUS)
VALUES (2013,15,530,900,'WLC80','B');

--COREQUISITE Inserts
INSERT INTO COREQUISITE (COREQUISITE, REQUIRED_BY)
VALUES (530, 605);
INSERT INTO COREQUISITE (COREQUISITE, REQUIRED_BY)
VALUES (620, 607);
INSERT INTO COREQUISITE (COREQUISITE, REQUIRED_BY)
VALUES (530, 608);
INSERT INTO COREQUISITE (COREQUISITE, REQUIRED_BY)
VALUES (530, 614);
INSERT INTO COREQUISITE (COREQUISITE, REQUIRED_BY)
VALUES (620, 627);

--PREREQUISITE Inserts
INSERT INTO PREREQUISITE (PREREQUISITE, REQUIRED_BY)
VALUES (532, 604);
INSERT INTO PREREQUISITE (PREREQUISITE, REQUIRED_BY)
VALUES (532, 606);
INSERT INTO PREREQUISITE (PREREQUISITE, REQUIRED_BY)
VALUES (605, 606);
INSERT INTO PREREQUISITE (PREREQUISITE, REQUIRED_BY)
VALUES (606, 607);
INSERT INTO PREREQUISITE (PREREQUISITE, REQUIRED_BY)
VALUES (608, 610);
INSERT INTO PREREQUISITE (PREREQUISITE, REQUIRED_BY)
VALUES (608, 611);
INSERT INTO PREREQUISITE (PREREQUISITE, REQUIRED_BY)
VALUES (604, 613);
INSERT INTO PREREQUISITE (PREREQUISITE, REQUIRED_BY)
VALUES (605, 613);
INSERT INTO PREREQUISITE (PREREQUISITE, REQUIRED_BY)
VALUES (605, 620);
INSERT INTO PREREQUISITE (PREREQUISITE, REQUIRED_BY)
VALUES (608, 620);
INSERT INTO PREREQUISITE (PREREQUISITE, REQUIRED_BY)
VALUES (620, 628);
INSERT INTO PREREQUISITE (PREREQUISITE, REQUIRED_BY)
VALUES (620, 630);
INSERT INTO PREREQUISITE (PREREQUISITE, REQUIRED_BY)
VALUES (530, 631);
INSERT INTO PREREQUISITE (PREREQUISITE, REQUIRED_BY)
VALUES (532, 631);
INSERT INTO PREREQUISITE (PREREQUISITE, REQUIRED_BY)
VALUES (605, 631);
INSERT INTO PREREQUISITE (PREREQUISITE, REQUIRED_BY)
VALUES (614, 631);
INSERT INTO PREREQUISITE (PREREQUISITE, REQUIRED_BY)
VALUES (605, 634);
INSERT INTO PREREQUISITE (PREREQUISITE, REQUIRED_BY)
VALUES (629, 634);
INSERT INTO PREREQUISITE (PREREQUISITE, REQUIRED_BY)
VALUES (532, 636);
INSERT INTO PREREQUISITE (PREREQUISITE, REQUIRED_BY)
VALUES (630, 636);
INSERT INTO PREREQUISITE (PREREQUISITE, REQUIRED_BY)
VALUES (638, 636);
INSERT INTO PREREQUISITE (PREREQUISITE, REQUIRED_BY)
VALUES (636, 637);
INSERT INTO PREREQUISITE (PREREQUISITE, REQUIRED_BY)
VALUES (630, 638);
INSERT INTO PREREQUISITE (PREREQUISITE, REQUIRED_BY)
VALUES (620, 646);
INSERT INTO PREREQUISITE (PREREQUISITE, REQUIRED_BY)
VALUES (532, 655);
INSERT INTO PREREQUISITE (PREREQUISITE, REQUIRED_BY)
VALUES (530, 712);

-- FEEDBACK Inserts
INSERT INTO FEEDBACK (ACADEMIC_YEAR,QUARTER_CODE,COURSE_NUMBER,SECTION_NUMBER,FEEDBACK_ID,
    FEEDBACK_CONTENT,RATING)
VALUES (2014,45,530,001,1,'The first part of class was sort of like systems analysis rather than DB. Only later we started real SQL. He makes the material fun and well presented. Some of the test questions were unexpected, but appropriate curve was used later. Group project was meaningful and rewarding. You don''t have to come to class, but that would work against you in the end. The professor was very much available for consultations and provided feedback whenever necessary. Overall a very good Database introductory class and a really nice teacher.',4);
INSERT INTO FEEDBACK (ACADEMIC_YEAR,QUARTER_CODE,COURSE_NUMBER,SECTION_NUMBER,FEEDBACK_ID,
    FEEDBACK_CONTENT,RATING)
VALUES (2013,25,530,001,2,'Good class, except for group project. Had 2 members who didn''t bother to do anything and had to do all their work in order to get a good grade. Prof is good, knows her stuff and is willing to help you if you don''t know things. Love the discussion set up, she divides it into small groups so you don''t have to read a thousand posts each week.',4);
INSERT INTO FEEDBACK (ACADEMIC_YEAR,QUARTER_CODE,COURSE_NUMBER,SECTION_NUMBER,FEEDBACK_ID,
    FEEDBACK_CONTENT,RATING)
VALUES (2013,35,627,001,3,'The professor is very interested in students understanding the topics. Puts extra effort in explaining topics. Makes class very fun that you''ll never think of missing her class. She is one my best instructors so far. I liked her class, definitely retake her.',5);
INSERT INTO FEEDBACK (ACADEMIC_YEAR,QUARTER_CODE,COURSE_NUMBER,SECTION_NUMBER,FEEDBACK_ID,
    FEEDBACK_CONTENT,RATING)
VALUES (2013,45,552,001,4,'Very fair at grading, and understanding when students need a bit more time to grasp ideas. I took this as an online course, and he wasn''t very "present" on the discussion boards. Many times it took more than a week to get answers to questions. He did however allow students to pre-submit the final so he could make sure students were at least headed in the right direction. He also provides audio files to go along with text books chapter, which helped tremendously.',4);
INSERT INTO FEEDBACK (ACADEMIC_YEAR,QUARTER_CODE,COURSE_NUMBER,SECTION_NUMBER,FEEDBACK_ID,
    FEEDBACK_CONTENT,RATING)
VALUES (2013,35,620,900,5,'The hardest class I have ever taken but the professor has the ability to keep you motivated throughout the term. My final group project ended up being 48 pages long which made me realize how much I had learned from this course.',3);
INSERT INTO FEEDBACK (ACADEMIC_YEAR,QUARTER_CODE,COURSE_NUMBER,SECTION_NUMBER,FEEDBACK_ID,
    FEEDBACK_CONTENT,RATING)
VALUES (2012,25,608,001,6,'The course seemed impossible at first, because the professor doesn''t teach the material you need to know to do the homework. Furthermore, the book is useless.',2);
INSERT INTO FEEDBACK (ACADEMIC_YEAR,QUARTER_CODE,COURSE_NUMBER,SECTION_NUMBER,FEEDBACK_ID,
    FEEDBACK_CONTENT,RATING)
VALUES (2012,35,627,001,7,'The professor as a teacher is about average. He makes class interesting and makes some jokes but the information comes out all garbled. He gets off-track with what he teaches(In info 102 we spend most of the course not learning the material and learning how to use a VB code to automatically generate tables that never worked.) All his stuff is in a lab setting, which is nice. However, if you aren’t interested info it never really seems to stick.(Case in point Python codes)',2);
INSERT INTO FEEDBACK (ACADEMIC_YEAR,QUARTER_CODE,COURSE_NUMBER,SECTION_NUMBER,FEEDBACK_ID,
    FEEDBACK_CONTENT,RATING)
VALUES (2012,35,627,001,8,'Never programmed prior to his class, but came out of the class extremely confident in my skills.  Programming doesn''t sink in right away, and the professor knows that, but his lecture/lab setup is designed so that by week 4, everything starts to click. He is very approachable after class.',4);
INSERT INTO FEEDBACK (ACADEMIC_YEAR,QUARTER_CODE,COURSE_NUMBER,SECTION_NUMBER,FEEDBACK_ID,
    FEEDBACK_CONTENT,RATING)
VALUES (2012,35,627,001,9,'The professor is definitely one of the best teachers I have ever had. He has extensive knowledge of the course materials, and relates it to the business and industry world for further understanding. He truly cares about his students, and makes class very entertaining which creates a positive learning environment. The work load is balanced and effective, and he''s just a great teacher, period. Anyone who says otherwise definitely failed to pay attention and apply themselves to the class.',5);
INSERT INTO FEEDBACK (ACADEMIC_YEAR,QUARTER_CODE,COURSE_NUMBER,SECTION_NUMBER,FEEDBACK_ID,
    FEEDBACK_CONTENT,RATING)
VALUES (2012,45,627,001,10,'Wretched experience with this online course. The group project was poorly explained with regard to the handouts provided. Questions to the instructor took 2-3 days to get a response in some cases, and were a re-writing of the student''s question, causing you to rephrase the initial question in order to drag out a response. Comments to student postings were few and far between, and generally provided at the end of each week. Students who are not relatively familiar with the subject material prior to taking the class might want to consider getting the book and reading it ahead of time.',2);

-- SYLLABUS Inserts
INSERT INTO SYLLABUS (COURSE_NUMBER,SYLLABUS_ID,CONTENT) VALUES (530,1,(UTL_RAW.cast_to_raw ('Sample syllabus text')));
INSERT INTO SYLLABUS (COURSE_NUMBER,SYLLABUS_ID,CONTENT) VALUES (552,1,(UTL_RAW.cast_to_raw ('Sample syllabus text')));
INSERT INTO SYLLABUS (COURSE_NUMBER,SYLLABUS_ID,CONTENT) VALUES (604,1,(UTL_RAW.cast_to_raw ('Sample syllabus text')));
INSERT INTO SYLLABUS (COURSE_NUMBER,SYLLABUS_ID,CONTENT) VALUES (605,1,(UTL_RAW.cast_to_raw ('Sample syllabus text')));
INSERT INTO SYLLABUS (COURSE_NUMBER,SYLLABUS_ID,CONTENT) VALUES (607,1,(UTL_RAW.cast_to_raw ('Sample syllabus text')));
INSERT INTO SYLLABUS (COURSE_NUMBER,SYLLABUS_ID,CONTENT) VALUES (608,1,(UTL_RAW.cast_to_raw ('Sample syllabus text')));
INSERT INTO SYLLABUS (COURSE_NUMBER,SYLLABUS_ID,CONTENT) VALUES (614,1,(UTL_RAW.cast_to_raw ('Sample syllabus text')));
INSERT INTO SYLLABUS (COURSE_NUMBER,SYLLABUS_ID,CONTENT) VALUES (620,1,(UTL_RAW.cast_to_raw ('Sample syllabus text')));
INSERT INTO SYLLABUS (COURSE_NUMBER,SYLLABUS_ID,CONTENT) VALUES (629,1,(UTL_RAW.cast_to_raw ('Sample syllabus text')));

-- COURSE OBJECTIVE Inserts
INSERT INTO COURSE_OBJECTIVES (COURSE_NUMBER,SYLLABUS_ID,OBJECTIVE_ID,OBJECTIVE_DESCRIPTION)
VALUES (530,1,1,'Investigate the complex problems and IS opportunities of real-world organizations, to analyze requirements for information systems change');
INSERT INTO COURSE_OBJECTIVES (COURSE_NUMBER,SYLLABUS_ID,OBJECTIVE_ID,OBJECTIVE_DESCRIPTION)
VALUES (530,1,2,'Appreciate various methods by which business requirements for change may be converted into working, maintainable information systems');
INSERT INTO COURSE_OBJECTIVES (COURSE_NUMBER,SYLLABUS_ID,OBJECTIVE_ID,OBJECTIVE_DESCRIPTION)
VALUES (530,1,3,'Use specialized techniques for information technology (IT) requirements elicitation, modeling and analysis, to produce a software requirements specification ');
INSERT INTO COURSE_OBJECTIVES (COURSE_NUMBER,SYLLABUS_ID,OBJECTIVE_ID,OBJECTIVE_DESCRIPTION)
VALUES (552,1,1,'Make better development decisions by understanding the relationship between IT strategy and business value');
INSERT INTO COURSE_OBJECTIVES (COURSE_NUMBER,SYLLABUS_ID,OBJECTIVE_ID,OBJECTIVE_DESCRIPTION)
VALUES (552,1,2,'Identify opportunities for IT-enabled business innovation');
INSERT INTO COURSE_OBJECTIVES (COURSE_NUMBER,SYLLABUS_ID,OBJECTIVE_ID,OBJECTIVE_DESCRIPTION)
VALUES (552,1,3,'Develop a technology roadmap and an accompanying financial justification, that links IT strategy to IT architecture and infrastructure');
INSERT INTO COURSE_OBJECTIVES (COURSE_NUMBER,SYLLABUS_ID,OBJECTIVE_ID,OBJECTIVE_DESCRIPTION)
VALUES (552,1,4,'Plan for IS processes and resources across multiple applications and projects');

-- ABLE_TO_TEACH Inserts
INSERT INTO ABLE_TO_TEACH (COURSE_NUMBER,INSTRUCTOR_ID)
VALUES (530,'IVE64');
INSERT INTO ABLE_TO_TEACH (COURSE_NUMBER,INSTRUCTOR_ID)
VALUES (532,'IVE64');
INSERT INTO ABLE_TO_TEACH (COURSE_NUMBER,INSTRUCTOR_ID)
VALUES (608,'IVE64');
INSERT INTO ABLE_TO_TEACH (COURSE_NUMBER,INSTRUCTOR_ID)
VALUES (530,'ONB81');
INSERT INTO ABLE_TO_TEACH (COURSE_NUMBER,INSTRUCTOR_ID)
VALUES (605,'ZCA34');
INSERT INTO ABLE_TO_TEACH (COURSE_NUMBER,INSTRUCTOR_ID)
VALUES (606,'ZCA34');
INSERT INTO ABLE_TO_TEACH (COURSE_NUMBER,INSTRUCTOR_ID)
VALUES (614,'RQY56');
INSERT INTO ABLE_TO_TEACH (COURSE_NUMBER,INSTRUCTOR_ID)
VALUES (620,'RQY56');
INSERT INTO ABLE_TO_TEACH (COURSE_NUMBER,INSTRUCTOR_ID)
VALUES (530,'UQK28');
INSERT INTO ABLE_TO_TEACH (COURSE_NUMBER,INSTRUCTOR_ID)
VALUES (604,'UQK28');
INSERT INTO ABLE_TO_TEACH (COURSE_NUMBER,INSTRUCTOR_ID)
VALUES (620,'UQK28');

---Plan inserts
INSERT INTO PLAN (student_id, plan_id, plan_name)
VALUES ('LHP37', 001, 'Lisa''s Plan');
INSERT INTO PLAN (student_id, plan_id, plan_name)
VALUES ('LHP37', 002,'Lisa''s Alternative plan');
INSERT INTO plan (student_id, plan_id, plan_name)
VALUES ('LHP37', 003,'Lisa''s Third plan');
INSERT INTO PLAN (student_id, plan_id, plan_name)
VALUES ('LUI90', 002, 'MTDPlanGrad');
INSERT INTO PLAN (student_id, plan_id, plan_name)
VALUES ('CTQ58', 001, 'NellsPlan');
INSERT INTO PLAN (student_id, plan_id, plan_name)
VALUES ('WLC80', 001, 'GradPlan');

----Planned Course Inserts
INSERT INTO PLANNED_COURSE (student_id, plan_id, course_number, academic_year,
    quarter_code)
VALUES ('WLC80', 6, 530, 2015, 15);
INSERT INTO PLANNED_COURSE (student_id, plan_id, course_number, academic_year,
    quarter_code)
VALUES ('WLC80', 6, 532, 2015, 15);
INSERT INTO PLANNED_COURSE (student_id, plan_id, course_number, academic_year,
    quarter_code)
VALUES ('WLC80', 6, 605, 2015, 15);
INSERT INTO PLANNED_COURSE (student_id, plan_id, course_number, academic_year,
    quarter_code)
VALUES ('WLC80', 6, 620, 2015, 25);
INSERT INTO PLANNED_COURSE (student_id, plan_id, course_number, academic_year,
    quarter_code)
VALUES ('WLC80', 6, 606, 2015, 25);
INSERT INTO PLANNED_COURSE (student_id, plan_id, course_number, academic_year,
    quarter_code)
VALUES ('WLC80', 6, 712, 2015, 25);
INSERT INTO PLANNED_COURSE (student_id, plan_id, course_number, academic_year,
    quarter_code)
VALUES ('LHP37', 1, 712, 2015, 25);
INSERT INTO PLANNED_COURSE (student_id, plan_id, course_number, academic_year,
    quarter_code)
VALUES ('LHP37', 1, 530, 2015, 15);
INSERT INTO PLANNED_COURSE (student_id, plan_id, course_number, academic_year,
    quarter_code)
VALUES ('LHP37', 1, 532, 2015, 15);
INSERT INTO PLANNED_COURSE (student_id, plan_id, course_number, academic_year,
    quarter_code)
VALUES ('LHP37', 1, 614, 2015, 15);
INSERT INTO PLANNED_COURSE (student_id, plan_id, course_number, academic_year,
    quarter_code)
VALUES ('LHP37', 1, 620, 2015, 25);
INSERT INTO PLANNED_COURSE (student_id, plan_id, course_number, academic_year,
    quarter_code)
VALUES ('LHP37', 1, 606, 2015, 25);
INSERT INTO PLANNED_COURSE (student_id, plan_id, course_number, academic_year,
    quarter_code)
VALUES ('LHP37', 1, 604, 2014, 15);
INSERT INTO PLANNED_COURSE (student_id, plan_id, course_number, academic_year,
    quarter_code)
VALUES ('LHP37', 1, 656, 2015, 15);
