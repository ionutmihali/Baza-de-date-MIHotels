
--CREARE BAZA DE DATE
use master
drop database if exists MIHotels

CREATE DATABASE MIHotels 
ON PRIMARY
(
	NAME = MIHotelsData1,
	FILENAME = 'C:\DB\MIHotels.mdf',
	size = 10MB,
	maxsize = UNLIMITED,
	filegrowth = 1GB
),
(
	NAME = MIHotelsData2,
	FILENAME = 'C:\DB\MIHotels1.mdf',
	size = 10MB,
	maxsize = UNLIMITED,
	filegrowth = 1GB
),
(
	NAME = MIHotelsData3,
	FILENAME = 'C:\DB\MIHotels.ndf',
	size = 10MB,
	maxsize = UNLIMITED,
	filegrowth = 1GB
),
(
	NAME = MIHotelsData4,
	FILENAME = 'C:\DB\MIHotels1.ndf',
	size = 10MB,
	maxsize = UNLIMITED,
	filegrowth = 1GB
)
LOG ON
(
	NAME = MIHotelsLog1,
	FILENAME = 'C:\DB\MIHotels.ldf',
	size = 10MB,
	maxsize = UNLIMITED,
	filegrowth = 1GB
),
(
	NAME = MIHotelsLog2,
	FILENAME = 'C:\DB\MIHotels1.ldf',
	size = 10MB,
	maxsize = UNLIMITED,
	filegrowth = 1GB
)
GO

--CREARE TABELE
USE MIHotels
IF OBJECT_ID('Angajati', 'U') is not null
	DROP TABLE Angajati
go
CREATE TABLE Angajati(
	AngajatID int identity(1000,1) primary key,
	Nume nvarchar(32) not null,
	Prenume nvarchar(32) not null,
	DataAngajarii date not null,
	Adresa ntext,
	Oras nvarchar(32) not null,
	Telefon nvarchar(12)
)

USE MIHotels
IF OBJECT_ID('Hoteluri', 'U') is not null
	DROP TABLE Hoteluri
go
CREATE TABLE Hoteluri(
	HotelID int identity(3000,1) primary key,
	Nume nvarchar(32) not null,
	Oras nvarchar(32) not null,
	Tara nvarchar(32) not null,
	Adresa ntext,
	Telefon nvarchar(12) not null,
	Descriere ntext,
	Imagine image
)

USE MIHotels
IF OBJECT_ID('Departamente', 'U') is not null
	DROP TABLE Departamente
go
CREATE TABLE Departamente(
	DepartamentID int identity(4000,1) primary key,
	Nume nvarchar(32) not null,
	Descriere ntext
)

USE MIHotels
IF OBJECT_ID('Functii', 'U') is not null
	DROP TABLE Functii
go
CREATE TABLE Functii(
	FunctieID int identity(5000,1) primary key,
	Nume nvarchar(32) not null,
	Descriere ntext
)

USE MIHotels
IF OBJECT_ID('FunctiiAngajati', 'U') is not null
	DROP TABLE FunctiiAngajati
go
CREATE TABLE FunctiiAngajati(
	FunctieAngajatID int identity(6000,1) primary key,
	FunctieID int foreign key references Functii(FunctieID),
	AngajatID int foreign key references Angajati(AngajatID),
	DataNumire date not null,
	DataIesire date,
	Subordonat int foreign key references FunctiiAngajati(FunctieAngajatID)
)

USE MIHotels
IF OBJECT_ID('Impozite', 'U') is not null
	DROP TABLE Impozite
go
CREATE TABLE Impozite(
	ImpozitID int identity(7000,1) primary key,
	NumeImpozit nvarchar(32) not null,
	Procent float
)

USE MIHotels
IF OBJECT_ID('ImpoziteAngajati', 'U') is not null
	DROP TABLE ImpoziteAngajati
go
CREATE TABLE ImpoziteAngajati(
	ImpozitID int foreign key references Impozite(ImpozitID),
	AngajatID int foreign key references Angajati(AngajatID),
)

USE MIHotels
IF OBJECT_ID('Salarii', 'U') is not null
	DROP TABLE Salarii
go
CREATE TABLE Salarii(
	SalariuID int identity(8000,1) primary key,
	SalariuBrut int not null,
)

USE MIHotels
IF OBJECT_ID('SalariiFunctii', 'U') is not null
	DROP TABLE SalariiFunctii
go
CREATE TABLE SalariiFunctii(
	SalariuID int foreign key references Salarii(SalariuID),
	FunctieID int foreign key references Functii(FunctieID),
	DataIntrare date not null,
	DataIesire date
)

USE MIHotels
IF OBJECT_ID('Clienti', 'U') is not null
	DROP TABLE Clienti
go
CREATE TABLE Clienti(
	ClientID int primary key,
	Nume nvarchar(32) not null,
	Prenume nvarchar(32) not null,
	Adresa ntext,
	Oras nvarchar(32) not null,
	Telefon nvarchar(12),
	Buletin image
)

USE MIHotels
IF OBJECT_ID('Facilitati', 'U') is not null
	DROP TABLE Facilitati
go
CREATE TABLE Facilitati(
	FacilitateID int identity(9000,1) primary key,
	Nume nvarchar(32) not null,
	Descriere ntext
)

USE MIHotels
IF OBJECT_ID('Rezervari', 'U') is not null
	DROP TABLE Rezervari
go
CREATE TABLE Rezervari(
	RezervareID int identity(10000,1) primary key,
	FacilitateID int foreign key references Facilitati(FacilitateID),
	AngajatID int foreign key references Angajati(AngajatID)
)

USE MIHotels
IF OBJECT_ID('RezervariClienti', 'U') is not null
	DROP TABLE RezervariClienti
go
CREATE TABLE RezervariClienti(
	RezervareClientID int identity(100,1) primary key,
	RezervareID int foreign key references Rezervari(RezervareID),
	ClientID int foreign key references Clienti(ClientID),
	DataEfectuarii date not null,
	Discount float
)

USE MIHotels
IF OBJECT_ID('Cazare', 'U') is not null
	DROP TABLE Cazare
go
CREATE TABLE Cazare(
	CazareID int identity(200,1) primary key,
	DescriereCamera ntext,
	NumarLocuri int not null
)

USE MIHotels
IF OBJECT_ID('RezervariCazare', 'U') is not null
	DROP TABLE RezervariCazare
go
CREATE TABLE RezervariCazare(
	CazareID int foreign key references Cazare(CazareID),
	RezervareID int foreign key references Rezervari(RezervareID),
	DataCazare date not null,
	DataParasire date
)

USE MIHotels
IF OBJECT_ID('Restaurant', 'U') is not null
	DROP TABLE Restaurant
go
CREATE TABLE Restaurant(
	MeniuID int identity(300,1) primary key,
	DetaliiMeniu ntext,
	IngredienteAlergeni ntext
)

USE MIHotels
IF OBJECT_ID('RezervariRestaurant', 'U') is not null
	DROP TABLE RezervariRestaurant
go
CREATE TABLE RezervariRestaurant(
	MeniuID int foreign key references Restaurant(MeniuID),
	RezervareID int foreign key references Rezervari(RezervareID),
	DataRezervare date not null,
	OreRezervare int not null
)

USE MIHotels
IF OBJECT_ID('Agrement', 'U') is not null
	DROP TABLE Agrement
go
CREATE TABLE Agrement(
	AgrementID int identity(400,1) primary key,
	NumeActivitate nvarchar(64)
)

USE MIHotels
IF OBJECT_ID('RezervariAgrement', 'U') is not null
	DROP TABLE RezervariAgrement
go
CREATE TABLE RezervariAgrement(
	AgrementID int foreign key references Agrement(AgrementID),
	RezervareID int foreign key references Rezervari(RezervareID),
	DataRezervare date not null,
	OreRezervare int not null
)


USE MIHotels
IF OBJECT_ID('Chitante', 'U') is not null
	DROP TABLE Chitante
go
CREATE TABLE Chitante(
	ChitantaID int identity(500,1) primary key,
	RezervareClientID int foreign key references RezervariClienti(RezervareClientID),
	DataEmitere date not null,
)

USE MIHotels
IF OBJECT_ID('Preturi', 'U') is not null
	DROP TABLE Preturi
go
CREATE TABLE Preturi(
	PretID int identity(600,1) primary key,
	NumeServiciu nvarchar(32) not null,
	Valoare int not null
)

USE MIHotels
IF OBJECT_ID('PreturiCazare', 'U') is not null
	DROP TABLE PreturiCazare
go
CREATE TABLE PreturiCazare(
	PretCazareID int identity(700,1)primary key,
	CazareID int foreign key references Cazare(CazareID),
	PretID int foreign key references Preturi(PretID),
	DataIntrare date not null,
	DataIesire date
)

USE MIHotels
IF OBJECT_ID('PreturiRestaurant', 'U') is not null
	DROP TABLE PreturiRestaurant
go
CREATE TABLE PreturiRestaurant(
	PretMeniuID int identity(800,1)primary key,
	MeniuID int foreign key references Restaurant(MeniuID),
	PretID int foreign key references Preturi(PretID),
	DataIntrare date not null,
	DataIesire date
)

USE MIHotels
IF OBJECT_ID('PreturiAgrement', 'U') is not null
	DROP TABLE PreturiAgrement
go
CREATE TABLE PreturiAgrement(
	PretAgrementID int identity(900,1)primary key,
	AgrementID int foreign key references Agrement(AgrementID),
	PretID int foreign key references Preturi(PretID),
	DataIntrare date not null,
	DataIesire date
)

USE MIHotels
IF OBJECT_ID('AngajatiDepartamenteHoteluri', 'U') is not null
	DROP TABLE AngajatiDepartamenteHoteluri
go
CREATE TABLE AngajatiDepartamenteHoteluri(
	DepartamentID int foreign key references Departamente(DepartamentID),
	HotelID int foreign key references Hoteluri(HotelID),
	AngajatID int foreign key references Angajati(AngajatID),
	DataIntrare date,
	DataIesire date
)


--INSERARE DATE IN TABELE
INSERT INTO Hoteluri(Nume, Oras, Tara, Adresa, Telefon, Descriere)
VALUES('MIHotel', 'Bucuresti', 'Romania', 'Bulevardul Unirii, nr. 30-33', '+40745678769','Unul dintre cele mai moderne hoteluri este chiar la tine in oras'),
('MIHotel', 'Brasov', 'Romania', 'Bulevardul Garii, nr. 86', '+40745218454','Unul dintre cele mai moderne hoteluri este chiar la tine in oras'),
('MIHotel', 'Cluj-Napoca', 'Romania', 'Bulevardul Aurel Vlaicu, nr. 55', '+40721345677','Unul dintre cele mai moderne hoteluri este chiar la tine in oras')

INSERT INTO Departamente(Nume, Descriere)
VALUES ('Receptie', 'Gestionarea rezervarilor si clientilor'),
('Menaj', 'Asigurarea curateniei'),
('Securitate', 'Asigurarea ordinii si disciplinei'),
('Bucatarie', 'Gatirea si servirea mesei'),
('Management', 'Gestionarea hotelurilor, a personalului si a sumelor incasate')

INSERT INTO Angajati(Nume, Prenume, DataAngajarii, Adresa, Oras, Telefon)
Values ('Ionescu', 'Ioana', '2018-09-09', 'Strada Primaverii, nr. 102, bloc 3, etaj 3, ap. 30', 'Cluj-Napoca', '+40722556677'),
('Popescu', 'Ana', '2019-06-09', 'Strada Garii, nr. 3, bloc 55, etaj 10, ap. 89', 'Brasov', '+40723454578'),
('Marinescu', 'Vasile', '2018-06-07', 'Strada Muncii, nr. 199, bloc 3, etaj 2, ap. 12', 'Bucuresti', '+40722235687'),
('Pop', 'Ioana', '2020-09-09', 'Strada Painii, nr. 18, bloc 60, etaj 3, ap. 22', 'Cluj-Napoca', '+40746468577'),
('Ion', 'Ion', '2019-10-09', 'Strada Fabricii, nr. 50, bloc 22, etaj 2, ap. 10', 'Cluj-Napoca', '+40711145877'),
('Marin', 'Maria', '2018-08-09', 'Strada Aurel Vlaicu, nr. 10, bloc 99, etaj 1, ap. 17', 'Cluj-Napoca', '+40767712478'),
('Calin', 'Alin', '2019-06-12', 'Strada Primaverii, nr. 15, bloc 2, etaj 3, ap. 22', 'Cluj-Napoca', '+40726775555'),
('Ceusan', 'Ioana', '2020-11-09', 'Strada Teodor Mihali, nr. 1, bloc 10, etaj 4, ap. 43', 'Cluj-Napoca', '+40727889787'),
('Ionel', 'Mihai', '2019-08-09', 'Strada Primaverii, nr. 189, bloc 9, etaj 1, ap. 3', 'Bucuresti', '+40724569328'),
('Anghel', 'George', '2018-03-11', 'Strada Viilor, nr. 12, bloc 44, etaj 0, ap. 10', 'Bucuresti', '+40775478632'),
('Nemes', 'Diana', '2020-04-10', 'Strada Muncii, nr. 9, bloc 30, etaj 2, ap. 27', 'Bucuresti', '+40727845998'),
('Iordan', 'Georgiana', '2018-03-10', 'Strada Culturii, nr. 6, bloc 32, etaj 2, ap. 40', 'Bucuresti', '+40755667741'),
('Grigore', 'Geanina', '2018-06-03', 'Strada Mare, nr. 19, bloc 56, etaj 3, ap. 23', 'Bucuresti', '+40727755748'),
('Arsu', 'Ionel', '2020-09-09', 'Strada Republicii, nr. 1, bloc 1, etaj 1, ap. 10', 'Brasov', '+40722557457'),
('Mihaiu', 'Gabriela', '2018-09-09', 'Strada Soarelui, nr. 10, bloc 32, etaj 3, ap. 22', 'Brasov', '+40722677547'),
('Cornea', 'Monica', '2019-10-09', 'Strada Venus, nr. 22, bloc 43, etaj 1, ap. 19', 'Brasov', '+40722576654'),
('Padurean', 'Ioana', '2018-10-09', 'Strada Galati, nr. 12, bloc 31, etaj 0, ap. 1', 'Brasov', '+40722677474'),
('Muntean', 'Andrei', '2020-01-09', 'Strada Cetatii, nr. 1, bloc 2, etaj 4, ap. 10', 'Brasov', '+40723547895'),
('Mihali', 'Ionut', '2018-09-09', 'Strada Republicii, nr. 1, bloc 2, etaj 4, ap. 5', 'Brasov', '+40723587464')

INSERT INTO AngajatiDepartamenteHoteluri(DepartamentID, HotelID, AngajatID, DataIntrare, DataIesire)
VALUES (4000, 3000, 1012, '2018-06-03', null),
(4000, 3000, 1011, '2018-03-10', null),
(4001, 3000, 1010, '2020-04-10', null),
(4002, 3000, 1002, '2018-06-07', null),
(4003, 3000, 1008, '2019-08-09', null),
(4004, 3000, 1009, '2018-03-11', null),
(4000, 3001, 1001, '2019-06-09', null),
(4000, 3001, 1014, '2018-09-09', null),
(4001, 3001, 1015, '2019-10-09', null),
(4002, 3001, 1017, '2020-01-09', null),
(4003, 3001, 1013, '2020-09-09', null),
(4004, 3001, 1016, '2018-10-09', null),
(4004, 3001, 1018, '2018-06-07', null),
(4000, 3002, 1003, '2020-09-09', null),
(4000, 3002, 1005, '2018-08-09', null),
(4001, 3002, 1007, '2020-11-09', null),
(4002, 3002, 1004, '2019-10-09', null),
(4003, 3002, 1006, '2019-06-12', null),
(4004, 3002, 1000, '2018-09-09', null)

INSERT INTO Agrement(NumeActivitate)
VALUES ('Inot'), ('Tenis'), ('Drumetie'), ('Calarie'), ('Plimbare cu barca'), ('Plimbare cu ATV'), ('Fotbal')

INSERT INTO Cazare(DescriereCamera, NumarLocuri)
VALUES ('Camera dubla, pat matrimonial', 2),
('Camera dubla, 2 paturi single', 2),
('Camera single', 1),
('Camera tripla, 1 pat matrimonial + 1 pat single', 3),
('Camera tripla, 3 paturi single', 3)

INSERT INTO Clienti(ClientID, Nume, Prenume, Adresa, Oras, Telefon)
VALUES (2000, 'Vasile', 'Ioana', 'Strada Mare, nr.2', 'Margineni', '+40725457899'),
(2001, 'Gheorghe', 'Vlad', 'Strada Garii, nr.3, bloc 4, ap.33', 'Cravoia', '+40758696545'),
(2002, 'Ionescu', 'Anastasia', 'Strada Drumul Binelui, bloc 22, ap.32', 'Bucuresti', '+40725362425'),
(2003, 'Mihaescu', 'Mihai', null, 'Cluj-Napoca', '+40723452578'),
(2004, 'Buhaescu', 'Liliana', 'Strada Oltului, nr.33', 'Iasi', '+40785256545'),
(2005, 'Vaduva', 'Maria', 'Strada Mica, nr.34, ap.33', 'Fagaras', '+40725452219'),
(2006, 'Grigorescu', 'Vladina', 'Strada Lunga, nr.13', 'Brasov', '+40758654574'),
(2007, 'Popescu', 'Octavian', 'Strada Dragostei, bloc 2, ap.9', 'Focsani', '+40725252425'),
(2008, 'Moraru', 'Magdalena', null, 'Bucuresti', '+40723552478'),
(2009, 'Bunaciu', 'Laura', 'Strada Oasului, nr.23', 'Falticeni', '+40785247855'),
(2010, 'Grigore', 'Mirela', 'Strada Mare, nr.11', 'Bucuresti', '+40758441574'),
(2011, 'Pop', 'Oana', 'Strada Dealului, bloc 44, ap.4', 'Fagaras', '+40725111111'),
(2012, 'Muntean', 'Magda', null, 'Braila', '+40723512345'),
(2013, 'Banu', 'Laurentiu', 'Strada Ozonului, nr.1', 'Focsani', '+40714253655')

INSERT INTO Facilitati(Nume, Descriere)
VALUES ('Cazare', null),
('Restaurant', null),
('Agrement', null),
('All Inclusive', 'Cazare+Restaurant+Agrement')

INSERT INTO Functii(Nume, Descriere)
VALUES ('Angajat obisnuit', null),
('Sef tura', 'Responsabil de angajatii obisnuiti'),
('Sef departament', 'Responsabil de sefii de tura'),
('Manager', 'Responsabil de personal si hotel')

INSERT INTO FunctiiAngajati(FunctieID, AngajatID, DataNumire, Subordonat)
VALUES (5003, 1018, '2018-09-09', null),
(5002, 1012, '2018-06-03', 6000),
(5000, 1011, '2018-03-10', 6001), 
(5002, 1010, '2020-04-10', 6000),
(5002, 1002, '2018-06-07', 6000),
(5002, 1008, '2019-08-09', 6000),
(5002, 1009, '2018-03-11', 6000),
(5001, 1001, '2019-06-09', 6001),
(5000, 1014, '2018-09-09', 6007),
(5001, 1015, '2019-10-09', 6003),
(5001, 1017, '2020-01-09', 6004),
(5001, 1013, '2020-09-09', 6005),
(5001, 1016, '2018-10-09', 6006),
(5001, 1003, '2020-09-09', 6001),
(5000, 1005, '2018-08-09', 6013),
(5001, 1007, '2020-11-09', 6003),
(5001, 1004, '2019-10-09', 6004),
(5001, 1006, '2019-06-12', 6005),
(5001, 1000, '2018-09-09', 6006)

INSERT INTO Preturi(NumeServiciu, Valoare)
VALUES ('Sport', 100),
('Drumetie', 150),
('Single', 170),
('Duble', 250),
('Triple', 340),
('Mic dejun', 30),
('Pranz', 50),
('Cina', 40)

INSERT INTO PreturiAgrement(AgrementID, PretID, DataIntrare)
VALUES (400, 600, '2020-01-01'),
(401, 600, '2020-01-01'),
(403, 600, '2020-01-01'),
(406, 600, '2020-01-01'),
(402, 601, '2020-01-01'),
(404, 601, '2020-01-01'),
(405, 601, '2020-01-01')

INSERT INTO PreturiCazare(CazareID, PretID, DataIntrare)
VALUES (200, 603, '2020-01-01'),
(201, 603, '2020-01-01'),
(202, 602, '2020-01-01'),
(203, 604, '2020-01-01'),
(204, 604, '2020-01-01')

INSERT INTO Restaurant(DetaliiMeniu, IngredienteAlergeni)
VALUES ('Mic dejun englezesc', 'ou, produse din lapte'),
('Mic dejun frantuzesc', null),
('Mic dejun romanesc', 'ou, lapte, grasimi'),
('Piure, ceafa de porc, salata asortata, ciorba de perioare, placinta cu branza', null),
('Cartofi prajiti, piept de pui la gratar, ciorba de vacuta, negresa', null),
('Paste carbonara', null),
('Mamaliga cu branza si tochitura', null)

INSERT INTO PreturiRestaurant(MeniuID, PretID, DataIntrare)
VALUES (300, 605, '2020-01-01'),
(301, 605, '2020-01-01'),
(302, 605, '2020-01-01'),
(303, 606, '2020-01-01'),
(304, 606, '2020-01-01'),
(305, 607, '2020-01-01'),
(306, 607, '2020-01-01')

INSERT INTO Rezervari(FacilitateID, AngajatID)
VALUES (9000, 1012), (9002, 1012), (9000, 1014), (9001, 1013), (9002, 1003), (9001, 1006), (9000, 1003), (9003, 1003), (9000, 1001), (9001, 1014)

INSERT INTO RezervariClienti(RezervareID, ClientID, DataEfectuarii, Discount)
VALUES (10000, 2000, '2021-05-05', 0),
(10001, 2001, '2021-04-06', 0.05),
(10002, 2002, '2021-06-10', 0),
(10003, 2003, '2020-02-08', 0.1),
(10004, 2004, '2020-04-10', 0),
(10005, 2005, '2021-05-06', 0),
(10006, 2006, '2021-07-08', 0.05),
(10007, 2007, '2020-04-10', 0.05),
(10008, 2008, '2020-06-07', 0),
(10009, 2009, '2021-09-03', 0.1)

INSERT INTO RezervariAgrement(AgrementID, RezervareID, DataRezervare, OreRezervare)
VALUES (400, 10007, '2020-04-15', 3),
(402, 10001, '2021-04-08', 3),
(400, 10004, '2020-04-11', 2)

INSERT INTO RezervariCazare(CazareID, RezervareID, DataCazare, DataParasire)
VALUES (200, 10000,'2021-05-15', '2021-05-18'),
(201, 10002, '2021-06-12', '2021-06-19'),
(200, 10006, '2021-07-20', '2021-08-01'),
(203, 10007, '2020-04-14', '2020-04-16'),
(200, 10008, '2020-06-09', '2020-06-11')

INSERT INTO RezervariRestaurant(MeniuID, RezervareID, DataRezervare, OreRezervare)
VALUES (300, 10003, '2020-02-10', 8),
(303, 10003, '2020-02-10', 14),
(305, 10003, '2020-02-10', 19),
(300, 10005, '2021-05-7', 8.15),
(306, 10007, '2020-04-15', 18),
(304, 10009, '2021-09-03', 12.30)

INSERT INTO Salarii(SalariuBrut)
VALUES (2500), (3500), (4500), (5500) 

INSERT INTO SalariiFunctii(SalariuID, FunctieID, DataIntrare)
VALUES (8000, 5000, '2020-01-01'),
(8001, 5001, '2020-01-01'),
(8002, 5002, '2020-01-01'),
(8003, 5003, '2020-01-01')

INSERT INTO Chitante(RezervareClientID, DataEmitere)
VALUES (100, '2021-05-18'),
(101, '2021-04-08'),
(102, '2021-06-19'),
(103, '2020-02-10'),
(104, '2020-04-11'),
(105, '2021-05-7'),
(106, '2021-08-01'),
(107, '2020-04-16'),
(108, '2020-06-11'),
(109, '2021-09-03')

INSERT INTO Impozite(NumeImpozit, Procent)
VALUES ('Altele', 0.05),
('Impozit pr venit', 0.1),
('CASS', 0.1),
('CASS', 0.25)

INSERT INTO ImpoziteAngajati(ImpozitID, AngajatID)
VALUES (7000, 1010), (7001, 1010), (7002, 1010),
(7000, 1011), (7001, 1011), (7002, 1011),
(7000, 1012), (7001, 1012), (7002, 1012), (7003, 1012),
(7000, 1013), (7001, 1013), (7002, 1013),
(7000, 1014), (7001, 1014), (7002, 1014),
(7000, 1015), (7001, 1015), (7002, 1015), (7003, 1015),
(7000, 1016), (7001, 1016), (7002, 1016),
(7000, 1017), (7001, 1017), (7002, 1017),
(7000, 1018), (7001, 1018), (7002, 1018),
(7000, 1000), (7001, 1000), (7002, 1000),
(7000, 1001), (7001, 1001), (7002, 1001),
(7000, 1002), (7001, 1002), (7002, 1002),
(7000, 1003), (7001, 1003), (7002, 1003), (7003, 1003),
(7000, 1004), (7001, 1004), (7002, 1004),
(7000, 1005), (7001, 1005), (7002, 1005),
(7000, 1006), (7001, 1006), (7002, 1006), (7003, 1006),
(7000, 1007), (7001, 1007), (7002, 1007),
(7000, 1008), (7001, 1008), (7002, 1008),
(7000, 1009), (7001, 1009), (7002, 1009)


--VIEW-uri
--1. Sa se creeze un view pentru vizualizarea tuturor chitantelor emise.
IF OBJECT_ID('DetaliiChitante', 'V') is not null
	DROP VIEW DetaliiChitante;
GO
CREATE VIEW DetaliiChitante
AS
SELECT CH.ChitantaID, CH.DataEmitere, R.RezervareID, F.Nume as Facilitate, C.Nume + ' ' + C.Prenume as NumeClient, 
C.Adresa as AdresaFacturare, C.Oras as OrasFacturare, H.Nume as Hotel, H.Oras as OrasHotel, A.AngajatID, A.Nume + ' ' + A.Prenume as NumeAngajat
FROM Rezervari as R
INNER JOIN Facilitati as F
ON R.FacilitateID = F.FacilitateID
INNER JOIN RezervariClienti as RC
ON RC.RezervareID = R.RezervareID
INNER JOIN Clienti as C
ON RC.ClientID = C.ClientID
INNER JOIN Chitante as CH
On CH.RezervareClientID = RC.RezervareClientID
INNER JOIN Angajati as A
ON R.AngajatID = A.AngajatID
INNER JOIN AngajatiDepartamenteHoteluri as ADH
ON ADH.AngajatID = A.AngajatID
INNER JOIN Hoteluri as H
ON H.HotelID =ADH.HotelID
go

--2. Sa se un view pentru vizualizarea pretului rezervarilor de tip Cazare.
IF OBJECT_ID('PreturiRezervariCazare', 'V') is not null
	DROP VIEW PreturiRezervariCazare;
GO
CREATE VIEW PreturiRezervariCazare
AS
SELECT R.RezervareID, DIFFERENCE(RC.DataParasire, RC.DataCazare)*P.Valoare - DIFFERENCE(RC.DataParasire, RC.DataCazare)*P.Valoare*RCC.Discount as TotalPlata
FROM Rezervari as R
INNER JOIN RezervariCazare as RC
ON RC.RezervareID = R.RezervareID
INNER JOIN Cazare as C
ON C.CazareID = RC.CazareID
INNER JOIN PreturiCazare as PC
ON PC.CazareID = C.CazareID
INNER JOIN Preturi as P
ON P.PretID = PC.PretID
INNER JOIN RezervariClienti as RCC
On RCC.RezervareID = R.RezervareID
go

--3. Sa se un view pentru vizualizarea pretului rezervarilor de tip Restaurant.
IF OBJECT_ID('PreturiRezervariRestautant', 'V') is not null
	DROP VIEW PreturiRezervariRestaurant;
GO
CREATE VIEW PreturiRezervariRestaurant
AS
SELECT R.RezervareID, SUM(P.Valoare - P.Valoare*RCC.Discount) as TotalPlata
FROM Rezervari as R
INNER JOIN RezervariRestaurant as RR
ON RR.RezervareID = R.RezervareID
INNER JOIN Restaurant as Re
ON Re.MeniuID = RR.MeniuID
INNER JOIN PreturiRestaurant as PR
ON PR.MeniuID = Re.MeniuID
INNER JOIN Preturi as P
ON P.PretID = PR.PretID
INNER JOIN RezervariClienti as RCC
On RCC.RezervareID = R.RezervareID
GROUP BY R.RezervareID
go

--4. Sa se un view pentru vizualizarea pretului rezervarilor de tip Agrement.
IF OBJECT_ID('PreturiRezervariAgrement', 'V') is not null
	DROP VIEW PreturiRezervariAgrement;
GO
CREATE VIEW PreturiRezervariAgrement
AS
SELECT R.RezervareID, SUM(P.Valoare - P.Valoare*RCC.Discount) as TotalPlata 
FROM Rezervari as R
INNER JOIN RezervariAgrement as RA
ON RA.RezervareID = R.RezervareID
INNER JOIN Agrement as A
ON A.AgrementID = RA.AgrementID
INNER JOIN PreturiAgrement as PA
ON PA.AgrementID = A.AgrementID
INNER JOIN Preturi as P
ON P.PretID = PA.PretID
INNER JOIN RezervariClienti as RCC
On RCC.RezervareID = R.RezervareID
GROUP BY R.RezervareID
go

--5. Sa se un view pentru vizualizarea chitantele emise pentru rezervarile de tip Agrement.
IF OBJECT_ID('ChitanteRezervariAgrement', 'V') is not null
	DROP VIEW ChitanteRezervariAgrement;
GO
CREATE VIEW ChitanteRezervariAgrement
AS
SELECT DC.*, PRA.TotalPlata as TotalPlata
FROM DetaliiChitante as DC
INNER JOIN PreturiRezervariAgrement as PRA
ON PRA.RezervareID = DC.RezervareID
go

--6. Sa se un view pentru vizualizarea chitantele emise pentru rezervarile de tip Cazare.
IF OBJECT_ID('ChitanteRezervariCazare', 'V') is not null
	DROP VIEW ChitanteRezervariCazare;
GO
CREATE VIEW ChitanteRezervariCazare
AS
SELECT DC.*, PRC.TotalPlata as TotalPlata
FROM DetaliiChitante as DC
INNER JOIN PreturiRezervariCazare as PRC
ON PRC.RezervareID = DC.RezervareID
go

--7. Sa se un view pentru vizualizarea chitantele emise pentru rezervarile de tip Restaurant.
IF OBJECT_ID('ChitanteRezervariRestaurant', 'V') is not null
	DROP VIEW ChitanteRezervariRestaurant;
GO
CREATE VIEW ChitanteRezervariRestaurant
AS
SELECT DC.*, PRR.TotalPlata as TotalPlata
FROM DetaliiChitante as DC
INNER JOIN PreturiRezervariRestaurant as PRR
ON PRR.RezervareID = DC.RezervareID
go

--PROCEDURI STOCATE
--1. Sa se creeze o procedura stocata pentru aflarea comenzilor efectuate intr-o anumita perioada de timp.
IF OBJECT_ID('RezervariClientiPerioada', 'P') is not null
	DROP PROC RezervariClientiPerioada;
GO
CREATE PROC RezervariClientiPerioada
	@clientid as int,
	@datainceput as date,
	@datasfarsit as date
AS
BEGIN
	SELECT RezervareID, ClientID, DataEfectuarii
	FROM RezervariClienti
	WHERE ClientID = @clientid AND DataEfectuarii > @datainceput AND DataEfectuarii < @datasfarsit
	RETURN;
END
go
EXEC RezervariClientiPerioada
	@clientid = 2003,
	@datainceput = '2019-01-01',
	@datasfarsit = '2021-01-01'
go

--2. Sa se creeze o procedura stocata pentru afisare angajatilor dintr-un anumit oras, care lucreaza intr-un anumit departament.
IF OBJECT_ID('AngajatiOrasDepartament', 'P') is not null
	DROP PROC AngajatiOrasDepartament;
GO
CREATE PROC AngajatiOrasDepartament
	@oras as nvarchar(32),
	@departament as nvarchar(32)
AS
BEGIN
	SELECT A.AngajatID, A.Nume +' '+ A.Prenume as NumeAngajat, D.Nume as Departament, H.Oras as OrasMunca
	FROM Angajati as A
	INNER JOIN AngajatiDepartamenteHoteluri as ADH
	ON ADH.AngajatID = A.AngajatID
	INNER JOIN Hoteluri as H
	ON ADH.HotelID = H.HotelID
	INNER JOIN Departamente as D
	ON ADH.DepartamentID = D.DepartamentID
	WHERE @oras = H.Oras AND @departament = D.Nume
	RETURN;
END
go
EXEC AngajatiOrasDepartament
	@oras = 'Bucuresti',
	@departament = 'Receptie'

go
--3. Creati o procedura stocata care sa grupeze clientii in functie de anul in care au efectuat rezervari.
IF OBJECT_ID('ClientiRezervariAnual', 'P') is not null
	DROP PROC ClientiRezervariAnual;
GO
CREATE PROC ClientiRezervariAnual
	@an as int
AS
BEGIN
	SELECT C.ClientID, C.Nume + ' ' + C.Prenume as NumeClient, RC.RezervareID, RC.DataEfectuarii
	FROM Clienti as C
	INNER JOIN RezervariClienti as RC
	ON RC.ClientID = C.ClientID
	WHERE @an = YEAR(RC.DataEfectuarii)
	RETURN;
END
go
EXEC ClientiRezervariAnual
	@an = 2020
go

--4. Creati o procedura stocata care sa afiseze angajatii care au slariul brut cuprins intre 2 valori date in momentul apelarii procedurii.
IF OBJECT_ID('AngajatiSalariu', 'P') is not null
	DROP PROC AngajatiSalariu;
GO
CREATE PROC AngajatiSalariu
	@v1 as int,
	@v2 as int
AS
BEGIN
	SELECT A.AngajatID, A.Nume, A.Prenume, FA.FunctieAngajatID, S.SalariuBrut
	FROM Angajati as A
	INNER JOIN FunctiiAngajati as FA
	ON FA.AngajatID = A.AngajatID
	INNER JOIN SalariiFunctii as SF
	ON SF.FunctieID = FA.FunctieID
	INNER JOIN Salarii as S
	ON S.SalariuID = SF.SalariuID
	WHERE S.SalariuBrut > @v1 AND S.SalariuBrut < @v2
	RETURN;
END
go
EXEC AngajatiSalariu
	@v1 = 1500,
	@v2 = 3600
go

--5. Creati o procedura stocata care sa afiseze toate rezervarile care sunt facute pentru anumite facilitati.
IF OBJECT_ID('RezervariFacilitati', 'P') is not null
	DROP PROC RezervariFacilitati;
GO
CREATE PROC RezervariFacilitati
	@facilitate as nvarchar(32)
AS
BEGIN
	SELECT R.RezervareID, RC.ClientID, RC.DataEfectuarii, R.AngajatID, F.Nume as Facilitate
	FROM Rezervari as R
	INNER JOIN Facilitati as F
	ON F.FacilitateID = R.FacilitateID
	INNER JOIN RezervariClienti as RC
	ON RC.RezervareID = R.RezervareID
	WHERE F.Nume = @facilitate
	RETURN;
END
go
EXEC RezervariFacilitati
	 @facilitate = 'Cazare'
go

--6. Sa se creeza o procedura stocata care sa afiseze clientii care au efectuat mai mult de n rezervari la un hotel, dintr-un anumit oras.
IF OBJECT_ID('RezervariClientiOras', 'P') is not null
	DROP PROC RezervariClientiOras;
GO
CREATE PROC RezervariClientiOras
	@n as int,
	@oras as nvarchar(32)
AS
BEGIN
WITH ss as(
	SELECT C.ClientID, COUNT(R.RezervareID) as NumarRezervari
	FROM Rezervari as R
	INNER JOIN RezervariClienti as RC
	ON RC.RezervareID = R.RezervareID
	INNER JOIN Clienti as C
	ON RC.ClientID = C.ClientID
	GROUP BY C.ClientID
	)
	SELECT	ss.ClientID, ss.NumarRezervari, H.Oras
	FROM RezervariClienti as RC
	INNER JOIN ss
	ON ss.ClientID = RC.ClientID
	INNER JOIN Rezervari as R
	ON R.RezervareID = RC.RezervareID
	INNER JOIN Angajati as A
	ON A.AngajatID = R.AngajatID
	INNER JOIN AngajatiDepartamenteHoteluri as ADH
	ON ADH.AngajatID = A.AngajatID
	INNER JOIN Hoteluri as H
	ON H.HotelID =ADH.HotelID
	WHERE ss.NumarRezervari > @n AND H.Oras = @oras
	RETURN;
END
go
EXEC RezervariClientiOras
	@n = 0,
	@oras = 'Brasov'
go

--7. Sa se creeze o procedura stocata care sa afiseze toate chitantele eliberate mai tarziu de o anumita data, mentionata in apelul procedurii si care au id par.
IF OBJECT_ID('ChitanteData', 'P') is not null
	DROP PROC ChitanteData;
GO
CREATE PROC ChitanteData
	@date as date
AS
BEGIN
SELECT *
FROM DetaliiChitante as D
WHERE D.DataEmitere > @date AND D.ChitantaID % 2 = 0
END
go
EXEC ChitanteData
	@date = '2019-12-12'
go

--8. Utilizand o procedura stocata, afisati toti angajatii care ocupa o anumita functie, precum si hotelul in care lucreaza.
IF OBJECT_ID('AngajatiFunctiiHotel', 'P') is not null
	DROP PROC AngajatiFunctiiHotel;
GO
CREATE PROC AngajatiFunctiiHotel
	@functie as nvarchar(32)
AS
BEGIN
SELECT A.*, F.Nume as Functia, H.Nume + ' ' + H.Oras as Hotel
FROM Angajati as A
INNER JOIN FunctiiAngajati as FA
ON FA.AngajatID = A.AngajatID
INNER JOIN Functii as F
ON F.FunctieID = FA.FunctieID
INNER JOIN AngajatiDepartamenteHoteluri as ADH
ON ADH.AngajatID = A.AngajatID
INNER JOIN Hoteluri as H
ON H.HotelID = ADH.HotelID
WHERE F.Nume = @functie
END
go
EXEC AngajatiFunctiiHotel
	@functie = 'Sef tura'
go

--9. Sa se creeze o procedura stocata care sa afiseze toate rezervarile de Restaurant care au comandat un anumit meniu.
IF OBJECT_ID('RezervariRestaurantMeniu', 'P') is not null
	DROP PROC RezervariRestaurantMeniu;
GO
CREATE PROC RezervariRestaurantMeniu
	@meniu as ntext
AS
BEGIN
SELECT R.RezervareID, R.FacilitateID, RR.DataRezervare, RE.*
FROM Rezervari as R
INNER JOIN RezervariRestaurant as RR
ON RR.RezervareID = R.RezervareID
INNER JOIN Restaurant as RE
ON RE.MeniuID = RR.MeniuID
WHERE RE.DetaliiMeniu like @meniu
END
go
EXEC RezervariRestaurantMeniu
	@meniu = 'Mic dejun englezesc'
go

--10. Sa se creeze o procedura stocata pentru afisarea detaliilor despre rezervarile de tip Agrement, pentru o anumita activitate.
IF OBJECT_ID('RezervariAgrementActivitati', 'P') is not null
	DROP PROC RezervariAgrementActivitati;
GO
CREATE PROC RezervariAgrementActivitati
	@activitate as nvarchar(32)
AS
BEGIN
SELECT R.RezervareID, R.FacilitateID, RA.DataRezervare, A.NumeActivitate
FROM Rezervari as R
INNER JOIN RezervariAgrement as RA
ON RA.RezervareID = R.RezervareID
INNER JOIN Agrement as A
ON A.AgrementID = RA.AgrementID
WHERE @activitate = A.NumeActivitate
END

EXEC RezervariAgrementActivitati
	@activitate = 'inot'

--TRIGGERE
--1. Sa se creeze un trigger care sa afiseze un mesaj de confirmare dupa inserarea unei noi rezervari de cazare.
IF OBJECT_ID('TRezervareCazare', 'TR') IS NOT NULL
DROP TRIGGER TRezervareCazare;
GO
CREATE TRIGGER TRezervareCazare
ON Rezervari
AFTER INSERT
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS(SELECT *
	FROM Rezervari AS R
	INNER JOIN Facilitati AS F
	ON F.FacilitateID = R.FacilitateID
	WHERE F.Nume = 'Cazare')

	BEGIN
			print 'Insert Cazare'
	END
END

--2. Sa se creeze un trigger care sa afiseze un mesaj de confirmare dupa inserarea unei noi rezervari de agrement.
IF OBJECT_ID('TRezervareAgrement', 'TR') IS NOT NULL
DROP TRIGGER TRezervareAgrement;
GO
CREATE TRIGGER TRezervareAgrement
ON Rezervari
AFTER INSERT
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS(SELECT *
	FROM Rezervari AS R
	INNER JOIN Facilitati AS F
	ON F.FacilitateID = R.FacilitateID
	WHERE F.Nume = 'Agrement')

	BEGIN
			print 'Insert Agrement'
	END
END

--3. Sa se creeze un trigger care sa afiseze un mesaj de confirmare dupa inserarea unei noi rezervari de restaurant.
IF OBJECT_ID('TRezervareRestaurant', 'TR') IS NOT NULL
DROP TRIGGER TRezervareRestaurant;
GO
CREATE TRIGGER TRezervareRestaurant
ON Rezervari
AFTER INSERT
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS(SELECT *
	FROM Rezervari AS R
	INNER JOIN Facilitati AS F
	ON F.FacilitateID = R.FacilitateID
	WHERE F.Nume = 'Restaurant')

	BEGIN
			print 'Insert Restaurant'
	END
END

--4. Sa se creeze un trigger care sa afiseze un mesaj de confirmare dupa inserarea unei noi rezervari de tip All Inclusive.
IF OBJECT_ID('TRezervareAllInclusive', 'TR') IS NOT NULL
DROP TRIGGER TRezervareAllInclusive;
GO
CREATE TRIGGER TRezervareAllInclusive
ON Rezervari
AFTER INSERT
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS(SELECT *
	FROM Rezervari AS R
	INNER JOIN Facilitati AS F
	ON F.FacilitateID = R.FacilitateID
	WHERE F.Nume = 'All Inclusive')

	BEGIN
			print 'Insert All Inclusive'
	END
END

--5. Sa se creeze un trigger care sa afiseze un mesaj dupa fiecare delete executat asupra unui angajat mai vechi de 2 ani in companie.
IF OBJECT_ID('TAngajatiVechime', 'TR') IS NOT NULL
DROP TRIGGER TAngajatiVechime;
GO
CREATE TRIGGER TAngajatiVechime
ON Angajati
AFTER INSERT
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS(SELECT *
	FROM Angajati
	WHERE Year('2022-05-08') - YEAR(DataAngajarii) > 2)
	BEGIN
			print 'Delete Angajat'
	END
END

--6. Sa se creeze un trigger care sa nu permita dublarea unei facilitati deja existente, dupa insert sau delete.
IF OBJECT_ID('TFacilitati', 'TR') IS NOT NULL
DROP TRIGGER TFacilitati;
GO
CREATE TRIGGER TFacilitati
ON Facilitati
AFTER INSERT, UPDATE
AS
BEGIN
IF @@ROWCOUNT = 0 RETURN;
SET NOCOUNT ON;
IF EXISTS (SELECT COUNT(*)
FROM Inserted AS I
JOIN Facilitati AS F
ON I.FacilitateID = F.FacilitateID
GROUP BY I.FacilitateID
HAVING COUNT(*) > 1 )
BEGIN
THROW 50000, 'Exista deja aceasta facilitate!', 0;
END
END

--7. Sa se creeze un trigger care sa nu permita adaugare unei noi rezervari de tip agrement, cand activitatea aleasa este deja ocupata.
IF OBJECT_ID('TAgrement', 'TR') IS NOT NULL
DROP TRIGGER TAgrement;
GO
CREATE TRIGGER TAgrement
ON RezervariAgrement
AFTER INSERT, UPDATE
AS
BEGIN
IF @@ROWCOUNT = 0 RETURN;
SET NOCOUNT ON;
IF EXISTS (SELECT COUNT(*)
FROM Inserted AS I
JOIN RezervariAgrement as RA
ON RA.RezervareID = I.RezervareID
INNER JOIN Agrement as A
ON A.AgrementID = I.AgrementID
GROUP BY I.DataRezervare, A.NumeActivitate
HAVING COUNT(*) > 1)
BEGIN
THROW 50000, 'Data selectata nu este disponibila!', 0;
END
END

--8. Sa se creze un trigger care sa nu permita modificarea salariului unui angajat cu mai mult de 1000 de lei.
IF OBJECT_ID('TSalariu', 'TR') IS NOT NULL
DROP TRIGGER TSalariu;
GO
CREATE TRIGGER TSalariu
ON Salarii
AFTER UPDATE
AS
BEGIN
IF @@ROWCOUNT = 0 RETURN;
SET NOCOUNT ON;
IF EXISTS (SELECT COUNT(*)
FROM Inserted AS I
JOIN Salarii as S
ON S.SalariuID = I.SalariuID
WHERE I.SalariuBrut - S.SalariuBrut > 1000)
BEGIN
THROW 50000, 'Actiune nepermisa! Salariu prea mare!', 0;
END
END

--9. Sa se creeze un trigger care sa afiseze un mesaj corespunzator dupa stergere unui angajat din departamentul de "Receptie".
IF OBJECT_ID('TAngajatReceptie', 'TR') IS NOT NULL
DROP TRIGGER TAngajatReceptie;
GO
CREATE TRIGGER TAngajatReceptie
ON Angajati
AFTER DELETE
AS
BEGIN
IF @@ROWCOUNT = 0 RETURN;
SET NOCOUNT ON;
IF EXISTS (SELECT *
	FROM Angajati as A
	INNER JOIN AngajatiDepartamenteHoteluri as ADH
	ON ADH.AngajatID = A.AngajatID
	INNER JOIN Departamente as D
	On D.DepartamentID = ADH.DepartamentID
	WHERE D.Nume = 'Receptie')
BEGIN
	PRINT 'Ati sters un angajat din departamentul Receptie!';
END
END

--10. Sa se creeze un trigger care sa afiseze un mesaj corespunzator dupa adaugarea unui nou client, care a efectuat o rezervare de tip Cazare.
IF OBJECT_ID('TClientCazare', 'TR') IS NOT NULL
DROP TRIGGER TClientCazare;
GO
CREATE TRIGGER TClientCazare
ON Clienti
AFTER INSERT
AS
BEGIN
IF @@ROWCOUNT = 0 RETURN;
SET NOCOUNT ON;
IF EXISTS (SELECT *
	FROM Clienti as C
	INNER JOIN RezervariClienti as RC
	ON C.ClientID = RC.ClientID
	INNER JOIN Rezervari as R
	ON R.RezervareID = RC.RezervareID
	INNER JOIN Facilitati as F
	ON F.FacilitateID = R.FacilitateID
	WHERE F.Nume = 'Cazare')
BEGIN
	PRINT 'Clientula efectuat o rezervare de tip cazare!';
END
END

--11. Sa se creeze un trigger care sa afiseze un mesaj corespunzator dupa adaugarea unui nou client, care a efectuat o rezervare de tip Agrement.
IF OBJECT_ID('TClientAgrement', 'TR') IS NOT NULL
DROP TRIGGER TClientAgrement;
GO
CREATE TRIGGER TClientAgrement
ON Clienti
AFTER INSERT
AS
BEGIN
IF @@ROWCOUNT = 0 RETURN;
SET NOCOUNT ON;
IF EXISTS (SELECT *
	FROM Clienti as C
	INNER JOIN RezervariClienti as RC
	ON C.ClientID = RC.ClientID
	INNER JOIN Rezervari as R
	ON R.RezervareID = RC.RezervareID
	INNER JOIN Facilitati as F
	ON F.FacilitateID = R.FacilitateID
	WHERE F.Nume = 'Agrement')
BEGIN
	PRINT 'Clientula efectuat o rezervare de tip Agrement!';
END
END

--12. Sa se creeze un trigger care sa afiseze un mesaj corespunzator dupa adaugarea unui nou client, care a efectuat o rezervare de tip Restaurant.
IF OBJECT_ID('TClientRestaurant', 'TR') IS NOT NULL
DROP TRIGGER TClientRestaurant;
GO
CREATE TRIGGER TClientRestaurant
ON Clienti
AFTER INSERT
AS
BEGIN
IF @@ROWCOUNT = 0 RETURN;
SET NOCOUNT ON;
IF EXISTS (SELECT *
	FROM Clienti as C
	INNER JOIN RezervariClienti as RC
	ON C.ClientID = RC.ClientID
	INNER JOIN Rezervari as R
	ON R.RezervareID = RC.RezervareID
	INNER JOIN Facilitati as F
	ON F.FacilitateID = R.FacilitateID
	WHERE F.Nume = 'Restaurant')
BEGIN
	PRINT 'Clientula efectuat o rezervare de tip Restaurant!';
END
END

--13. Sa se creeze un trigger care sa afiseze un mesaj corespunzator dupa adaugarea unui nou client, care a efectuat o rezervare de tip All Inclusive.
IF OBJECT_ID('TClientAllInclusive', 'TR') IS NOT NULL
DROP TRIGGER TClientAllInclusive;
GO
CREATE TRIGGER TClientAllInclusive
ON Clienti
AFTER INSERT
AS
BEGIN
IF @@ROWCOUNT = 0 RETURN;
SET NOCOUNT ON;
IF EXISTS (SELECT *
	FROM Clienti as C
	INNER JOIN RezervariClienti as RC
	ON C.ClientID = RC.ClientID
	INNER JOIN Rezervari as R
	ON R.RezervareID = RC.RezervareID
	INNER JOIN Facilitati as F
	ON F.FacilitateID = R.FacilitateID
	WHERE F.Nume = 'All Inclusive')
BEGIN
	PRINT 'Clientula efectuat o rezervare de tip All Inclusive!';
END
END

--CERINTE
--SELECT
--Cerinta 1
--Sa se afiseze toti clienti(Nume, Prenume) al caror nume incepe cu litera "B" si prenumele cu litera "L".
SELECT Nume, Prenume
FROM Clienti
WHERE Nume LIKE 'B%' AND Prenume LIKE 'L%'

--Cerinta 2
--Sa se afiseze toti angajatii(Nume, Prenume, DataAngajarii) care s-au angajat mai tarziu de 01.01.2020.
SELECT Nume, Prenume, DataAngajarii
FROM Angajati
WHERE DataAngajarii > '2020-01-01'

--Cerinta 3
--Sa se afiseze toate meniurile care nu contin alergeni.
SELECT MeniuID, DetaliiMeniu
FROM Restaurant
WHERE IngredienteAlergeni IS NULL

--Cerinta 4
--Sa se afiseze toate rezervarile(ID, DataEfectuarii, NumeClient) care au fost efectuate cu facilitatea "Agrement" si mai tarziu de 01.01.2020.
SELECT R.RezervareID, RC.DataEfectuarii, C.Nume
FROM Rezervari as R
INNER JOIN Facilitati as F
ON R.FacilitateID = F.FacilitateID
INNER JOIN RezervariClienti as RC
ON RC.RezervareID = R.RezervareID
INNER JOIN Clienti as C
ON C.ClientID = RC.ClientID
WHERE F.Nume = 'Agrement' AND DataEfectuarii > '2020-01-01'

--Cerinta 5
--Afisati toti angajatii(Nume, Prenume, hotel, departament, functie) care lucreaza la hotelul din Cluj-Napoca, la departamentul "Receptie" si au functia de "Sef tura".
SELECT A.Nume, A.Prenume, H.Nume as Hotel, D.Nume as Departament, F.Nume as Functie
FROM Angajati as A
INNER JOIN FunctiiAngajati as AF
ON A.AngajatID = AF.AngajatID
INNER JOIN Functii as F
ON F.FunctieID = AF.FunctieID
INNER JOIN AngajatiDepartamenteHoteluri as ADH
ON A.AngajatID = ADH.AngajatID
INNER JOIN Departamente as D
ON D.DepartamentID = ADH.DepartamentID
INNER JOIN Hoteluri as H
ON H.HotelID = ADH.HotelID
WHERE H.Oras = 'Cluj-Napoca' AND F.Nume = 'Sef tura' AND D.Nume = 'Receptie'

--Cerinta 6
--Afisati toti angajatii(Nume, Prenume, ValoareSalariu) care au un salariu mai mare de 4000(fiind incluse si impozitele).
SELECT A.Nume, A.Prenume, S.SalariuBrut as ValoareSalariu
FROM Angajati as A
INNER JOIN FunctiiAngajati as FA
ON A.AngajatID = FA.AngajatID
INNER JOIN Functii as F
ON FA.FunctieID = F.FunctieID
INNER JOIN SalariiFunctii as SA
ON SA.FunctieID = F.FunctieID
INNER JOIN Salarii as S
ON S.SalariuID = SA.SalariuID
WHERE S.SalariuBrut > 4000

--Cerinta 7
--Afisati clientii(Nume, Prenume, Data efectuarii rezervarii, Data rezervarii) care au efectuat o rezervare pentru Restaurant si au comandat "Mic dejun englezesc".
SELECT C.Nume, C.Prenume, RC.DataEfectuarii as DataEfectuarii, RR.DataRezervare
FROM Clienti as C
INNER JOIN RezervariClienti as RC
ON RC.ClientID = C.ClientID
INNER JOIN Rezervari as R
ON R.RezervareID = RC.RezervareID
INNER JOIN Facilitati as F
ON R.FacilitateID = F.FacilitateID
INNER JOIN RezervariRestaurant as RR
ON RR.RezervareID = R.RezervareID
INNER JOIN Restaurant as RE
ON RE.MeniuID = RR.MeniuID
WHERE F.Nume = 'Restaurant' AND RE.DetaliiMeniu LIKE 'Mic dejun englezesc'

--Cerinta 8
--Afisati preturile si numele serviciilor de agrement, care fac parte din categoria "Sport" si sunt mai scumpe de 100 de lei pe ora.
SELECT A.NumeActivitate, P.Valoare as Pret
FROM Preturi as P
INNER JOIN PreturiAgrement as PA
ON PA.PretID = P.PretID
INNER JOIN Agrement as A
ON A.AgrementID = PA.AgrementID
WHERE P.Valoare > 50 AND P.NumeServiciu = 'Sport'

--Cerinta 9
--Afisati toti angajatii(Nume, Prenume, Functie) care il au sef direct pe "Mihali Ionut".
SELECT A.Nume, A.Prenume, F.Nume as Functie
FROM Angajati as A
INNER JOIN FunctiiAngajati as FA
ON FA.AngajatID = A.AngajatID
INNER JOIN Functii as F
ON F.FunctieID = FA.FunctieID
INNER JOIN FunctiiAngajati as FFA
ON FFA.FunctieAngajatID = FA.Subordonat
INNER JOIN Angajati as AA
ON AA.AngajatID = FFA.AngajatID
WHERE AA.Nume = 'Mihali' AND AA.Prenume = 'Ionut'

--Cerinta 10
--Afisati rezervarile de la Cazare, in functie de data efectuarii.
SELECT R.RezervareID, F.Nume as Facilitate, RC.DataEfectuarii
FROM Rezervari as R
INNER JOIN Facilitati as F
ON F.FacilitateID = R.FacilitateID
INNER JOIN RezervariClienti as RC
ON RC.RezervareID = R.RezervareID
WHERE F.Nume = 'Cazare' 
ORDER BY RC.DataEfectuarii

--Cerinta 11
--Afisati rezervarile de la Restaurant, ordonate dupa discount-ul acordat.
SELECT R.RezervareID, F.Nume as Facilitate, RC.Discount
FROM Rezervari as R
INNER JOIN Facilitati as F
ON F.FacilitateID = R.FacilitateID
INNER JOIN RezervariClienti as RC
ON RC.RezervareID = R.RezervareID
WHERE F.Nume = 'Restaurant' 
ORDER BY RC.Discount DESC

--Cerinta 12
--Afisati angajatii al caror nume incepe cu litera "I" si au fost angajati dupa 01.03.2019.
SELECT Nume, Prenume, DataAngajarii
FROM Angajati 
WHERE Nume LIKE 'I%' AND DataAngajarii > '2019-03-01'

--Cerinta 13
--Afisati angajatii(Nume, Prenume, Oras) care au adresa de domiciliu in acelasi oras cu unul dintre hoteluri, numarul lor de telefon avand prima cifra disticta egala cu "2".
SELECT A.Nume, A.Prenume, A.Oras, H.Nume
FROM Angajati as A
INNER JOIN AngajatiDepartamenteHoteluri as ADH
ON ADH.AngajatID = A.AngajatID
INNER JOIN Hoteluri as H
ON H.HotelID = ADH.HotelID AND A.Telefon LIKE '____2%'

--Cerinta 14
--Afisati clientii(Nume, Prenume, Oras, DataEfectuarii) care au facut o rezervare dupa 01.01.2021 si locuiesc intr-un oras al carui nume incepe cu litera "F".
SELECT C.Nume, C.Prenume, C.Oras, RC.DataEfectuarii
FROM Clienti as C
INNER JOIN RezervariClienti as RC
ON RC.ClientID = C.ClientID
WHERE C.Oras LIKE 'F%' AND RC.DataEfectuarii > '2021-01-01'

--Cerinta 15
--Afisati toti angajatii(Nume, Prenume, Telefon) al caror numar de telefon se termina intr-0 cifra para si al caror prenume incepe cu litera "M".
SELECT Nume, Prenume, Telefon as NumarTelefon
FROM Angajati 
WHERE Telefon LIKE '%[02468]' AND Prenume LIKE 'M%'

--Cerinta 16
--Afisati toti angajatii(Nume, Prenume, Oras) care lucreaza la un hotel dintr-un oras al carui nume incepe cu litera "B", ordonati alfabetic dupa prenume
SELECT A.Nume, A.Prenume, H.Oras
FROM Angajati as A
INNER JOIN AngajatiDepartamenteHoteluri as ADH
ON ADH.AngajatID = A.AngajatID
INNER JOIN Hoteluri as H
On ADH.HotelID = H.HotelID
WHERE H.Oras LIKE 'B%' 
ORDER BY A.Prenume

--Cerinta 17
--Ordonati rezervarile, al caror Id este par, efectuate pentru facilitatea Cazare. Ordonarea se va face dupa DataCazarii.
SELECT R.RezervareID, F.Nume as Facilitate, RCA.DataCazare
FROM Rezervari as R
INNER JOIN Facilitati as F
On F.FacilitateID = R.FacilitateID
INNER JOIN RezervariCazare as RCA
ON RCA.RezervareID = R.RezervareID
WHERE R.RezervareID LIKE '%[02468]' AND F.Nume = 'Cazare'
ORDER BY RCA.DataCazare

--Cerinta 18
--Afisati orasele din care provin clientii(o singur data), ordonate invers alfabetic.
SELECT DISTINCT Oras as OrasProvinienta
FROM Clienti
ORDER BY Oras DESC

--Cerinta 19
--Afisati angajatii(Nume, Prenume, Functia, Departamentul, Salariu) care lucreaza in departamentul "Receptie" si au salariul mai mare de 2000 de lei. Rezultatul va fi ordonat in functie de salariu, descrescator.
SELECT A.Nume, A.Prenume, F.Nume as Functie, D.Nume as Departament, S.SalariuBrut as Salariu
FROM Angajati as A
INNER JOIN AngajatiDepartamenteHoteluri as ADH
ON ADH.AngajatID = A.AngajatID
INNER JOIN FunctiiAngajati as FA
ON FA.AngajatID = A.AngajatID
INNER JOIN Functii as F
On F.FunctieID = FA.FunctieID
INNER JOIN Departamente as D
ON D.DepartamentID = ADH.DepartamentID
INNER JOIN SalariiFunctii as SF
ON SF.FunctieID = F.FunctieID
INNER JOIN Salarii as S
ON S.SalariuID = SF.SalariuID
WHERE D.Nume = 'Receptie' AND S.SalariuBrut > 2000
ORDER BY S.SalariuBrut DESC

--Cerinta 20
--Afisati angajatii(Nume, Prenume, Functia, dataAngajarii) obisnuiti, care au fost angajati dupa data de 01.01.2018 si al caror nume incepe cu litera "M" sau "I", ordonati dupa data angajarii.
SELECT A.Nume, A.Prenume, F.Nume as Functie, A.DataAngajarii
FROM Angajati as A
INNER JOIN FunctiiAngajati as FA
ON FA.AngajatID = A.AngajatID
INNER JOIN Functii as F
ON F.FunctieID = FA.FunctieID
WHERE F.Nume = 'Angajat obisnuit' AND A.DataAngajarii > '01.01.2018' AND A.Nume LIKE '[MI]%'

--Cerinta 21
--Afisati numarul total de rezervari procesate de fiecare angajat(ID).
SELECT R.AngajatID, COUNT(RezervareID) as NumarRezervari
FROM Rezervari as R
GROUP BY R.AngajatID;


--Cerinta 22
--Afisati pretul mediu al unui serviciu de tip Restaurant.
SELECT AVG(Valoare) as PretMediuRestaurant
FROM Preturi
WHERE NumeServiciu = 'Pranz' or NumeServiciu = 'Cina' or NumeServiciu = 'Mic dejun'

--Cerinta 23
--Afisati numarul angajatilor care au inceput sa lucreze in fiecare an.
SELECT YEAR(DataAngajarii) as AnulAngajarii, COUNT(AngajatID) as NrAngajati
FROM Angajati
GROUP BY YEAR(DataAngajarii)

--Cerinta 24
--Calculati pretul rezervarilor de tip Cazare.
SELECT R.RezervareID, DIFFERENCE(RC.DataParasire, RC.DataCazare)*P.Valoare - DIFFERENCE(RC.DataParasire, RC.DataCazare)*P.Valoare*RCC.Discount as TotalPlata
FROM Rezervari as R
INNER JOIN RezervariCazare as RC
ON RC.RezervareID = R.RezervareID
INNER JOIN Cazare as C
ON C.CazareID = RC.CazareID
INNER JOIN PreturiCazare as PC
ON PC.CazareID = C.CazareID
INNER JOIN Preturi as P
ON P.PretID = PC.PretID
INNER JOIN RezervariClienti as RCC
On RCC.RezervareID = R.RezervareID

--Cerinta 25
--Afisati numarul de rezervari efectuate in fiecare an, ordonate dupa anul efectuarii, crescator.
SELECT YEAR(DataEfectuarii) as An,COUNT(RezervareClientID) as NrRezervari
FROM RezervariClienti 
GROUP BY YEAR(DataEfectuarii)
ORDER BY YEAR(DataEfectuarii)

--Cerinta 26
--Afisati angajatii care au inceput sa lucreze intr-o zi para, a unei luni pare.
SELECT AngajatID, Nume, Prenume
FROM Angajati
WHERE MONTH(DataAngajarii) LIKE '%[02468]' AND DAY(DataAngajarii) LIKE '%[02468]'

--Cerinta 27
--Afisati toate rezervarile facute de un client al carui prenume incepe cu litera "M", sunt rezervari de din categoria Restaurant si au fost efectuate intr-o zi para.
SELECT R.RezervareID, C.Nume, C.Prenume, F.Nume as Facilitate, RC.DataEfectuarii
FROM Rezervari as R
INNER JOIN RezervariClienti as RC
ON R.RezervareID = RC.RezervareID
INNER JOIN Clienti as C
ON C.ClientID = RC.ClientID
INNER JOIN Facilitati as F
ON R.FacilitateID = F.FacilitateID
WHERE C.Prenume LIKE 'M%' AND F.Nume = 'Restaurant' AND DAY(RC.DataEfectuarii) LIKE '%[02468]'

--Cerinta 28
--Afisati numarul de rezervari pentru fiecare tip de facilitate.
SELECT F.Nume, COUNT(R.RezervareID) as NrRezervari
FROM Rezervari as R
INNER JOIN Facilitati as F
On F.FacilitateID = R.FacilitateID
GROUP BY F.Nume

--Cerinta 29
--Afisati chitanta emisa catre clientul Popescu Octavian. O chitanta va contine: IDChitanta, DataEmiterii, IDRezervare, Facilitate, numele, prenumele si adresa clintului, hotelul(nume, oras), angajatul care s-a ocupat de rezervare(ID, nume)
SELECT CH.ChitantaID, CH.DataEmitere, R.RezervareID, F.Nume as Facilitate, C.Nume + ' ' + C.Prenume as NumeClient, 
C.Adresa as AdresaFacturare, C.Oras as OrasFacturare, H.Nume as Hotel, H.Oras as OrasHotel, A.AngajatID, A.Nume + ' ' + A.Prenume as NumeAngajat
FROM Rezervari as R
INNER JOIN Facilitati as F
ON R.FacilitateID = F.FacilitateID
INNER JOIN RezervariClienti as RC
ON RC.RezervareID = R.RezervareID
INNER JOIN Clienti as C
ON RC.ClientID = C.ClientID
INNER JOIN Chitante as CH
On CH.RezervareClientID = RC.RezervareClientID
INNER JOIN Angajati as A
ON R.AngajatID = A.AngajatID
INNER JOIN AngajatiDepartamenteHoteluri as ADH
ON ADH.AngajatID = A.AngajatID
INNER JOIN Hoteluri as H
ON H.HotelID =ADH.HotelID
WHERE C.Nume = 'Popescu' AND C.Prenume = 'Octavian'

--Cerinta 30
--Sa se afiseze numarul de clienti distincti ai fiecarui hotel.
SELECT DISTINCT H.Nume as Hotel, H.Oras, COUNT(RC.ClientID) as NrClienti
FROM Rezervari as R
INNER JOIN Angajati as A
ON A.AngajatID = R.AngajatID
INNER JOIN AngajatiDepartamenteHoteluri as ADH
ON ADH.AngajatID = A.AngajatID
INNER JOIN Hoteluri as H
ON H.HotelID = ADH.HotelID
INNER JOIN RezervariClienti as RC
ON RC.RezervareID = R.RezervareID
GROUP BY H.Nume, H.Oras

--Cerinta 31
--Sa se afiseze numarul angajatilor din fiecare localitate.
SELECT Oras, COUNT(AngajatID) as NrAngajati
FROM Angajati
GROUP BY Oras

--Cerinta 32
--Sa se afiseze numarul angajatilor care au salariu mai mare de 2999 de lei si mai mic de 4001 de lei(cu impozite incluse).
SELECT COUNT(A.AngajatID) as NrAngajati
FROM Angajati as A
INNER JOIN FunctiiAngajati as FA
ON FA.AngajatID = A.AngajatID
INNER JOIN SalariiFunctii as SF
ON SF.FunctieID = FA.FunctieID
INNER JOIN Salarii as S
ON S.SalariuID = SF.SalariuID
WHERE S.SalariuBrut > 2999 AND S.SalariuBrut < 40001

--Cerinta 33
--Sa se calculeze numarul angajatilor care s-au ocupat de o rezervare de tip Agrement.
SELECT COUNT(A.AngajatID) as NrAngajati
FROM Rezervari as R
INNER JOIN Facilitati as F
ON F.FacilitateID = R.FacilitateID
INNER JOIN Angajati as A
ON A.AngajatID = R.AngajatID
WHERE F.Nume = 'Agrement'

--Cerinta 34
--Calculati vechimea angajatilor la data de 01.05.2022(in ani).
SELECT Nume, YEAR('2022-05-01') - YEAR(DataAngajarii) as 'Vechime(ani)'
FROM Angajati

--Cerinta 35
--Afisati vechimea medie in hotel a angajatilor la data de 01.05.2022(in ani).
SELECT SUM(YEAR('2022-05-01') - YEAR(DataAngajarii))/ COUNT(Nume) as VechimeMedie
FROM Angajati

--Cerinta 36
--Cine este managerul hotelului?
SELECT A.Nume, A.Prenume, F.Nume as Functie
FROM Angajati as A
INNER JOIN FunctiiAngajati as FA
ON FA.AngajatID = A.AngajatID
INNER JOIN Functii as F
ON F.FunctieID = FA.FunctieID
WHERE F.Nume = 'Manager'

--Cerinta 37
--Afisati numarul clientilor grupati pe orase, in ordinea invers alfabetica numelui orasului.
SELECT Oras, COUNT(ClientID) as NrClienti
FROM Clienti
GROUP BY Oras
ORDER BY Oras DESC

--Cerinta 38
--Afisati clientii(ID, Nume, Prenume, IDMeniu) care au comandat "piure".
SELECT C.ClientID, C.Nume, C.Prenume, RR.MeniuID
FROM RezervariClienti as RC
INNER JOIN Clienti as C
ON C.ClientID = RC.ClientID
INNER JOIN RezervariRestaurant as RR
ON RR.RezervareID = RC.RezervareID
INNER JOIN Restaurant as R
ON R.MeniuID = RR.MeniuID
WHERE R.DetaliiMeniu LIKE 'Piure%'

--Cerinta 39
--Cat costa cel mai scump serviciu, dar cel mai ieftin?
SELECT MAX(Valoare) as Maxim, MIN(Valoare) as Minim
FROM Preturi

--Cerinta 40
--Afisati preturile mediu al serviciilor care incep cu litera "D" sau "S".
SELECT SUM(Valoare)/COUNT(NumeServiciu) as PretMediu
FROM Preturi
WHERE NumeServiciu LIKE '[DS]%'

--Cerinta 41
--Sa se afiseze toti angajatii(ID, nume, prenume) care au procesat rezervari cu ID par.
SELECT AngajatID, Nume, Prenume
FROM Angajati as A
WHERE EXISTS(
SELECT RezervareID
FROM Rezervari as R
WHERE RezervareID % 2 = 0 AND A.AngajatID = R.AngajatID
)

--Cerinta 42
--Sa se afiseze toti clientii(ID, nume, prenume) care au efectuat rezervari mai devreme de 01.01.2021.
SELECT ClientID, Nume, Prenume
FROM Clienti as C
WHERE EXISTS(
SELECT RezervareClientID
FROM RezervariClienti as RC
WHERE C.ClientID = RC.ClientID AND DataEfectuarii < '2021-01-01'
)

--Cerinta 43
--Sa se afiseze angajatii(ID, nume, prenume) care au salariu multiplu de 100 si lucreaza de mai mult de 3 ani.
SELECT AngajatID, Nume, Prenume
FROM Angajati as A
WHERE EXISTS(
SELECT S.SalariuBrut
FROM FunctiiAngajati as FA
INNER JOIN SalariiFunctii as SF
ON SF.FunctieID = FA.FunctieID
INNER JOIN Salarii as S
ON S.SalariuID = SF.SalariuID
WHERE A.AngajatID = FA.AngajatID AND S.SalariuBrut % 100 = 0 AND YEAR('2022-04-25') - YEAR(A.DataAngajarii) > 3
)

--Cerinta 44
--Sa se afiseze toate rezervarile(ID, IDAngajat) care au fost efectute pentru facilitatea 'Cazare', iar angajatul care s-a ocupat de ea are ID-ul par.
SELECT RezervareID, AngajatID
FROM Rezervari as R
WHERE EXISTS(
SELECT Nume
FROM Facilitati as F
WHERE F.FacilitateID = R.FacilitateID AND F.Nume = 'Cazare' AND R.AngajatID % 2 = 0
)

--Cerinta 45
--Sa se afiseze toate acele functii care sunt ocupate de angajati ai caror nume incepe cu 'M' sau 'C' si ai caror ID este numar impar.
SELECT Nume
FROM Functii as F
WHERE EXISTS(
SELECT FunctieAngajatID
FROM FunctiiAngajati as FA
INNER JOIN Angajati as A
ON A.AngajatID = FA.AngajatID
WHERE F.FunctieID = FA.FunctieID AND A.Nume LIKE '[MC]%' AND A.AngajatID % 2 = 1
)

--Cerinta 46
--Sa se afiseze toti angajatii care au ID-ul mai mare decat 'Ionel Mihai'.
SELECT AngajatID, Nume, Prenume
FROM Angajati as A
WHERE AngajatID > ALL
(
SELECT AngajatID
FROM Angajati 
WHERE Nume LIKE 'Ionel' AND Prenume LIKE 'Mihai'
)

--Cerinta 47
--Sa se afiseze toti clientii care au ID-ul mai mare decat 'Gheorghe Vlad' si locuiesc in Bucuresti.
SELECT ClientID, Nume, Prenume
FROM Clienti
WHERE Oras = 'Bucuresti' AND ClientID > ALL
(
SELECT ClientID
FROM Clienti
WHERE Nume LIKE 'Gheorghe' AND Prenume LIKE 'Vlad'
)

--Cerinta 48
--Sa se afiseze toti angajatii care au salariu mai mare de 3000 de lei si id-ul mai mic decat 'Ionel Mihai' si locuiesc in Brasov.
SELECT A.AngajatID, A.Nume, A.Prenume
FROM Angajati as A
INNER JOIN FunctiiAngajati as FA
ON FA.AngajatID = A.AngajatID
INNER JOIN SalariiFunctii as SF
ON SF.FunctieID = FA.FunctieID
INNER JOIN Salarii as S
ON S.SalariuID = SF.SalariuID
WHERE S.SalariuBrut > 3000 AND A.Oras = 'Brasov' AND A.AngajatID < ALL
(
SELECT AngajatID
FROM Angajati 
WHERE Nume LIKE 'Ionel' AND Prenume LIKE 'Mihai'
)

--Cerinta 49
--Afisati toti angajatii care lucreaza in departamentul 'Receptie', locuiesc in Bucuresti si au id-ul mai mare decat 'Ionel Mihai'.
SELECT A.AngajatID, A.Nume, A.Prenume
FROM Angajati as A
INNER JOIN AngajatiDepartamenteHoteluri as ADH 
ON ADH.AngajatID = A.AngajatID
INNER JOIN Departamente as D
ON D.DepartamentID = ADH.DepartamentID
WHERE D.Nume = 'Receptie' AND A.Oras = 'Bucuresti' AND A.AngajatID > ALL
(
SELECT AngajatID
FROM Angajati 
WHERE Nume LIKE 'Ionel' AND Prenume LIKE 'Mihai'
)

--Cerinta 50
--Sa se afiseze acele functii care sunt ocupate de de angajati cu id-ul mai mare decat al lui 'Ionel Mihai'.
SELECT DISTINCT F.FunctieID, F.Nume
FROM FunctiiAngajati as FA
INNER JOIN Functii as F
ON F.FunctieID = FA.FunctieID
WHERE FA.AngajatID > ALL
(
SELECT AngajatID
FROM Angajati 
WHERE Nume LIKE 'Ionel' AND Prenume LIKE 'Mihai'
)

--Cerinta 51
--Afisati toti clientii care au efectuat rezervari cu ID mai mare de 10005.
SELECT C.ClientID, C.Nume, C.Prenume
FROM Clienti as C
INNER JOIN RezervariClienti as RC
ON RC.ClientID = C.ClientID
WHERE RC.RezervareID = ANY
(
SELECT R.RezervareID
FROM Rezervari as R
WHERE R.RezervareID > 10005
)

--Cerinta 52
--Afisati toti angajatii care muncesc la hotelul din Cluj-Napoca.
SELECT AngajatID, Nume, Prenume
FROM Angajati as A
WHERE AngajatID = ANY
(
SELECT ADH.AngajatID
FROM AngajatiDepartamenteHoteluri as ADH
INNER JOIN Hoteluri as H
ON H.HotelID = ADH.HotelID
WHERE H.Oras = 'Cluj-Napoca'
)

--Cerinta 53
--Sa se afiseze toti angajatii care lucreaza la departamentul 'Receptie' si au salariul mai mare de 4000 de lei.
SELECT A.AngajatID, A.Nume, A.Prenume
FROM Angajati as A
INNER JOIN FunctiiAngajati as FA
ON FA.AngajatID = A.AngajatID
INNER JOIN SalariiFunctii as SF
ON SF.FunctieID = FA.FunctieID
INNER JOIN Salarii as S
ON S.SalariuID = SF.SalariuID
WHERE S.SalariuBrut > 4000 AND A.AngajatID = ANY
(
SELECT ADH.AngajatID
FROM AngajatiDepartamenteHoteluri as ADH
INNER JOIN Departamente as D
ON D.DepartamentID = ADH.DepartamentID
WHERE D.Nume = 'Receptie'
)

--Cerinta 54
--Afisati toate rezervarile care au id mai mare de 105 si au fost efectuate mai tarziu de 01.01.2021.
SELECT *
FROM Rezervari
WHERE RezervareID > 105 AND RezervareID = ANY
(
SELECT RezervareID
FROM RezervariClienti
WHERE DataEfectuarii > '2021-01-01'
)

--Cerinta 55
--Sa se afiseze toti angajatii care lucreaza intr-un oras al carui nume incepe cu litera 'B' si au id-ul un numar impar.
SELECT AngajatID, Nume
FROM Angajati
WHERE AngajatID % 2 = 1 AND AngajatID = ANY
(
SELECT ADH.AngajatID
FROM AngajatiDepartamenteHoteluri AS ADH
INNER JOIN Hoteluri AS H
ON H.HotelID = ADH.HotelID
WHERE H.Oras LIKE 'B%'
)

--Cerinta 56
--Sa se afiseze locurile/orasele din care provin clienți și angajați.
SELECT Oras
FROM Angajati
UNION
SELECT Oras
FROM Clienti

--Cerinta 57
--Sa se afiseze locurile/orasele din care provin clienți și angajați, inclusiv duplicatele.
SELECT Oras
FROM Angajati
UNION ALL
SELECT Oras
FROM Clienti

--Cerinta 58
--Sa se afiseze locurile/orasele in care exista atat clienți, cat și angajați.
SELECT Oras
FROM Clienti
INTERSECT
SELECT Oras
FROM Angajati

--Cerinta 59
--Sa se afiseze locurile/orasele in care exista clienți, dar nu si angajați.
SELECT Oras
FROM Clienti
EXCEPT
SELECT Oras
FROM Angajati

--Cerinta 60
--Sa se afiseze locurile/orasele in care exista atat clienți, cat și hoteluri.
SELECT Oras
FROM Clienti
INTERSECT
SELECT Oras
FROM Hoteluri

--Cerinta 61
--Sa se afiseze locurile/orasele in care exista clienți, dar nu si hoteluri.
SELECT Oras
FROM Clienti
EXCEPT
SELECT Oras
FROM Hoteluri

--Cerinta 62
--Sa se afiseze locurile/orasele in care exista atat angajati, cat și hoteluri.
SELECT Oras
FROM Angajati
INTERSECT
SELECT Oras
FROM Hoteluri

--Cerinta 63
--Sa se afiseze locurile/orasele in care exista angajati, dar nu si hoteluri.
SELECT Oras
FROM Angajati
EXCEPT
SELECT Oras
FROM Hoteluri

--Cerinta 64
--Ne intereaza angajatii si anii in care acestia au procesat mai putin de 2 rezervari.
SELECT R.AngajatID, YEAR(RC.DataEfectuarii) as Anul, COUNT(*) as NrRezervari
FROM Rezervari as R
INNER JOIN RezervariClienti as RC
ON RC.RezervareID = R.RezervareID
GROUP BY R.AngajatID, YEAR(RC.DataEfectuarii)
HAVING COUNT(*) < 2

--Cerinta 65
--Ne intereaza orasele din care avem mai mult de 3 clienti, care au efectuat o rezrvare.
SELECT C.Oras, COUNT(*) as NrClienti
FROM RezervariClienti as RC
INNER JOIN Clienti as C
ON C.ClientID = RC.ClientID
GROUP BY C.Oras
HAVING COUNT(*) >= 2

--Cerinta 66
--Ne intereseaza anul in care au fost angajate mai mult de 4 persoane in companie.
SELECT YEAR(DataAngajarii) as AnulAngajarii, COUNT(*) as NrAngajati
FROM Angajati
GROUP BY YEAR(DataAngajarii)
HAVING COUNT(*) > 4

--Cerinta 67
--Ne intereseaza hotelul si anul in care s-au efectuat mai mult de 2 angajari.
SELECT H.Nume as Hotel, YEAR(DataAngajarii) as AnulAngajarii, COUNT(*) as NrAngajati
FROM Angajati as A
INNER JOIN AngajatiDepartamenteHoteluri as ADH
ON ADH.AngajatID = A.AngajatID
INNER JOIN Hoteluri as H
ON ADH.HotelID = H.HotelID
GROUP BY H.Nume, YEAR(DataAngajarii)
HAVING COUNT(*) > 2

--Cerinta 68
--Ne intereseaza clientii care au revenit la unul dintre hotelurile noastre.
SELECT C.ClientID, COUNT(*) as NrRezervari
FROM RezervariClienti as RC
INNER JOIN Clienti as C
ON RC.ClientID = C.ClientID
GROUP BY C.ClientID
HAVING COUNT(*) > 1

--Cerinta 69
--Ne intereseaza rezervarile cu o anumita facilitate care au fost alese de clienti de mai mult de 2 ori.
SELECT F.Nume as Facilitate, COUNT(*) as NrRezervari
FROM Rezervari as R
INNER JOIN Facilitati as F
ON F.FacilitateID = R.FacilitateID
GROUP BY F.Nume
HAVING COUNT(*) > 2

--UPDATE
--Cerinta 1
--Dupa mai multe discutii, managerul decide sa acorde un discount de 5% tuturor rezervarilor de tip Cazare.
UPDATE RezervariClienti
SET Discount += 0.05
FROM RezervariClienti AS RC
INNER JOIN Rezervari AS R
ON R.RezervareID = RC.RezervareID
INNER JOIN Facilitati AS F
ON F.FacilitateID = R.FacilitateID
WHERE F.Nume = 'Cazare'

--Cerinta 2
--Dupa mai multe discutii, managerul decide sa acorde un discount de 3% tuturor rezervarilor de tip Agrement.
UPDATE RezervariClienti
SET Discount += 0.03
FROM RezervariClienti AS RC
INNER JOIN Rezervari AS R
ON R.RezervareID = RC.RezervareID
INNER JOIN Facilitati AS F
ON F.FacilitateID = R.FacilitateID
WHERE F.Nume = 'Agrement'

--Cerinta 3
--Dupa mai multe discutii, managerul decide sa acorde un discount de 6% tuturor rezervarilor de tip Restaurant.
UPDATE RezervariClienti
SET Discount += 0.06
FROM RezervariClienti AS RC
INNER JOIN Rezervari AS R
ON R.RezervareID = RC.RezervareID
INNER JOIN Facilitati AS F
ON F.FacilitateID = R.FacilitateID
WHERE F.Nume = 'Restaurant'

select * from RezervariClienti

--Cerinta 4
--Dupa mai multe discutii, managerul decide sa acorde un discount de 10% tuturor rezervarilor de tip All Incluvise.
UPDATE RezervariClienti
SET Discount += 0.1
FROM RezervariClienti AS RC
INNER JOIN Rezervari AS R
ON R.RezervareID = RC.RezervareID
INNER JOIN Facilitati AS F
ON F.FacilitateID = R.FacilitateID
WHERE F.Nume = 'All Incluvise'

--Cerinta 5
--Managerul hotelului a observat o greseala in ceea ce priveste baza de date, meniuri care contin lactate nu sunt semnalate continand alergeni. Sa se modifice
--tabelul restaurant astfel incat meniurile care contin "branza", "lapte" sau produse care contin unul dintre acestea, sa apara semnalat in lista de alergeni.
UPDATE Restaurant
SET IngredienteAlergeni = 'produse din lapte'
FROM Restaurant
WHERE DetaliiMeniu LIKE 'Piure%' or DetaliiMeniu LIKE '%branza%' or DetaliiMeniu LIKE 'Paste%'

select * from Restaurant

--Cerinta 6
--Angajatul cu id-ul 1012 a fost avansat si mutat la hotelul din Brasov. Realizat modificarile necesare asupra bazei de date.
UPDATE AngajatiDepartamenteHoteluri 
SET DataIesire = '2022-05-11'
WHERE AngajatID = 1012
GO
UPDATE FunctiiAngajati
SET DataIesire = '2022-05-11'
WHERE AngajatID = 1012
GO 
INSERT INTO AngajatiDepartamenteHoteluri(DepartamentID, HotelID, AngajatID, DataIntrare) values (4000, 3001, 1012,  '2022-05-11')
GO
INSERT INTO FunctiiAngajati(FunctieID, AngajatID, DataNumire, Subordonat) values (5000, 1012, '2022-05-11', 6000)
go

--Cerinta 7
--Dat fiind faptul ca lucreaza departe de casa, mai multi angajati au decis sa locuiasca impreuna. Astfel ca angajatii al caror prenume incepe cu litera "G"
--si lucreaza in acelasi oras, vor locui la adresa "Strada Primaverii, nr.2, bloc 10, etaj 5, ap. 56", Bucuresti.
WITH Ang as(
SELECT AngajatID
FROM Angajati
WHERE Oras = 'Bucuresti' AND Prenume LIKE 'G%'
)
UPDATE Angajati
SET Adresa = 'Strada Primaverii, nr.2, bloc 10, etaj 5, ap. 56'
FROM Ang as An
INNER JOIN Angajati as A
ON A.AngajatID = An.AngajatID

select * from Angajati where Oras = 'Bucuresti'

--Cerinta 8
--In urma unei vizite in hoteluri, managerul multumit de angajatii sai decide sa creasca salariul tuturor sefilor de tura cu 5%. 
--Realizati aceasta modificarein baza de date.
UPDATE Salarii
SET SalariuBrut = SalariuBrut + SalariuBrut*0.05
FROM Salarii as S
INNER JOIN SalariiFunctii as SF
ON Sf.SalariuID = S.SalariuID
INNER JOIN Functii as F
ON F.FunctieID = SF.FunctieID
WHERE F.Nume = 'Sef tura'

select * from Salarii

--Cerinta 9
--In cadrul tabelului Hoteluri este dificil de lucrat deoarece toate hotelurile au acelasi nume. 
--Modificati tabelul astefel incat noul nume sa fie compus din vechiul nume plus oras in care se afla hotelul.
UPDATE Hoteluri
SET Nume = Nume + ' ' + Oras

select * from Hoteluri

--Cerinta 10
--Pentru clientii care au efectuat o rezervare de tip Cazare la hotelul din Cluj-Napoca se acorda un discount de 5%. Realizati modificarile necesare.
UPDATE RezervariClienti
SET Discount = Discount + Discount*0.05
FROM RezervariClienti as RC
INNER JOIN Rezervari as R
ON R.RezervareID = RC.RezervareID
INNER JOIN AngajatiDepartamenteHoteluri as ADH
ON ADH.AngajatID = R.AngajatID
INNER JOIN Hoteluri as H
ON H.HotelID = ADH.HotelID
WHERE H.Oras = 'Cluj-Napoca'

select * from RezervariClienti

--Cerinta 11
--Angajatul cu numele 'Mihaiu' si-a schimbat numarul de telefon in '+40732429872'.
UPDATE Angajati
SET Telefon = '+40732429872'
WHERE Nume = 'Mihaiu'

--Cerinta 12
--Multumit de serviciile oferite de hotel, clientul cu id-ul 2000 doreste sa isi prelungeasca sederea cu inca 2 nopti, pentru rezervarea 10000. 
--Realizati modificare necesara in baza de date.
UPDATE RezervariCazare
SET DataParasire = DATEADD(DAY, 2, DataParasire)
FROM RezervariCazare as RC
INNER JOIN RezervariClienti as R
ON RC.RezervareID = R.RezervareID
WHERE R.ClientID = 2000 AND R.RezervareID = 10000

select * from RezervariCazare where RezervareID = 10000

--Cerinta 13
--Dupa mai multe discutii cu angajatii, managerul decide sa realizeze o marire salariala pentru angajatii din departamentul de Securitate.
--Cresterea va fi cu 15%.
--Realizati aceasta modificare in baza de date.
DROP TRIGGER TSalariu

UPDATE Salarii
SET SalariuBrut += SalariuBrut*0.15
FROM Salarii as S
INNER JOIN SalariiFunctii as SF
ON SF.SalariuID = S.SalariuID
INNER JOIN FunctiiAngajati as FA
ON FA.FunctieID = SF.FunctieID
INNER JOIN AngajatiDepartamenteHoteluri as ADH
ON ADH.AngajatID = FA.AngajatID
INNER JOIN Departamente as D
ON D.DepartamentID = ADH.DepartamentID
WHERE D.Nume = 'Securitate'

Select * from Salarii

--Cerinta 14
--Se remarca o greseala in baza de date. Angajatii cu id-uri pare si functie de 'Angajat obisnuit' au fost angajati in data de 01.01.2020.
--Remediati problema.
UPDATE Angajati
SET DataAngajarii = '2020-01-01'
FROM Angajati as A
INNER JOIN FunctiiAngajati as FA
ON FA.AngajatID = A.AngajatID
INNER JOIN Functii as F
ON F.FunctieID = FA.FunctieID
WHERE F.Nume = 'Angajat obisnuit'

select * from Angajati

--Cerinta 15
-- Sa se modifice toate rezervarile facute dupa 01.01.2021, adaugand ca angajat care a procesat rezervarea pe angajatul cu id-ul 1014.
UPDATE Rezervari
SET AngajatID = 1014
FROM Rezervari as R
INNER JOIN RezervariClienti as RC
ON R.RezervareID = RC.RezervareID
INNER JOIN Angajati as A
ON A.AngajatID = R.AngajatID
WHERE RC.DataEfectuarii > '2021-01-01'

select * from Rezervari
go
--CTE
--Cerinta 1
--Afisati pretul maxim al unui serviciu si numele acestuia.
WITH C AS(
SELECT MAX(Valoare) as Maxim
FROM Preturi
)
SELECT P.NumeServiciu, C.Maxim as PretMaxim
FROM Preturi as P
INNER JOIN C
ON P.Valoare = C.Maxim
go 

--Cerinta 2
--Calculati salariul angajatilor din departamentul "Receptie", dupa scaderea impozitelor.
WITH Sal as(
SELECT A.AngajatID, SUM(I.Procent) as Procent
FROM Angajati as A
INNER JOIN ImpoziteAngajati as IA
On IA.AngajatID = A.AngajatID
INNER JOIN Impozite as I
On I.ImpozitID = IA.ImpozitID
GROUP BY A.AngajatID
)
SELECT A.Nume, A.Prenume, F.Nume as Functia, D.Nume as Departament, S.SalariuBrut -S.SalariuBrut*SS.Procent as SalariuNet, SS.Procent
FROM Angajati as A
INNER JOIN Sal as SS
ON SS.AngajatID = A.AngajatID
INNER JOIN AngajatiDepartamenteHoteluri as ADH
ON ADH.AngajatID = A.AngajatID
INNER JOIN FunctiiAngajati as FA
ON FA.AngajatID = A.AngajatID
INNER JOIN Functii as F
On F.FunctieID = FA.FunctieID
INNER JOIN SalariiFunctii as SF
On SF.FunctieID = F.FunctieID
INNER JOIN Salarii as S
On S.SalariuID = SF.SalariuID
INNER JOIN Departamente as D
On D.DepartamentID = ADH.DepartamentID
WHERE D.Nume = 'Receptie'
go

--Cerinta 3
--Afisati angajatul cu cele mai multe rezervari efectuate pentru fiecare hotel, precum si numarul rezervarilor.
WITH MaxA AS(
SELECT R.AngajatID, COUNT(RezervareID) as NrRezervari
FROM Angajati as A
INNER JOIN Rezervari as R
ON R.AngajatID = A.AngajatID
GROUP BY R.AngajatID
)
SELECT H.Nume as NumeHotel, H.Oras as OrasHotel, MAX(M.AngajatID) as AngajatID, MAX(M.NrRezervari) as NrRezervari
FROM Angajati as A
INNER JOIN Rezervari as R
ON R.AngajatID = A.AngajatID
INNER JOIN AngajatiDepartamenteHoteluri as ADH
ON ADH.AngajatID = A.AngajatID
INNER JOIN Hoteluri as H
ON ADH.HotelID = H.HotelID
INNER JOIN MaxA as M
ON M.AngajatID = A.AngajatID
GROUP BY H.Nume, H.Oras
go

--Cerinta 4
--Sa se afiseze cel mai vechi angajat din fiecare departament(indiferent de hotelul in care lucreaza).
WITH M AS(
SELECT MIN(A.DataAngajarii) as Dat, D.Nume as Departament
FROM Angajati as A
INNER JOIN AngajatiDepartamenteHoteluri as ADH
ON ADH.AngajatID = A.AngajatID
INNER JOIN Departamente as D
ON D.DepartamentID = ADH.DepartamentID
GROUP BY D.Nume
)
SELECT A.Nume, A.Prenume, M.Dat, M.Departament
FROM Angajati as A
INNER JOIN M
ON A.DataAngajarii = M.Dat
ORDER BY M.Departament
go

--Cerinta 5
--Sa se afiseze rata de ocupare a hotelului din Cluj-Napoca, daca acesta dispune de 5 spatii de cazare.
WITH NrRezCluj as (
SELECT COUNT(RC.RezervareID) as NrRezervari
FROM Rezervari as R 
INNER JOIN RezervariCazare as RC
ON RC.RezervareID = R.RezervareID
INNER JOIN Angajati as A
ON R.AngajatID = A.AngajatID
INNER JOIN AngajatiDepartamenteHoteluri as ADH
ON ADH.AngajatID = A.AngajatID
INNER JOIN Hoteluri as H
ON H.HotelID = ADH.HotelID
WHERE H.Oras = 'Cluj-Napoca'
)
SELECT N.NrRezervari*100/5 as ProcentOcupare
FROM NrRezCluj as N

--TRANZACTII
--1. Sa se insereze un nou client in baza de date si sa se faca un update asupra numarului de telefon al acestuia, in interiorul unui tranzactii.
SELECT @@TRANCOUNT; 
BEGIN TRAN;
SELECT @@TRANCOUNT; 
INSERT INTO Clienti(ClientID, Nume, Prenume, Oras)
VALUES(2013, 'Popescu', 'Mihai', 'Bucuresti');
SELECT * FROM Clienti WHERE ClientId = 2015;
BEGIN TRAN;
SELECT @@TRANCOUNT; 
UPDATE Clienti
SET Telefon = '+40766554433'
WHERE ClientId = 2015
SELECT * FROM Clienti WHERE ClientId = 2015;
COMMIT
SELECT @@TRANCOUNT; 
COMMIT TRAN;
SELECT @@TRANCOUNT; 

select * from Clienti where ClientID = 2015

--2. Sa se insereze un nou client cu id-ul 2015, sa se capteze erorile aparute la rularea de 2 ori a aceleasi tranzactii printr-o metoda nestructurata.
select * from Clienti

DECLARE @errnum AS INT;
BEGIN TRAN;
INSERT INTO Clienti(ClientID, Nume, Prenume, Oras)
VALUES(2005, 'Popescu', 'Mihai', 'Bucuresti');
SET @errnum = @@ERROR;
IF @errnum <> 0 -- gestioneaaa eroarea
BEGIN
PRINT 'Insert into Clienti failed with error '+CAST(@errnum AS VARCHAR);
ROLLBACK
END
ELSE
BEGIN
COMMIT
END
SELECT @@TRANCOUNT

select * from Clienti

--3. Sa se rezolve exercitiul anterior cu tratarea exceptiilor printr-o metoda structurata.
BEGIN TRY
BEGIN TRAN;
INSERT INTO Clienti(ClientID, Nume, Prenume, Oras)
VALUES(2005, 'Popescu', 'Mihai', 'Bucuresti');
COMMIT TRAN;
END TRY
BEGIN CATCH
IF ERROR_NUMBER() = 2627 -- Duplicate key violation
BEGIN
PRINT 'Primary Key violation';
END
ELSE IF ERROR_NUMBER() = 547 -- Constraint violations
BEGIN
PRINT 'Constraint violation';
END
ELSE
BEGIN
PRINT 'Unhandled error';
END;
IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
END CATCH;

--4. Sa se reinsereze in tabelul Angajati, un angajat care care deja exista, captati eroare printr-o metoda nestructurata.
select * from Angajati

DECLARE @errnum1 AS INT;
BEGIN TRAN;
SET IDENTITY_INSERT Angajati ON
INSERT INTO Angajati(AngajatID, Nume, Prenume, DataAngajarii, Oras)
VALUES(1000, 'Ionescu', 'Ioana', '2020-01-01', 'Cluj-Napoca');
SET IDENTITY_INSERT Angajati OFF
SET @errnum1 = @@ERROR;
IF @errnum1 <> 0 -- gestioneaaa eroarea
BEGIN
PRINT 'Insert into Angajati failed with error '+CAST(@errnum1 AS VARCHAR);
ROLLBACK
END
ELSE
BEGIN
COMMIT
END
SELECT @@TRANCOUNT

select * from Angajati

--5. Sa se rezolve exercitiul anterior folosind o metoda structurata de tratare a erorilor.
BEGIN TRY
BEGIN TRAN;
SET IDENTITY_INSERT Angajati ON;
INSERT INTO Angajati(AngajatID, Nume, Prenume, DataAngajarii, Oras)
VALUES(1000, 'Ionescu', 'Ioana', '2020-01-01', 'Cluj-Napoca');
SET IDENTITY_INSERT Angajati OFF;
COMMIT TRAN;
END TRY
BEGIN CATCH
IF ERROR_NUMBER() = 2627 -- Duplicate key violation
BEGIN
PRINT 'Primary Key violation';
END
ELSE IF ERROR_NUMBER() = 547 -- Constraint violations
BEGIN
PRINT 'Constraint violation';
END
ELSE
BEGIN
PRINT 'Unhandled error';
END;
IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
END CATCH;

--6. Dupa mai multe discutii, in meniul restaurantului se introduc mai multe feluri de mancare. Realizati aceste modificari si captati posibilele erori aparute.
select * from Restaurant

BEGIN TRY
BEGIN TRAN;
SET IDENTITY_INSERT Restaurant ON;
INSERT INTO Restaurant(MeniuID, DetaliiMeniu)
VALUES(310, 'Supa crema de morcovi');
INSERT INTO Restaurant(MeniuID, DetaliiMeniu)
VALUES(300, 'Supa crema de morcovi');
SET IDENTITY_INSERT Restaurant OFF;
COMMIT TRAN;
END TRY
BEGIN CATCH
IF ERROR_NUMBER() = 2627 -- Duplicate key violation
BEGIN
PRINT 'Primary Key violation';
END
ELSE IF ERROR_NUMBER() = 547 -- Constraint violations
BEGIN
PRINT 'Constraint violation';
END
ELSE
BEGIN
PRINT 'Unhandled error';
END;
IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
END CATCH;

select * from Restaurant

--7. Sa se efectueze inserarea a doi angajati noi, unul avand id-ul 1000, iar celalalt 1030. 
--Observati ce se intampla in urma rularii si captati posibilele erori printr-o metoda nestructurata.
DECLARE @errnum2 AS int;
BEGIN TRAN;
SET IDENTITY_INSERT Angajati ON;
-- Insert #1 va esua din cauza cheii primare duplicate
INSERT INTO Angajati(AngajatID, Nume, Prenume, DataAngajarii, Oras)
VALUES(1000, 'Vasile', 'Ioana', '2020-01-01', 'Cluj-Napoca');
SET @errnum2 = @@ERROR;
IF @errnum2 <> 0
BEGIN
IF @@TRANCOUNT > 0 ROLLBACK TRAN;
PRINT 'Insert #1 into Products failed: error '+ CAST(@errnum2 AS VARCHAR);
END;
-- Insert #2 se va executa cu succes
INSERT INTO Angajati(AngajatID, Nume, Prenume, DataAngajarii, Oras)
VALUES(1030, 'Marinescu', 'Maria', '2020-01-01', 'Cluj-Napoca');
SET @errnum2 = @@ERROR;
IF @errnum2 <> 0
BEGIN
IF @@TRANCOUNT > 0 ROLLBACK TRAN;
PRINT 'Insert #2 into Products failed: error '+ CAST(@errnum2 AS VARCHAR);
END;
SET IDENTITY_INSERT Angajati OFF;
IF @@TRANCOUNT > 0 COMMIT TRAN;

select * from Angajati

--8. Se incearca adaugarea unei noi activitati de agrement, „volei”. 
--Scrieti tranzactia aferenta acestei modificari si captati eventualele erori aparute
select * from Agrement
BEGIN TRY
BEGIN TRAN;
SET IDENTITY_INSERT Agrement ON;
INSERT INTO Agrement(AgrementID, NumeActivitate)
VALUES(407, 'Volei');
SET IDENTITY_INSERT Agrement OFF;
COMMIT TRAN;
END TRY
BEGIN CATCH
IF ERROR_NUMBER() = 2627 -- Duplicate key violation
BEGIN
PRINT 'Primary Key violation';
END
ELSE IF ERROR_NUMBER() = 547 -- Constraint violations
BEGIN
PRINT 'Constraint violation';
END
ELSE
BEGIN
PRINT 'Unhandled error';
END;
IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
END CATCH;

select * from Agrement

--9. Prin intermediul unei tranzactii sa se modifice pretul tuturor sericiilor care incep cu litera „D” sau „S”. Pretul va creste cu 5%, 
--iar in dreptul numelui serviciului se va afisa "*".
BEGIN TRAN;
SELECT * FROM Preturi;
UPDATE Preturi
SET Valoare = Valoare + Valoare*0.05
WHERE NumeServiciu LIKE '[DS]%'
SELECT * FROM Preturi;
BEGIN TRAN;
UPDATE Preturi
SET NumeServiciu = NumeServiciu + ' *'
WHERE NumeServiciu LIKE '[DS]%'
SELECT * FROM Preturi;
COMMIT
COMMIT TRAN;

--10. Sa se modifice valoare tuturor rezervarilor, efectuate in prima jumatate a anului, discountul va creste cu 10%, altfel va scadea cu 1%.
--Scrieti tranzactia necesara acestei operatiuni.
BEGIN TRAN
SELECT * FROM RezervariClienti;
UPDATE RezervariClienti
SET Discount = Discount + 0.1
WHERE MONTH(DataEfectuarii) > 6 
SELECT * FROM RezervariClienti;
BEGIN TRAN;
UPDATE RezervariClienti
SET Discount = Discount - 0.01
WHERE MONTH(DataEfectuarii) < 6 
SELECT * FROM RezervariClienti;
COMMIT
COMMIT TRAN;

--DELETE
--1. Stergeti toti clientii ai caror nume incepe cu litera „V”.
begin tran
select * from Clienti

alter table RezervariClienti
drop constraint FK__Rezervari__Clien__4316F928
alter table RezervariClienti with check
add constraint FK__Rezervari__Clien__4316F928 foreign key (ClientID) references Clienti(ClientID)
on delete cascade


alter table Chitante
drop constraint FK__Chitante__Rezerv__5441852A
alter table Chitante with check
add constraint FK__Chitante__Rezerv__5441852A foreign key (RezervareClientID) references RezervariClienti(RezervareClientID)
on delete cascade

delete 
from Clienti
where Nume like 'V%'

select * from Clienti
rollback

--2. Stergeti clientii al caror prenume incepe cu litera „L” si locuiesc intr-un oras al carui nume incepe cu litera „F”.
begin tran
select * from Clienti

alter table RezervariClienti
drop constraint FK__Rezervari__Clien__4316F928
alter table RezervariClienti with check
add constraint FK__Rezervari__Clien__4316F928 foreign key (ClientID) references Clienti(ClientID)
on delete cascade


alter table Chitante
drop constraint FK__Chitante__Rezerv__5441852A
alter table Chitante with check
add constraint FK__Chitante__Rezerv__5441852A foreign key (RezervareClientID) references RezervariClienti(RezervareClientID)
on delete cascade

delete 
from Clienti
where Prenume like 'L%' and Oras like 'F%'

select * from Clienti
rollback

--3. Stergeti toate comenzile efectuate de un angajat cu id par, realizate in 2021.
begin tran
select * from RezervariClienti

alter table Chitante
drop constraint FK__Chitante__Rezerv__5441852A
alter table Chitante with check
add constraint FK__Chitante__Rezerv__5441852A foreign key (RezervareClientID) references RezervariClienti(RezervareClientID)
on delete cascade

delete RC
from RezervariClienti as RC
INNER JOIN Rezervari as R
ON RC.RezervareID = R.RezervareID
where year(RC.DataEfectuarii) = 2021 and R.AngajatID % 2 = 0

select * from RezervariClienti
rollback

--4. Stergeti toate rezervarile efectuate de clienti ai caror nume incepe cu litera „P” si care au facilitatea Cazare.
begin tran
select * from RezervariClienti

alter table Chitante
drop constraint FK__Chitante__Rezerv__5441852A
alter table Chitante with check
add constraint FK__Chitante__Rezerv__5441852A foreign key (RezervareClientID) references RezervariClienti(RezervareClientID)
on delete cascade

delete RC
from RezervariClienti as RC
INNER JOIN Rezervari as R
ON RC.RezervareID = R.RezervareID
INNER JOIN Facilitati as F
ON F.FacilitateID = R.FacilitateID
INNER JOIN Clienti as C
ON C.ClientID = RC.ClientID
where C.Prenume like 'M%' and F.Nume = 'Cazare'

select * from RezervariClienti
rollback

--5. Stergeti toate rezervarile de tip Restaurant care au un pret mai mic de 100 de lei.
begin tran
select * from RezervariRestaurant

delete RR
from RezervariRestaurant as RR
INNER JOIN ChitanteRezervariRestaurant as RCC
ON RCC.RezervareID = RR.RezervareID
where RCC.TotalPlata < 100

select * from RezervariRestaurant
rollback

--6. Stergeti toate rezervarile de tip Cazare efectuate intr-o zi para, de catre un angajat cu id par.
begin tran
select * from RezervariClienti

alter table Chitante
drop constraint FK__Chitante__Rezerv__5441852A
alter table Chitante with check
add constraint FK__Chitante__Rezerv__5441852A foreign key (RezervareClientID) references RezervariClienti(RezervareClientID)
on delete cascade

delete RC
from RezervariClienti as RC
INNER JOIN Rezervari as R
ON RC.RezervareID = R.RezervareID
INNER JOIN Facilitati as F
ON F.FacilitateID = R.FacilitateID
INNER JOIN Clienti as C
ON C.ClientID = RC.ClientID
where R.AngajatID % 2 = 0 and F.Nume = 'Cazare' and day(RC.DataEfectuarii) % 2 = 0

select * from RezervariClienti
rollback

--7. Stergeti toate rezervarile de tip Agrement efectuate pentru „inot” si procesate de angajatul cu id-ul 1003.
begin tran
select * from RezervariAgrement

delete RA
from RezervariAgrement as RA
INNER JOIN Agrement as A
ON A.AgrementID = RA.AgrementID
INNER JOIN Rezervari as R
ON R.RezervareID = RA.RezervareID
where R.AngajatID = 1003 and A.NumeActivitate = 'Inot'

select * from RezervariAgrement
rollback

--8. Stergeti toate rezervarile de tip Cazare care au fost efectuate in anul 2021 pentru camere de 2 persoane.
begin tran
select * from RezervariClienti

alter table Chitante
drop constraint FK__Chitante__Rezerv__5441852A
alter table Chitante with check
add constraint FK__Chitante__Rezerv__5441852A foreign key (RezervareClientID) references RezervariClienti(RezervareClientID)
on delete cascade

delete RC
from RezervariClienti as RC
INNER JOIN Rezervari as R
ON RC.RezervareID = R.RezervareID
INNER JOIN Facilitati as F
ON F.FacilitateID = R.FacilitateID
INNER JOIN Clienti as C
ON C.ClientID = RC.ClientID
INNER JOIN RezervariCazare as RCz
ON RCz.RezervareID = R.RezervareID
INNER JOIN Cazare as Cz
ON Cz.CazareID = RCz.CazareID
where R.AngajatID % 2 = 0 and F.Nume = 'Cazare' and Cz.NumarLocuri = 2

select * from RezervariClienti
rollback

--9. Stergeti toti clientii care au efectuat o rezervare care are id par, intr-o zi impara.
begin tran
select * from Clienti

alter table RezervariClienti
drop constraint FK__Rezervari__Clien__4316F928
alter table RezervariClienti with check
add constraint FK__Rezervari__Clien__4316F928 foreign key (ClientID) references Clienti(ClientID)
on delete cascade


alter table Chitante
drop constraint FK__Chitante__Rezerv__5441852A
alter table Chitante with check
add constraint FK__Chitante__Rezerv__5441852A foreign key (RezervareClientID) references RezervariClienti(RezervareClientID)
on delete cascade

delete C
from Clienti as C
INNER JOIN RezervariClienti as RC
ON RC.ClientID = C.ClientID
where day(RC.DataEfectuarii) % 2 = 1 and RC.RezervareClientID % 2 = 0

select * from Clienti
rollback

--10. Sa se stearga toti acei clienti care au efectuat o rezervare in anul 2020.
begin tran
select * from Clienti

alter table RezervariClienti
drop constraint FK__Rezervari__Clien__4316F928
alter table RezervariClienti with check
add constraint FK__Rezervari__Clien__4316F928 foreign key (ClientID) references Clienti(ClientID)
on delete cascade

alter table Chitante
drop constraint FK__Chitante__Rezerv__5441852A
alter table Chitante with check
add constraint FK__Chitante__Rezerv__5441852A foreign key (RezervareClientID) references RezervariClienti(RezervareClientID)
on delete cascade

delete C
from Clienti as C
INNER JOIN RezervariClienti as RC
ON RC.ClientID = C.ClientID
WHERE year(RC.DataEfectuarii) = 2020

select * from Clienti
rollback

--11. Sa se stearga chitantele mai vechi de 01.01.2021.
begin tran
select * from Chitante

delete
from Chitante
where DataEmitere < '2021-01-01'

select * from Chitante
rollback

--12. Stergeti toate rezervarile care au fost facute pentru facilitatea Cazare si pentru mai putin de 3 zile.
begin tran
select * from RezervariClienti

alter table Chitante
drop constraint FK__Chitante__Rezerv__5441852A
alter table Chitante with check
add constraint FK__Chitante__Rezerv__5441852A foreign key (RezervareClientID) references RezervariClienti(RezervareClientID)
on delete cascade

delete RC
from RezervariClienti as RC
INNER JOIN Rezervari as R
ON RC.RezervareID = R.RezervareID
INNER JOIN Facilitati as F
ON F.FacilitateID = R.FacilitateID
INNER JOIN Clienti as C
ON C.ClientID = RC.ClientID
INNER JOIN RezervariCazare as RCz
ON RCz.RezervareID = R.RezervareID
INNER JOIN Cazare as Cz
ON Cz.CazareID = RCz.CazareID
where F.Nume = 'Cazare' and day(Rcz.DataParasire) - day(Rcz.DataCazare) < 3

select * from RezervariClienti
rollback

--13. Sa se stearga toate rezervarile de tip agrement, realizate pentru o activitate care incepe cu „D”.
begin tran
select * from RezervariClienti

alter table Chitante
drop constraint FK__Chitante__Rezerv__5441852A
alter table Chitante with check
add constraint FK__Chitante__Rezerv__5441852A foreign key (RezervareClientID) references RezervariClienti(RezervareClientID)
on delete cascade

delete RC
from RezervariClienti as RC
INNER JOIN Rezervari as R
ON RC.RezervareID = R.RezervareID
INNER JOIN Facilitati as F
ON F.FacilitateID = R.FacilitateID
INNER JOIN Clienti as C
ON C.ClientID = RC.ClientID
INNER JOIN RezervariAgrement as RA
ON RA.RezervareID = R.RezervareID
INNER JOIN Agrement as A
ON A.AgrementID = RA.AgrementID
where F.Nume = 'Agrement' and A.NumeActivitate like 'D%'

select * from RezervariClienti
rollback

--14. Sa se stearga rezervarile efectuate de clienti in zile pare, care au discount mai mic de 0.5.
begin tran
select * from RezervariClienti

alter table Chitante
drop constraint FK__Chitante__Rezerv__5441852A
alter table Chitante with check
add constraint FK__Chitante__Rezerv__5441852A foreign key (RezervareClientID) references RezervariClienti(RezervareClientID)
on delete cascade

delete RC
from RezervariClienti as RC
where day(RC.DataEfectuarii) % 2 = 0 and RC.Discount < cast(0.05 as float)

select * from RezervariClienti
rollback

--15. Sa se stearga clientii care au efectuat rezervari de tip restaurant pentru meniul "MIc dejun englezesc".
begin tran
select * from Clienti

alter table RezervariClienti
drop constraint FK__Rezervari__Clien__4316F928
alter table RezervariClienti with check
add constraint FK__Rezervari__Clien__4316F928 foreign key (ClientID) references Clienti(ClientID)
on delete cascade


alter table Chitante
drop constraint FK__Chitante__Rezerv__5441852A
alter table Chitante with check
add constraint FK__Chitante__Rezerv__5441852A foreign key (RezervareClientID) references RezervariClienti(RezervareClientID)
on delete cascade

delete C
from Clienti as C
INNER JOIN RezervariClienti as RC
ON RC.ClientID = C.ClientID
INNER JOIN Rezervari as R
ON RC.RezervareID = R.RezervareID
INNER JOIN RezervariRestaurant as RR
ON RR.RezervareID = R.RezervareID
INNER JOIN Restaurant as Res
ON Res.MeniuID = RR.MeniuID
WHERE Res.DetaliiMeniu like 'Mic dejun englezesc'

select * from Clienti
rollback

--16. Sa se stearga chitantele emisein 2020, care au ca si client o persoana a carui nume incepe cu litera „M”.
begin tran
select * from Chitante

delete C
from Chitante as C
INNER JOIN DetaliiChitante as DC
ON DC.ChitantaID = C.ChitantaID
where year(C.DataEmitere) = 2020 and DC.NumeClient like 'M%'

select * from Chitante
rollback