create database Polizia

create table Agente(
Id_agente int identity(1,1) not null,
Nome nvarchar(30),
Cognome nvarchar(50),
CodiceFiscale nvarchar(16) unique,
DataNascita date,
AnnoServizio int,
constraint PK_agente primary key(Id_agente),
constraint CHK_cf check (LEN(CodiceFiscale)= 16),
constraint CHK_agente check (2021 - year(DataNascita)>=18)
);

create table AreaMetropolitana(
Id_area int identity(1,1) not null,
Nome nvarchar(50),
CodiceArea nvarchar(5) unique,
Alto_rischio bit
constraint PK_area primary key(Id_area)
);

create table Pattugliamento(
Id_agente int FOREIGN KEY REFERENCES Agente(Id_agente),
Id_area int FOREIGN KEY REFERENCES AreaMetropolitana(Id_area),
);

INSERT INTO Agente VALUES ('Pippo', 'Rossi', 'PPPEEE321DSADFWS', '1990-12-29', 6);
INSERT INTO Agente VALUES ('Pluto', 'Neri', 'PLUTO321DSADFWS1', '2003-05-06', 1);
INSERT INTO Agente VALUES ('Paperino', 'Blu', 'PAPERINO1DSADFWS', '1908-03-03', 3);
INSERT INTO Agente VALUES ('Minnie', 'Rosa', 'PPPEEE321DSADFWS', '1990-12-29', 5);
INSERT INTO Agente VALUES ('Pippi', 'Calza', 'PIPPPI321DSADFWS', '2000-03-27', 4);

INSERT INTO AreaMetropolitana VALUES ('Milano Centrale', 'M1CEN', 1);
INSERT INTO AreaMetropolitana VALUES ('Sesto San Giovanni', 'M4SSS', 0);
INSERT INTO AreaMetropolitana VALUES ('Milano Bovisa', 'M3BOV', 0);
INSERT INTO AreaMetropolitana VALUES ('Milano Duomo 1', 'M1DM1', 1);
INSERT INTO AreaMetropolitana VALUES ('Milano Duomo 2', 'M1DM2', 1);

INSERT INTO Pattugliamento VALUES (1,1);
INSERT INTO Pattugliamento VALUES (2,2);
INSERT INTO Pattugliamento VALUES (3,3);
INSERT INTO Pattugliamento VALUES (4,4);
INSERT INTO Pattugliamento VALUES (4,5);
INSERT INTO Pattugliamento VALUES (5,1);
INSERT INTO Pattugliamento VALUES (5,2);
INSERT INTO Pattugliamento VALUES (5,3);

SELECT a.*
FROM Agente a join Pattugliamento p on a.Id_agente = p.Id_agente
     join AreaMetropolitana am on am.Id_area = p.Id_area
WHERE am.Alto_rischio=1 and a.AnnoServizio<5;

SELECT a.CodiceArea, COUNT(p.Id_agente) as NumeroAgenti
FROM AreaMetropolitana a join Pattugliamento p on a.Id_area = p.Id_area 
GROUP BY a.CodiceArea