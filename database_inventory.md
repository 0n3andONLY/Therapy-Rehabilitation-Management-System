# Database Inventory

**Project:** Therapy Rehabilitation Management System  
**DBMS:** MySQL  
**Database:** `therapy_rehabilitation`

## Base Tables

1. `patients` — Patient demographic and contact information.
2. `therapists` — Therapist details and specializations.
3. `appointments` — Appointment dates, times, status, and linked patient and therapist.
4. `therapy_plans` — Rehabilitation goals and treatment plans.
5. `therapy_sessions` — Sessions linked to appointments and therapy plans.
6. `exercises` — Exercise descriptions and instructions.
7. `session_exercises` — Exercises assigned to therapy sessions.
8. `progress_records` — Rehabilitation progress measurements.
9. `medical_records` — Patient diagnoses and medical history.
10. `bills` — Patient billing records.
11. `bill_items` — Individual charges included in bills.

## Other Database Objects

- 6 views
- 7 stored procedures
- 5 stored functions
- 2 triggers

These object counts were established during project development. The SQL backup should be restored and tested separately before final submission.

## Backup File

`database/therapy_rehabilitation_backup.sql`
