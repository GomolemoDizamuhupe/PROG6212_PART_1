# RaceDay

A full-stack web-based event management system for the South African road running, walking, and cycling community. RaceDay lets Event Organisers create and manage events, categories, and participant results, while Participants can browse events, enter categories, track their entries, and view their personal results.

**Module:** PROG6212
**Student:** Gomolemo Dizamuhupe (ST10491441)
**Group:** 4
**GitHub Repo:** [GomolemoDizamuhupe/PROG6212-SQL-SCRIPT-](https://github.com/GomolemoDizamuhupe/PROG6212-SQL-SCRIPT-)
**Demo Video:** https://youtu.be/ZRrgUtRMAuo

## Project Structure

This is a Portfolio of Evidence (PoE) built progressively across three parts. Each part builds on the previous one — earlier work is preserved as later parts depend on it.

- **Part 1 — System Planning and Database** *(current)*
  Entity Relationship Diagram, full API endpoint plan, and SQL database script. No application code.
- **Part 2 — RESTful API** *(upcoming)*
  ASP.NET Core Web API built in C#, connected to the database, with unit tests and GitHub CI/CD.
- **Part 3 — MVC Web Application** *(upcoming)*
  MVC front end consuming the API, Azure Blob Storage integration, and Docker containerisation.

## Roles

RaceDay supports two user roles, enforced consistently across the API (Part 2) and the MVC interface (Part 3):

- **Organiser** — create, edit, and delete events; manage event categories and routes; capture and correct participant results; view all entries for their events.
- **Participant** — register an account; browse events; enter a category; view their own entries; track their personal result history.

## Part 1 Summary

### Entity Relationship Diagram
Six entities: `User`, `Event`, `Category`, `Route`, `Entry`, `Result`. Relationships:
- User organises many Events (1:*)
- Event has many Categories (1:*)
- Category has one Route (1:1)
- User submits many Entries (1:*); Category receives many Entries (1:*)
- Entry produces one Result (1:1)

### API Endpoint Plan
Covers Authentication, User Profile, Events, Categories, Routes, Entries, and Results — HTTP method, route, description, role required, request body, and expected response (including failure codes) for each endpoint. 

### SQL Database Script
Creates the full `RACEDAY_DB` schema in SQL Server (SSMS): `Users`, `Events`, `Categories`, `Routes`, `Entries`, `Results`, with primary keys, foreign keys, and constraints (`NOT NULL`, `UNIQUE`, `DEFAULT`, `CHECK`). Seeded with 2 Organisers, 2 Participants, 3 Events, categories per event, routes, and sample entries/results.

## GITHUB ACTION SCREENSHOOT
<img width="1366" height="741" alt="image" src="https://github.com/user-attachments/assets/baf79d82-a07e-46c6-ad4e-6ff04a697aa2" />


## References

- diagrams.net (Draw.io), 2026. *Draw.io: Free online diagram software.* Available at: https://www.drawio.com/
- Microsoft, 2026. *SQL Server Management Studio (SSMS) documentation.* Available at: https://learn.microsoft.com/en-us/sql/ssms/
