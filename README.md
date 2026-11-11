# Staff Work Time Report System

This project provides a database schema and SQL queries to track and report staff work time across different projects and organizational units. It supports calculating work time breakdowns by time of day and holidays, providing a detailed distribution of how staff spend their hours.

## Features
- **Staff Management**: Track personnel details including roles and gender (standardized for professional conventions).
- **Project & Task Tracking**: Organize work into projects and specific tasks.
- **Work Log**: Record start and end times for staff working on tasks.
- **Time Analysis**: Generate reports that break down work hours into:
    - Daytime (7 AM - 3 PM)
    - Nighttime (3 PM - 7 AM)
    - Holidays

## Database Schema
The database includes the following tables:
- `dictionary_entries`: Stores constants like roles, holiday types, and time periods.
- `holiday_calendar`: Defines public holidays.
- `organizational_units`: Defines different areas/units.
- `personnel`: Stores information about the staff members.
- `projects`: Links projects to organizational units.
- `tasks`: Details individual tasks within projects.
- `working_hours`: Records the actual work time logs.

## How to Run
1. Ensure you have SQLite installed.
2. Execute `db_schema.sql` to initialize the database.
3. Run `report_staff_work_time_distribution.sql` to generate the detailed work time distribution report.


