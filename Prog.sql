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
    REFERENCES dbo.Categories(CategoryId)
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
