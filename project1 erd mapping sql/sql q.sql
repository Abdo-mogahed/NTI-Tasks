CREATE TABLE NATIONALITY (
    NATIONALITY_ID SERIAL PRIMARY KEY,
    Country_Name VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE STADIUMS (
    STADIUMS_ID SERIAL PRIMARY KEY,
    Stadium_Name VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE POSITIONS (
    POSITIONS_ID SERIAL PRIMARY KEY,
    P_Position VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE Club (
    Club_ID SERIAL PRIMARY KEY,
    Club_Name VARCHAR(100) NOT NULL,
    Club_City VARCHAR(100),
    Founded_Year INT,
    STADIUMS_ID INT REFERENCES STADIUMS(STADIUMS_ID),
	Club_Country INT REFERENCES NATIONALITY(NATIONALITY_ID)
);

CREATE TABLE Tournaments (
    T_ID SERIAL PRIMARY KEY,
    T_Name VARCHAR(150) NOT NULL,
    T_Type VARCHAR(50),
    T_Season VARCHAR(50),
    Host_Country VARCHAR(100)
);

CREATE TABLE Player (
    Player_ID SERIAL PRIMARY KEY,
    P_Full_Name VARCHAR(150) NOT NULL,
    P_Date_Of_Birth DATE,
    NATIONALITY_ID INT REFERENCES NATIONALITY(NATIONALITY_ID),
    POSITIONS_ID INT REFERENCES POSITIONS(POSITIONS_ID),
    Jersy_Number INT,
    Salary NUMERIC(12,2),
    Player_Img TEXT,
    Contract_End_Date DATE,
    Club_ID INT REFERENCES Club(Club_ID)
);

CREATE TABLE Coach (
    Coach_ID SERIAL PRIMARY KEY,
    C_Full_Name VARCHAR(150) NOT NULL,
    NATIONALITY_ID INT REFERENCES NATIONALITY(NATIONALITY_ID),
    Years_Of_Experience INT,
    C_Role VARCHAR(50),
    Club_ID INT REFERENCES Club(Club_ID)
);

CREATE TABLE Matchs (
    Match_ID SERIAL PRIMARY KEY,
    M_Date DATE NOT NULL,
    Match_Venue VARCHAR(150),
    M_Attendance INT,
    Final_Result VARCHAR(20),
    Home_Team_ID INT REFERENCES Club(Club_ID),
    Away_Team_ID INT REFERENCES Club(Club_ID),
    T_ID INT REFERENCES Tournaments(T_ID),
    CONSTRAINT chk_teams CHECK (Home_Team_ID <> Away_Team_ID)
);

CREATE TABLE Referee (
    Referee_ID SERIAL PRIMARY KEY,
    R_Name VARCHAR(150) NOT NULL,
    NATIONALITY_ID INT REFERENCES NATIONALITY(NATIONALITY_ID),
    Years_Of_Experience INT
);

CREATE TABLE MATCH_REFEREE (
    Match_ID INT REFERENCES Matchs(Match_ID),
    Referee_ID INT REFERENCES Referee(Referee_ID),
    R_Role VARCHAR(50),
    PRIMARY KEY (Match_ID, Referee_ID)
);

CREATE TABLE PLAYER_STATISTICS (
    Player_ID INT REFERENCES Player(Player_ID),
    Match_ID INT REFERENCES Matchs(Match_ID),
    Goals INT DEFAULT 0,
    Assists INT DEFAULT 0,
    Yellow_Cards INT DEFAULT 0,
    Red_Cards INT DEFAULT 0,
    Minutes_Played INT DEFAULT 0,
    PRIMARY KEY (Player_ID, Match_ID)
);



--INSERT DATA

-- ========================
-- 1) Nationalities
-- ========================
INSERT INTO NATIONALITY (Country_Name) VALUES
('Egypt'),
('Tunisia'),
('Morocco'),
('Ghana'),
('Nigeria'),
('Algeria'),
('South Africa'),
('Portugal'),
('Switzerland');

-- ========================
-- 2) Stadiums
-- ========================
INSERT INTO STADIUMS (Stadium_Name) VALUES
('Cairo International Stadium'),
('Borg El Arab Stadium'),
('Alexandria Stadium'),
('Military Stadium'),
('Air Defense Stadium'),
('Ismailia Stadium'),
('Port Said Stadium'),
('Mokhtar El-Tetsh Stadium');

-- ========================
-- 3) Positions
-- ========================
INSERT INTO POSITIONS (P_Position) VALUES
('Goalkeeper'),
('Defender'),
('Midfielder'),
('Forward');

-- ========================
-- 4) Clubs (linked to NATIONALITY)
-- ========================
INSERT INTO Club (Club_Name, Club_City, Founded_Year, STADIUMS_ID, Club_Country) VALUES
('Al Ahly SC', 'Cairo', 1907, 1, 1),
('Zamalek SC', 'Giza', 1911, 1, 1),
('Pyramids FC', 'Cairo', 2008, 5, 1),
('Al Ittihad Alexandria', 'Alexandria', 1914, 3, 1),
('Ismaily SC', 'Ismailia', 1924, 6, 1),
('El Masry SC', 'Port Said', 1920, 7, 1),
('ENPPI', 'Cairo', 1980, 4, 1),
('Future FC', 'Cairo', 2011, 5, 1),
('Ceramica Cleopatra', 'Cairo', 2007, 4, 1),
('Pharco FC', 'Alexandria', 2010, 2, 1);

-- ========================
-- 5) Players (sample squads per club)
-- ========================
-- Al Ahly
INSERT INTO Player (P_Full_Name, P_Date_Of_Birth, NATIONALITY_ID, POSITIONS_ID, Jersy_Number, Salary, Player_Img, Contract_End_Date, Club_ID)
VALUES
('Mohamed El Shenawy', '1988-12-18', 1, 1, 1, 20000000, NULL, '2026-06-30', 1),
('Ali Maaloul', '1990-01-01', 2, 2, 21, 15000000, NULL, '2025-06-30', 1),
('Hussein El Shahat', '1992-06-21', 1, 3, 14, 12000000, NULL, '2025-06-30', 1),
('Percy Tau', '1994-05-13', 7, 4, 23, 17000000, NULL, '2026-06-30', 1);

-- Zamalek
INSERT INTO Player (P_Full_Name, P_Date_Of_Birth, NATIONALITY_ID, POSITIONS_ID, Jersy_Number, Salary, Player_Img, Contract_End_Date, Club_ID)
VALUES
('Mohamed Awad', '1992-01-06', 1, 1, 16, 8000000, NULL, '2025-06-30', 2),
('Ahmed Sayed Zizo', '1996-01-10', 1, 4, 25, 12000000, NULL, '2027-06-30', 2),
('Mostafa Shalaby', '1994-01-01', 1, 3, 7, 9000000, NULL, '2025-06-30', 2),
('Hamza Mathlouthi', '1992-07-25', 2, 2, 12, 6000000, NULL, '2025-06-30', 2);

-- Pyramids
INSERT INTO Player (P_Full_Name, P_Date_Of_Birth, NATIONALITY_ID, POSITIONS_ID, Jersy_Number, Salary, Player_Img, Contract_End_Date, Club_ID)
VALUES
('Sherif Ekramy', '1983-07-10', 1, 1, 1, 6000000, NULL, '2025-06-30', 3),
('Ramadan Sobhi', '1997-01-23', 1, 3, 10, 14000000, NULL, '2026-06-30', 3),
('Fagrie Lakay', '1997-01-17', 7, 4, 9, 11000000, NULL, '2026-06-30', 3);

-- Al Ittihad Alexandria
INSERT INTO Player (P_Full_Name, P_Date_Of_Birth, NATIONALITY_ID, POSITIONS_ID, Jersy_Number, Salary, Player_Img, Contract_End_Date, Club_ID)
VALUES
('Mohamed Sobhi', '1999-07-15', 1, 1, 1, 5000000, NULL, '2027-06-30', 4),
('Khaled El Ghandour', '1994-04-14', 1, 3, 10, 4500000, NULL, '2026-06-30', 4),
('Mabululu', '1990-05-23', 5, 4, 9, 9000000, NULL, '2025-06-30', 4);

-- Ismaily
INSERT INTO Player (P_Full_Name, P_Date_Of_Birth, NATIONALITY_ID, POSITIONS_ID, Jersy_Number, Salary, Player_Img, Contract_End_Date, Club_ID)
VALUES
('Mohamed Fawzi', '1993-02-01', 1, 1, 1, 4000000, NULL, '2026-06-30', 5),
('Baher El Mohamady', '1996-12-22', 1, 2, 4, 6000000, NULL, '2025-06-30', 5);

-- El Masry
INSERT INTO Player (P_Full_Name, P_Date_Of_Birth, NATIONALITY_ID, POSITIONS_ID, Jersy_Number, Salary, Player_Img, Contract_End_Date, Club_ID)
VALUES
('Ahmed Refaat', '1993-01-01', 1, 3, 11, 7000000, NULL, '2026-06-30', 6),
('Austin Amutu', '1993-02-20', 5, 4, 9, 8000000, NULL, '2025-06-30', 6);

-- ENPPI
INSERT INTO Player (P_Full_Name, P_Date_Of_Birth, NATIONALITY_ID, POSITIONS_ID, Jersy_Number, Salary, Player_Img, Contract_End_Date, Club_ID)
VALUES
('Mahmoud Gad', '1998-10-01', 1, 1, 1, 4000000, NULL, '2026-06-30', 7),
('Ahmed Amin', '1997-07-01', 1, 4, 9, 3500000, NULL, '2025-06-30', 7);

-- Future FC
INSERT INTO Player (P_Full_Name, P_Date_Of_Birth, NATIONALITY_ID, POSITIONS_ID, Jersy_Number, Salary, Player_Img, Contract_End_Date, Club_ID)
VALUES
('Mahmoud Canawy', '1995-06-15', 1, 3, 8, 4500000, NULL, '2025-06-30', 8),
('Jonathan Ngwem', '1991-07-20', 5, 2, 15, 5000000, NULL, '2025-06-30', 8);

-- Ceramica Cleopatra
INSERT INTO Player (P_Full_Name, P_Date_Of_Birth, NATIONALITY_ID, POSITIONS_ID, Jersy_Number, Salary, Player_Img, Contract_End_Date, Club_ID)
VALUES
('Mohamed Amer', '1994-09-01', 1, 2, 6, 3000000, NULL, '2025-06-30', 9),
('Shady Hussein', '1993-12-01', 1, 4, 10, 6000000, NULL, '2025-06-30', 9);

-- Pharco
INSERT INTO Player (P_Full_Name, P_Date_Of_Birth, NATIONALITY_ID, POSITIONS_ID, Jersy_Number, Salary, Player_Img, Contract_End_Date, Club_ID)
VALUES
('Mahmoud Hamada', '1994-05-10', 1, 3, 5, 4000000, NULL, '2026-06-30', 10),
('Kingsley Sokari', '1995-01-01', 5, 3, 8, 5000000, NULL, '2026-06-30', 10);

-- ========================
-- 6) Coaches
-- ========================
INSERT INTO Coach (C_Full_Name, NATIONALITY_ID, Years_Of_Experience, C_Role, Club_ID) VALUES
('Marcel Koller', 9, 25, 'Head Coach', 1),
('Jose Gomes', 8, 22, 'Head Coach', 2),
('Jaime Pacheco', 3, 28, 'Head Coach', 3),
('Hossam Hassan', 1, 20, 'Head Coach', 4),
('Juan Carlos Garrido', 6, 30, 'Head Coach', 5),
('Ali Maher', 1, 18, 'Head Coach', 6),
('Tamer Mostafa', 1, 15, 'Head Coach', 7),
('Moaz El Henawy', 1, 12, 'Head Coach', 8),
('Ayman Mansour', 1, 14, 'Head Coach', 9),
('Ehab Galal', 1, 20, 'Head Coach', 10);

-- ========================
-- 7) Referees
-- ========================
INSERT INTO Referee (R_Name, NATIONALITY_ID, Years_Of_Experience) VALUES
('Mahmoud Ashour', 1, 15),
('Ibrahim Nour El Din', 1, 18),
('Mohamed Adel', 1, 12);

-- ========================
-- 8) Tournaments
-- ========================
INSERT INTO Tournaments (T_Name, T_Type, T_Season, Host_Country) VALUES
('Egyptian Premier League', 'League', '2024/2025', 'Egypt');

-- ========================
-- 9) Matches
-- ========================
INSERT INTO Matchs (M_Date, Match_Venue, M_Attendance, Final_Result, Home_Team_ID, Away_Team_ID, T_ID)
VALUES
('2025-01-15', 'Cairo International Stadium', 50000, '2-1', 1, 2, 1),
('2025-01-20', 'Borg El Arab Stadium', 30000, '1-1', 3, 4, 1),
('2025-01-25', 'Ismailia Stadium', 25000, '0-0', 5, 6, 1),
('2025-01-30', 'Air Defense Stadium', 15000, '3-2', 8, 9, 1);

-- ========================
-- 10) Match Referees
-- ========================
INSERT INTO MATCH_REFEREE (Match_ID, Referee_ID, R_Role) VALUES
(1, 1, 'Main Referee'),
(2, 2, 'Main Referee'),
(3, 3, 'Main Referee'),
(4, 1, 'Main Referee');

-- ========================
-- 11) Player Statistics (samples)
-- ========================
INSERT INTO PLAYER_STATISTICS (Player_ID, Match_ID, Goals, Assists, Yellow_Cards, Red_Cards, Minutes_Played) VALUES
(1, 1, 0, 0, 0, 0, 90), -- El Shenawy
(2, 1, 1, 0, 1, 0, 90), -- Maaloul
(6, 1, 1, 0, 0, 0, 90), -- Zizo
(8, 1, 0, 1, 0, 0, 85), -- Mathlouthi
(10, 2, 1, 0, 0, 0, 90), -- Ramadan
(14, 2, 0, 0, 0, 0, 90), -- Mabululu
(17, 3, 0, 0, 0, 0, 90), -- Baher El Mohamady
(19, 3, 0, 0, 0, 0, 90), -- Amutu
(22, 4, 2, 0, 0, 0, 90), -- Ngwem
(24, 4, 1, 1, 0, 0, 90); -- Shady Hussein

--------
--|Q1|--Retrieve the names of all clubs located in Egypt
--------

SELECT Club_Name
FROM Club
JOIN NATIONALITY ON Club.Club_Country = NATIONALITY.NATIONALITY_ID
WHERE NATIONALITY.Country_Name = 'Egypt';

--------
--|Q2|--List the full names and positions of all players who play for a specific club (e.g.,"Al Ahly")
--------

SELECT Player.P_Full_Name, POSITIONS.P_Position
FROM Player
JOIN POSITIONS ON Player.POSITIONS_ID = POSITIONS.POSITIONS_ID
JOIN Club ON Player.Club_ID = Club.Club_ID
WHERE Club.Club_Name = 'Al Ahly SC';

--------
--|Q3|--Find all coaches with more than 4 years of experience
--------

SELECT C_Full_Name, Years_Of_Experience
FROM Coach
WHERE Years_Of_Experience > 4;

--------
--|Q4|--Show the details of matches that were played in 2024
--------

SELECT Match_ID, M_Date, Match_Venue,home_team_id,away_team_id, Final_Result
FROM Matchs
WHERE EXTRACT(YEAR FROM M_Date) = 2025;


--------
--|Q5|--Retrieve the referee names who have overseen more than 5 matches
--------

SELECT Referee.R_Name, COUNT(MATCH_REFEREE.Match_ID) AS Num_Matches
FROM Referee
JOIN MATCH_REFEREE ON Referee.Referee_ID = MATCH_REFEREE.Referee_ID
GROUP BY Referee.R_Name
HAVING COUNT(MATCH_REFEREE.Match_ID) >= 5;

--------
--|Q6|--Display the top 5 players with the highest total goals scored across all matches
--------

SELECT Player.P_Full_Name, SUM(PLAYER_STATISTICS.Goals) AS Total_Goals
FROM Player
JOIN PLAYER_STATISTICS ON Player.Player_ID = PLAYER_STATISTICS.Player_ID
GROUP BY Player.P_Full_Name
ORDER BY Total_Goals DESC
LIMIT 5;

--------
--|Q7|--List the names of tournaments hosted in Saudi Arabia (Egypt)
--------

SELECT T_Name, T_Season
FROM Tournaments
WHERE Host_Country = 'Egypt';

--------
--|Q8|--For each club, count the number of players registered
--------

SELECT Club.Club_Name, COUNT(Player.Player_ID) AS Num_Players
FROM Club
LEFT JOIN Player ON Club.Club_ID = Player.Club_ID
GROUP BY Club.Club_Name;

--------
--|Q9|--Find the match (date, venue, result) with the highest attendance
--------

SELECT M_Date, Match_Venue, Final_Result, M_Attendance
FROM Matchs
ORDER BY M_Attendance DESC
LIMIT 1;

--------
--|Q10|-For each player, calculate their average minutes played per match
--------

SELECT Player.P_Full_Name, AVG(PLAYER_STATISTICS.Minutes_Played) AS Avg_Minutes
FROM Player
JOIN PLAYER_STATISTICS ON Player.Player_ID = PLAYER_STATISTICS.Player_ID
GROUP BY Player.P_Full_Name;

