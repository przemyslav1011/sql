--
-- File generated with SQLiteStudio v3.4.17 on niedz. maj 4 18:56:59 2025
--
-- Text encoding used: System
--
PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- Table: dictionary_entries
CREATE TABLE IF NOT EXISTS "dictionary_entries" (
	"dictionary_code"	TEXT NOT NULL,
	"dictionary_entry_code"	TEXT NOT NULL,
	"dictionary_entry_name"	TEXT NOT NULL,
	PRIMARY KEY("dictionary_code","dictionary_entry_code")
);
INSERT INTO dictionary_entries (dictionary_code, dictionary_entry_code, dictionary_entry_name) VALUES ('PERS_ROLE', 'SD', 'Software Developer');
INSERT INTO dictionary_entries (dictionary_code, dictionary_entry_code, dictionary_entry_name) VALUES ('PERS_ROLE', 'BA', 'Business Analyst');
INSERT INTO dictionary_entries (dictionary_code, dictionary_entry_code, dictionary_entry_name) VALUES ('PERS_ROLE', 'QA', 'Quality Assurance Engineer');
INSERT INTO dictionary_entries (dictionary_code, dictionary_entry_code, dictionary_entry_name) VALUES ('PERS_ROLE', 'UD', 'UI/UX Designer');
INSERT INTO dictionary_entries (dictionary_code, dictionary_entry_code, dictionary_entry_name) VALUES ('PERS_ROLE', 'SA', 'System Administrator');
INSERT INTO dictionary_entries (dictionary_code, dictionary_entry_code, dictionary_entry_name) VALUES ('PERS_ROLE', 'DA', 'Database Administrator');
INSERT INTO dictionary_entries (dictionary_code, dictionary_entry_code, dictionary_entry_name) VALUES ('PERS_ROLE', 'DE', 'DevOps Engineer');
INSERT INTO dictionary_entries (dictionary_code, dictionary_entry_code, dictionary_entry_name) VALUES ('PERS_ROLE', 'SC', 'Cybersecurity Specialist');
INSERT INTO dictionary_entries (dictionary_code, dictionary_entry_code, dictionary_entry_name) VALUES ('PERS_ROLE', 'TW', 'Technical Writer');
INSERT INTO dictionary_entries (dictionary_code, dictionary_entry_code, dictionary_entry_name) VALUES ('PERS_ROLE', 'PM', 'Project Manager');
INSERT INTO dictionary_entries (dictionary_code, dictionary_entry_code, dictionary_entry_name) VALUES ('SEX', 'M', 'Male');
INSERT INTO dictionary_entries (dictionary_code, dictionary_entry_code, dictionary_entry_name) VALUES ('SEX', 'F', 'Female');
INSERT INTO dictionary_entries (dictionary_code, dictionary_entry_code, dictionary_entry_name) VALUES ('KIND_OF_HOLIDAY', 'PH', 'Public Holiday');
INSERT INTO dictionary_entries (dictionary_code, dictionary_entry_code, dictionary_entry_name) VALUES ('YES_NO', 'Y', 'Yes');
INSERT INTO dictionary_entries (dictionary_code, dictionary_entry_code, dictionary_entry_name) VALUES ('YES_NO', 'N', 'No');
INSERT INTO dictionary_entries (dictionary_code, dictionary_entry_code, dictionary_entry_name) VALUES ('DAYTIME_PERIOD', 'M', 'Daytime period from 7 AM to 3 PM');
INSERT INTO dictionary_entries (dictionary_code, dictionary_entry_code, dictionary_entry_name) VALUES ('DAYTIME_PERIOD', 'E', 'Daytime period from 3 PM to 7 AM');

-- Table: holiday_calendar
CREATE TABLE IF NOT EXISTS "holiday_calendar" (
	"date"	TEXT NOT NULL UNIQUE,
	"name"	TEXT NOT NULL,
	"kind_of_holiday"	TEXT NOT NULL,
	PRIMARY KEY("date")
);
INSERT INTO holiday_calendar (date, name, kind_of_holiday) VALUES ('2025-05-03', 'May 3rd Constitution Day', 'PH');

-- Table: organizational_units
CREATE TABLE IF NOT EXISTS "organizational_units" (
	"unit_id"	INTEGER NOT NULL UNIQUE,
	"name"	TEXT NOT NULL,
	PRIMARY KEY("unit_id" AUTOINCREMENT)
);
INSERT INTO organizational_units (unit_id, name) VALUES (1, 'Kitchen');
INSERT INTO organizational_units (unit_id, name) VALUES (2, 'Living Room');
INSERT INTO organizational_units (unit_id, name) VALUES (3, 'Bathroom');

-- Table: personel
CREATE TABLE IF NOT EXISTS "personel" (
	"personel_id"	INTEGER NOT NULL UNIQUE,
	"name"	TEXT NOT NULL,
	"sex"	TEXT,
	PRIMARY KEY("personel_id" AUTOINCREMENT)
);
INSERT INTO personel (personel_id, name, sex) VALUES (1, 'Testowy Pan1', 'M');
INSERT INTO personel (personel_id, name, sex) VALUES (2, 'Testowa Pani1', 'W');
INSERT INTO personel (personel_id, name, sex) VALUES (3, 'Testowa Pani2', 'W');
INSERT INTO personel (personel_id, name, sex) VALUES (4, 'Testowa Pani3', 'W');
INSERT INTO personel (personel_id, name, sex) VALUES (5, 'Testowy Pan2', 'M');
INSERT INTO personel (personel_id, name, sex) VALUES (6, 'Testowy Pan3', 'M');

-- Table: projects
CREATE TABLE IF NOT EXISTS "projects" (
	"project_id"	INTEGER NOT NULL UNIQUE,
	"name"	TEXT NOT NULL,
	"description"	TEXT,
	"unit_id"	INTEGER NOT NULL,
	PRIMARY KEY("project_id" AUTOINCREMENT),
	CONSTRAINT "fk_unit_id" FOREIGN KEY("unit_id") REFERENCES "organizational_units"("unit_id")
);
INSERT INTO projects (project_id, name, description, unit_id) VALUES (1, 'Cleaning work', NULL, 1);

-- Table: tasks
CREATE TABLE IF NOT EXISTS "tasks" (
	"task_id"	INTEGER NOT NULL UNIQUE,
	"name"	TEXT NOT NULL,
	"description"	TEXT,
	"project_id"	INTEGER NOT NULL,
	PRIMARY KEY("task_id" AUTOINCREMENT),
	CONSTRAINT "fk_project_id" FOREIGN KEY("project_id") REFERENCES "projects"("project_id")
);
INSERT INTO tasks (task_id, name, description, project_id) VALUES (1, 'Sweep and mop the floors', NULL, 1);
INSERT INTO tasks (task_id, name, description, project_id) VALUES (2, 'Dust and wipe surfaces', NULL, 1);
INSERT INTO tasks (task_id, name, description, project_id) VALUES (3, 'Clean windows and mirrors', NULL, 1);
INSERT INTO tasks (task_id, name, description, project_id) VALUES (4, 'Vacuum carpets and rugs', NULL, 1);
INSERT INTO tasks (task_id, name, description, project_id) VALUES (5, 'Take out the trash and recycling', NULL, 1);
INSERT INTO tasks (task_id, name, description, project_id) VALUES (6, 'Organize and tidy up rooms', NULL, 1);

-- Table: working_hours
CREATE TABLE IF NOT EXISTS working_hours (wh_id INTEGER NOT NULL UNIQUE, personel_id INTEGER NOT NULL, task_id INTEGER NOT NULL, personel_role TEXT NOT NULL, start_time TEXT NOT NULL, stop_time TEXT NOT NULL, PRIMARY KEY (wh_id AUTOINCREMENT), CONSTRAINT fk_task_id FOREIGN KEY (task_id) REFERENCES tasks (task_id), CONSTRAINT fk_personel_id FOREIGN KEY (personel_id) REFERENCES personel (personel_id));
INSERT INTO working_hours (wh_id, personel_id, task_id, personel_role, start_time, stop_time) VALUES (1, 1, 1, 'SD', '2025-05-03 20:33:00', '2025-05-03 20:36:00');
INSERT INTO working_hours (wh_id, personel_id, task_id, personel_role, start_time, stop_time) VALUES (2, 2, 2, 'PM', '2025-05-03 20:33:00', '2025-05-03 21:33:00');
INSERT INTO working_hours (wh_id, personel_id, task_id, personel_role, start_time, stop_time) VALUES (3, 2, 3, 'PM', '2025-05-03 20:33:00', '2025-05-03 21:33:00');
INSERT INTO working_hours (wh_id, personel_id, task_id, personel_role, start_time, stop_time) VALUES (4, 1, 1, 'SD', '2025-05-03 20:33:00', '2025-05-03 21:33:00');
INSERT INTO working_hours (wh_id, personel_id, task_id, personel_role, start_time, stop_time) VALUES (5, 2, 2, 'PM', '2025-05-03 20:33:00', '2025-05-03 21:33:00');
INSERT INTO working_hours (wh_id, personel_id, task_id, personel_role, start_time, stop_time) VALUES (6, 1, 3, 'SD', '2025-05-04 20:33:00', '2025-05-04 21:33:00');
INSERT INTO working_hours (wh_id, personel_id, task_id, personel_role, start_time, stop_time) VALUES (7, 2, 1, 'PM', '2025-05-03 20:33:00', '2025-05-03 21:33:00');
INSERT INTO working_hours (wh_id, personel_id, task_id, personel_role, start_time, stop_time) VALUES (8, 3, 2, 'BA', '2025-05-03 20:33:00', '2025-05-03 21:33:00');
INSERT INTO working_hours (wh_id, personel_id, task_id, personel_role, start_time, stop_time) VALUES (9, 3, 3, 'BA', '2025-05-01 20:33:00', '2025-05-06 21:33:00');
INSERT INTO working_hours (wh_id, personel_id, task_id, personel_role, start_time, stop_time) VALUES (10, 4, 1, 'UD', '2025-05-03 20:33:00', '2025-05-03 21:33:00');
INSERT INTO working_hours (wh_id, personel_id, task_id, personel_role, start_time, stop_time) VALUES (11, 4, 2, 'UD', '2025-05-03 20:33:00', '2025-05-03 21:33:00');
INSERT INTO working_hours (wh_id, personel_id, task_id, personel_role, start_time, stop_time) VALUES (12, 4, 3, 'UD', '2025-05-03 20:33:00', '2025-05-03 21:33:00');
INSERT INTO working_hours (wh_id, personel_id, task_id, personel_role, start_time, stop_time) VALUES (13, 5, 1, 'TW', '2025-05-03 20:33:00', '2025-05-03 21:33:00');
INSERT INTO working_hours (wh_id, personel_id, task_id, personel_role, start_time, stop_time) VALUES (14, 5, 2, 'TW', '2025-05-03 20:33:00', '2025-05-03 21:33:00');
INSERT INTO working_hours (wh_id, personel_id, task_id, personel_role, start_time, stop_time) VALUES (15, 5, 3, 'TW', '2025-05-03 20:33:00', '2025-05-03 21:33:00');
INSERT INTO working_hours (wh_id, personel_id, task_id, personel_role, start_time, stop_time) VALUES (16, 5, 1, 'TW', '2025-05-03 20:33:00', '2025-05-03 21:33:00');
INSERT INTO working_hours (wh_id, personel_id, task_id, personel_role, start_time, stop_time) VALUES (17, 2, 2, 'PM', '2025-05-03 20:33:00', '2025-05-03 21:33:00');

COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
