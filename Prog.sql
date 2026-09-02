-- Creating a database
CREATE DATABASE RACEDAY_DB; 

-- Using database
USE RACEDAY_DB;

-- Users table
CREATE TABLE Users (
    UserId INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Surname VARCHAR(100) NOT NULL,
    Email VARCHAR(150) NOT NULL UNIQUE,
    PasswordHash VARCHAR(255) NOT NULL,
    Role VARCHAR(20) NOT NULL
    CONSTRAINT CK_Users_Role 
    CHECK (Role IN ('organiser', 'participant'))
);

-- Events table
CREATE TABLE Events (
    EventId INT IDENTITY(1,1) PRIMARY KEY,
    OrganiserId INT NOT NULL,
    Name VARCHAR(150) NOT NULL,
    Description VARCHAR(255) NULL,
    EventDate DATE NOT NULL,
    Location VARCHAR(150) NOT NULL,
    FOREIGN KEY (OrganiserId) REFERENCES Users(UserId)
);

-- Categories table
CREATE TABLE Categories (
    CategoryId INT IDENTITY(1,1) PRIMARY KEY,
    EventId INT NOT NULL,
    Name VARCHAR(50) NOT NULL,
    DistanceKm DECIMAL(5,2) NOT NULL,
    MaxParticipants INT NOT NULL DEFAULT 500,
    CONSTRAINT FK_Categories_Event FOREIGN KEY (EventId)
    REFERENCES Events(EventId)
);

-- Routes table
CREATE TABLE Routes (
    RouteId INT IDENTITY(1,1) PRIMARY KEY,
    CategoryId INT NOT NULL,
    StartPoint VARCHAR(150) NOT NULL,
    EndPoint VARCHAR(150) NOT NULL,
    ElevationGain INT NULL,
    MapUrl VARCHAR(255) NULL,
    CONSTRAINT FK_Routes_Category FOREIGN KEY (CategoryId)
    REFERENCES Categories(CategoryId)
);

-- Entries table
CREATE TABLE Entries (
    EntryId INT IDENTITY(1,1) PRIMARY KEY,
    ParticipantId INT NOT NULL,
    CategoryId INT NOT NULL,
    EntryDate DATETIME NOT NULL,
    Status VARCHAR(20) NOT NULL DEFAULT 'Confirmed'
    CONSTRAINT CK_Entries_Status CHECK (Status IN ('Pending', 'Confirmed', 'Cancelled')),
    CONSTRAINT FK_Entries_Participant FOREIGN KEY (ParticipantId)
    REFERENCES Users(UserId),
    CONSTRAINT FK_Entries_Category FOREIGN KEY (CategoryId)
    REFERENCES Categories(CategoryId),
    CONSTRAINT UQ_Entries_Participant_Category UNIQUE (ParticipantId, CategoryId)
);

-- Results table
CREATE TABLE Results (
    ResultId INT IDENTITY(1,1) PRIMARY KEY,
    EntryId INT NOT NULL UNIQUE,
    FinishTime TIME NOT NULL,
    Position INT NULL,
    CapturedBy INT NOT NULL,
    CONSTRAINT FK_Results_Entry FOREIGN KEY (EntryId)
    REFERENCES Entries(EntryId),
    CONSTRAINT FK_Results_CapturedBy FOREIGN KEY (CapturedBy)
    REFERENCES Users(UserId)
);

-- Organisers (2)
INSERT INTO Users (Name, Surname, Email, PasswordHash, Role) VALUES
('Thabo', 'Mokoena',  'thabo.mokoena@raceday.co.za',   'HASH_PLACEHOLDER_1', 'organiser'),
('Lindiwe', 'Dlamini', 'lindiwe.dlamini@raceday.co.za', 'HASH_PLACEHOLDER_2', 'organiser');

-- Participants (2)
INSERT INTO Users (Name, Surname, Email, PasswordHash, Role) VALUES
('Sipho', 'Nkosi',    'sipho.nkosi@gmail.com',    'HASH_PLACEHOLDER_3', 'participant'),
('Amahle', 'van Wyk', 'amahle.vanwyk@gmail.com',  'HASH_PLACEHOLDER_4', 'participant');
 
-- Events (3)
INSERT INTO Events (OrganiserId, Name, Description, EventDate, Location) VALUES
(1, 'Sandton City Fun Run',         'A community road running event through Sandton CBD.',       '2026-10-18', 'Sandton, Johannesburg'),
(2, 'Knysna Forest Trail Challenge','A scenic trail running and walking event through indigenous forest.', '2026-11-08', 'Knysna, Western Cape'),
(1, 'Sea Point Cycle Classic',      'A charity cycling event along the Atlantic seaboard.',      '2026-11-22', 'Cape Town, Western Cape');
 
-- Categories (each event gets multiple categories)
INSERT INTO Categories (EventId, Name, DistanceKm, MaxParticipants) VALUES
(1, '5km Fun Run',      5.00,  500),
(1, '10km Road Run',    10.00, 500),
(2, '15km Trail Walk',  15.00, 250),
(2, '30km Trail Run',   30.00, 250),
(3, '40km Cycle Route', 40.00, 400),
(3, '80km Cycle Route', 80.00, 400);

-- Routes (one per category)
INSERT INTO Routes (CategoryId, StartPoint, EndPoint, ElevationGain, MapUrl) VALUES
(1, 'Sandton Gautrain Station',    'Sandton Gautrain Station', 60,  'https://maps.raceday.co.za/sandton-5km'),
(2, 'Sandton Gautrain Station',    'Sandton Gautrain Station', 120, 'https://maps.raceday.co.za/sandton-10km'),
(3, 'Knysna Elephant Park',        'Diepwalle Forest Station', 180, 'https://maps.raceday.co.za/knysna-15km'),
(4, 'Knysna Elephant Park',        'Diepwalle Forest Station', 310, 'https://maps.raceday.co.za/knysna-30km'),
(5, 'Mouille Point Lighthouse',    'Camps Bay Beach',          45,  'https://maps.raceday.co.za/seapoint-40km'),
(6, 'Mouille Point Lighthouse',    'Hout Bay Harbour',         90,  'https://maps.raceday.co.za/seapoint-80km');
 
-- Entries
INSERT INTO Entries (ParticipantId, CategoryId, EntryDate, Status) VALUES
(3, 2, '2026-09-01 09:00:00', 'Confirmed'),  -- Sipho enters Sandton 10km
(4, 1, '2026-09-01 09:15:00', 'Confirmed'),  -- Amahle enters Sandton 5km
(3, 4, '2026-09-05 14:30:00', 'Confirmed'),  -- Sipho enters Knysna 30km Trail Run
(4, 6, '2026-09-06 11:00:00', 'Confirmed');  -- Amahle enters Sea Point 80km Cycle
 
-- Results 
INSERT INTO Results (EntryId, FinishTime, Position, CapturedBy) VALUES
(1, '00:52:14', 3, 1),
(2, '00:28:47', 5, 1);
