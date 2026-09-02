# RaceDay

A full-stack web-based event management system for the South African road running, walking, and cycling community. RaceDay lets Event Organisers create and manage events, categories, and participant results, while Participants can browse events, enter categories, track their entries, and view their personal results.

**Module:** PROG6212
**Student:** Gomolemo Dizamuhupe (ST10491441)
**Group:** 4

## Project Structure

This is a Portfolio of Evidence (PoE) built progressively across three parts. Each part builds on the previous one — earlier work is preserved as later parts depend on it.

- **Part 1 — System Planning and Database** *(current)*
  Entity Relationship Diagram, full API endpoint plan, and SQL database script. No application code.
```
Gomolemo Dizamuhupe(PROG PART 1).pdf     # ERD, API endpoint plan, and SQL script (Sections A–C)
README.md
```

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

See Section A of `/docs/RaceDay_Part1.pdf`.

### API Endpoint Plan
Covers Authentication, User Profile, Events, Categories, Routes, Entries, and Results — HTTP method, route, description, role required, request body, and expected response (including failure codes) for each endpoint. See Section B of `/docs/RaceDay_Part1.pdf`.

### SQL Database Script
Creates the full `RACEDAY_DB` schema in SQL Server (SSMS): `Users`, `Events`, `Categories`, `Routes`, `Entries`, `Results`, with primary keys, foreign keys, and constraints (`NOT NULL`, `UNIQUE`, `DEFAULT`, `CHECK`). Seeded with 2 Organisers, 2 Participants, 3 Events, categories per event, routes, and sample entries/results. See Section C of `/docs/RaceDay_Part1.pdf`.

### Links
Youtube: 

## References

- diagrams.net (Draw.io), 2026. *Draw.io: Free online diagram software.* Available at: https://www.drawio.com/
- Microsoft, 2026. *SQL Server Management Studio (SSMS) documentation.* Available at: https://learn.microsoft.com/en-us/sql/ssms/
