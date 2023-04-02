-- MySQL Workbench Forward Engineering
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
SET @@global.sql_mode= '';
SET GLOBAL FOREIGN_KEY_CHECKS=0;
SET FOREIGN_KEY_CHECKS=0;
SET GLOBAL log_bin_trust_function_creators = 1;
-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema trainmodels
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema trainmodels
-- -----------------------------------------------------
DROP DATABASE TRAINMODELS;
CREATE SCHEMA IF NOT EXISTS `trainmodels` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `trainmodels`;

-- -----------------------------------------------------
-- Table `trainmodels`.`kunder`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `trainmodels`.`kunder` (
  `KID` VARCHAR(8) NOT NULL,
  `Kreditgrænse` DECIMAL(8,2) NULL DEFAULT NULL,
  `Efternavn` VARCHAR(25) NULL DEFAULT NULL,
  `Fornavn` VARCHAR(25) NULL DEFAULT NULL,
  `Adresse` VARCHAR(25) NULL DEFAULT NULL,
  `Postnummer` INT NULL DEFAULT NULL,
  `Bynavn` VARCHAR(25) NULL DEFAULT NULL,
  `Land` VARCHAR(25) NULL DEFAULT NULL,
  `Mobil` VARCHAR(25) NULL DEFAULT NULL,
  `Email` VARCHAR(25) NULL DEFAULT NULL,
  PRIMARY KEY (`KID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `trainmodels`.`leverandører`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `trainmodels`.`leverandører` (
  `LID` VARCHAR(8) NOT NULL,
  `Leverandørnavnbeskrivelse` VARCHAR(45) NULL DEFAULT NULL,
  `Efternavn` VARCHAR(25) NULL DEFAULT NULL,
  `Fornavn` VARCHAR(25) NULL DEFAULT NULL,
  `Adresse` VARCHAR(25) NULL DEFAULT NULL,
  `Postnummer` INT NULL DEFAULT NULL,
  `Bynavn` VARCHAR(25) NULL DEFAULT NULL,
  `Land` VARCHAR(25) NULL DEFAULT NULL,
  `Mobil` VARCHAR(25) NULL DEFAULT NULL,
  `Email` VARCHAR(25) NULL DEFAULT NULL,
  PRIMARY KEY (`LID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `trainmodels`.`købsordrer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `trainmodels`.`købsordrer` (
  `KOID` VARCHAR(8) NOT NULL,
  `LID` VARCHAR(8) NULL DEFAULT NULL,
  `Bestillingsdato` DATE NULL DEFAULT NULL,
  `Modtagelsesdato` DATE NULL DEFAULT NULL,
  `Betalingsdato` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`KOID`),
  INDEX `LID` (`LID` ASC) VISIBLE,
  CONSTRAINT `købsordrer_ibfk_1`
    FOREIGN KEY (`LID`)
    REFERENCES `trainmodels`.`leverandører` (`LID`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `trainmodels`.`produkttyper`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `trainmodels`.`produkttyper` (
  `Produkttype` varchar(45) NOT NULL,
  `Beskrivelse` text(1500),
  PRIMARY KEY (`Produkttype`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `trainmodels`.`produkter`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `trainmodels`.`produkter` (
  `PID` VARCHAR(8) NOT NULL,
  `Produkttype` varchar(45) NULL DEFAULT NULL,
  `Produktbeskrivelse` text(1500) NULL DEFAULT NULL,
  `HTMLBeskrivelse` text(1500) NULL DEFAULT NULL,
  `billede_id` VARCHAR(45) NULL DEFAULT NULL,
  `Billede` BLOB NULL DEFAULT NULL,
  `Leverandørnavnbeskrivelse` VARCHAR(45) NULL DEFAULT NULL,
  `Købspris` DECIMAL(8,2) NULL DEFAULT NULL,
  `Salgspris` DECIMAL(8,2) NULL DEFAULT NULL,
  `Lagerantal` INT(4) NULL DEFAULT NULL,
  `Transportdage_L_V` INT(4) NULL DEFAULT NULL,
  `Transportdage_V_K` INT(4) NULL DEFAULT NULL,
  PRIMARY KEY (`PID`),
  INDEX `Produkttype` (`Produkttype` ASC) VISIBLE,
  INDEX `Leverandørnavnbeskrivelse_idx` (`Leverandørnavnbeskrivelse` ASC) VISIBLE,
  CONSTRAINT `Produkttype`
    FOREIGN KEY (`Produkttype`)
    REFERENCES `trainmodels`.`produkttyper` (`Produkttype`)
    ON UPDATE CASCADE,
  CONSTRAINT `Leverandørnavnbeskrivelse`
    FOREIGN KEY (`Leverandørnavnbeskrivelse`)
    REFERENCES `trainmodels`.`leverandører` (`LID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `trainmodels`.`købsordrelinie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `trainmodels`.`købsordrelinie` (
  `KOID` VARCHAR(8) NOT NULL,
  `PID` VARCHAR(8) NOT NULL,
  `KøbsordrelinieBeskrivelse` VARCHAR(45) NULL DEFAULT NULL,
  `Kvantitet` INT(4) NOT NULL,
  `Købsstykkepris` DECIMAL(8,2) NOT NULL,
  PRIMARY KEY (`KOID`, `PID`),
  INDEX `PID` (`PID` ASC) VISIBLE,
  CONSTRAINT `købsordrelinie_ibfk_1`
    FOREIGN KEY (`KOID`)
    REFERENCES `trainmodels`.`købsordrer` (`KOID`)
    ON UPDATE CASCADE,
  CONSTRAINT `købsordrelinie_ibfk_2`
    FOREIGN KEY (`PID`)
    REFERENCES `trainmodels`.`produkter` (`PID`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `trainmodels`.`medarbejdere`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `trainmodels`.`medarbejdere` (
  `MID` VARCHAR(45) NOT NULL,
  `Efternavn` VARCHAR(25) NULL DEFAULT NULL,
  `Fornavn` VARCHAR(45) NULL DEFAULT NULL,
  `Adresse` VARCHAR(45) NULL DEFAULT NULL,
  `Postnummer` VARCHAR(45) NULL DEFAULT NULL,
  `Bynavn` VARCHAR(45) NULL DEFAULT NULL,
  `Land` VARCHAR(45) NULL DEFAULT NULL,
  `Mobil` VARCHAR(45) NULL DEFAULT NULL,
  `Email` VARCHAR(45) NULL DEFAULT NULL,
  `Månedsløn` DECIMAL(8,2) NULL DEFAULT NULL,
  `Timeløn` DECIMAL(8,2) NULL DEFAULT NULL,
  `Lønkonto` VARCHAR(45) NULL DEFAULT NULL,
  `Jobtitel` VARCHAR(45) NULL DEFAULT NULL,
  `Afdeling` VARCHAR(45) NULL DEFAULT NULL,
  `ChefID` VARCHAR(45) NULL DEFAULT NULL,
  `Startdato` DATE NOT NULL,
  `Slutdato` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`MID`, `Startdato`))
 
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `trainmodels`.`salgsordrer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `trainmodels`.`salgsordrer` (
  `SOID` VARCHAR(8) NOT NULL,
  `KID` VARCHAR(8) NULL DEFAULT NULL,
  `Bestillingsdato` DATE NULL DEFAULT NULL,
  `Afsendelsesdato` DATE NULL DEFAULT NULL,
  `Faktureringsdato` DATE NULL DEFAULT NULL,
  `Betalingsdato` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`SOID`),
  INDEX `KID` (`KID` ASC) VISIBLE,
  CONSTRAINT `salgsordrer_ibfk_1`
    FOREIGN KEY (`KID`)
    REFERENCES `trainmodels`.`kunder` (`KID`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `trainmodels`.`salgsordrelinie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `trainmodels`.`salgsordrelinie` (
  `SOID` VARCHAR(8) NOT NULL,
  `PID` VARCHAR(8) NOT NULL,
  `SalgsordrelinieBeskrivelse` VARCHAR(45) NULL DEFAULT NULL,
  `Kvantitet` INT(4) NOT NULL,
  `Salgsstykkepris` DECIMAL(8,2) NOT NULL,
  PRIMARY KEY (`SOID`, `PID`),
  INDEX `PID` (`PID` ASC) VISIBLE,
  CONSTRAINT `salgsordrelinie_ibfk_1`
    FOREIGN KEY (`SOID`)
    REFERENCES `trainmodels`.`salgsordrer` (`SOID`)
    ON UPDATE CASCADE,
  CONSTRAINT `salgsordrelinie_ibfk_2`
    FOREIGN KEY (`PID`)
    REFERENCES `trainmodels`.`produkter` (`PID`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `trainmodels`.`timerapporter`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `trainmodels`.`timerapporter` (
  `MID` VARCHAR(45) NOT NULL,
  `Arbejdsdato` DATE NOT NULL,
  `Arbejdstime` DECIMAL(8,2) NULL DEFAULT NULL,
  `Status` VARCHAR(45) NULL DEFAULT NULL,
  `StatudID` VARCHAR(45) NULL DEFAULT NULL,
  `Bemærkning` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`MID`, `Arbejdsdato`),
  CONSTRAINT `timerapporter_ibfk_1`
    FOREIGN KEY (`MID`)
    REFERENCES `trainmodels`.`medarbejdere` (`MID`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;




-- -----------------------------------------------------
-- Medarbejdere table udfyldes
-- Virksomheden består af en direktør, en salgschef og en indkøbschef.
-- Direktøren og cheferne har deltids og fuldtidsmedarbejdere.
-- Direktøren er admin sammen med en medarbejder
-- Admin 1, Anders Bentsen
-- Admin 2, Malte Petersen
-- Admin 1 og 2 har til sammen to deltidsmedarbejdere
-- 1- Lise Jacobsen
-- 2- Frederik Thomsen

-- Admin 1, Anders Bentsen
Insert Medarbejdere Values('M00001', 'Bentsen','Anders', 'Elmedalsvej 1', 
'4200', 'Slagelse', 
'Danmark', '+45 54 78 95 25', 
'absn@gmail.com','100000.00', 
'666.00', '1234 5678910112', 
'direktør', 'admin', 
'selv', '2017-01-01',
'9999-12-31');
-- -----------------------------------------------------

-- Admin 2, Malte Petersen
Insert Medarbejdere Values('M00002', 'Petersen',
'Malte', 'Skovduestien 31', 
'2400', 'København', 
'Danmark', '+45 40 66 54 19', 
'mpns@gmail.com', '43500.00', 
'290.00', '1234 5438254324', 
'produktchef', 'admin', 
'M20001', '2017-01-01', 
'2022-12-31');
-- -----------------------------------------------------

-- 2 deltidsmedarbejdere
-- 1, Lise Jacobsen
Insert Medarbejdere Values('M20001', 'Jacobsen', 
'Lise', 'Hulgårdsvej 131', 
'2400', 'København', 
'Danmark', '+45 34 25 98 11', 
'ljne@gmail.com', '0.00', 
'195.00',  '1234 5638450134', 
'adminassistent', 'admin', 
'M20001', '2018-01-01', 
'2025-12-31');
-- -----------------------------------------------------

-- 2, Frederik Thomsen
Insert Medarbejdere Values('M20002', 'Thomsen',
'Frederik', 'Solsortvej 131', 
'2000', 'Frederiksberg', 
'Danmark', '+45 70 22 48 78', 
'ftns@gmail.com', '0.00', 
'195.00', '1234 5678253321', 
'adminassistent', 'admin', 
'M20001', '2017-01-01', 
'2030-12-31');
-- -----------------------------------------------------

-- En salgschef
-- Christine Dahl er salgschef og er ansvarlig for kunder og salgsordrer.
-- Christine har 2 fuldtidsmedarbejdere og 4 deltidsmedarbejdere
-- 2 Fuldtidsmedarbejdere
--  1, Hans Kristensen
--  2, Ole Hansen

-- 4 Deltidsmedarbejdere
-- 1, Iben Leth
-- 2, Hans Peter Mortensen
-- 3, Leif Jensen
-- 4, Morten Petersen

-- Christine Dahl
Insert Medarbejdere Values('M00003', 'Dahl',
'Christine', 'Tinghøjvej 46', 
'2860', 'Søborg', 
'Danmark', '+45 71 47 23 30', 
'cdl@gmail.com', '37500.00', 
'250.00', '1234 2635253387', 
'salgschef', 'salg', 
'M20001', '2017-01-01', 
'2020-12-31');
-- -----------------------------------------------------

-- Hans Kristensen
Insert Medarbejdere Values('M10001', 'Kristensen',
'Hans', 'Måløv parkvej 2', 
'2750', 'Ballerup', 
'Danmark', '+45 78 95 22 18', 
'hkn@gmail.com', '26250.00', 
'175.00', '1234 5625527866', 
'sælger', 'salg', 
'M20005', '2017-08-01', 
'2024-12-31');
-- -----------------------------------------------------

-- Ole Hansen
Insert Medarbejdere Values('M10002', 'Hansen',
'Ole', 'Bybjergvej 15', 
'2970', 'Hørsholm', 
'Danmark', '+45 91 95 47 17', 
'ohn@gmail.com', '28500.00', 
'190.00', '1234 6785784514', 
'sælger', 'salg', 
'M20005', '2017-10-01', 
'2019-12-31');
-- -----------------------------------------------------

-- Iben Leth
Insert Medarbejdere Values('M20003', 'Leth',
'Iben', 'smakkegårdsvej 197', 
'2820', 'Gentofte', 
'Danmark', '+45 93 89 99 10', 
'ibl@gmail.com', '0.00', 
'180.00', '1234 7854253595', 
'salgsassistent', 'salg', 
'M20005', '2019-01-01', 
'2026-12-31');
-- -----------------------------------------------------

-- Hans Peter Mortensen
Insert Medarbejdere Values('M20004', 'Mortensen',
'Hans Peter', 'Birkebakken 24', 
'2750', 'Ballerup', 
'Danmark', '+45 70 40 70 52', 
'hpm@gmail.com', '0.00', 
'185.00', '1234 2133454850', 
'salgsassistent', 'salg', 
'M20005', '2017-10-01', 
'2022-12-31');
-- -----------------------------------------------------

-- Leif Jensen 
Insert Medarbejdere Values('M20005', 'Jensen',
'Leif', 'Dronninggårds Alle 109', 
'2840', 'Holte', 
'Danmark', '+45 70 45 32 71', 
'ljn@gmail.com', '0.00', 
'180.00', '1234 5771815338', 
'salgsassistent', 'salg', 
'M20005', '2018-10-01', 
'2020-12-31');
-- -----------------------------------------------------

-- Morten Petersen
Insert Medarbejdere Values('M20006', 'Petersen',
'Morten', 'Skodsborg Strandvej 227', 
'2942', 'Skodsborg', 
'Danmark', '+45 42 50 50 98', 
'mpn@gmail.com', '0.00', 
'150.00', '1234 9876543210', 
'salgsassistent', 'salg', 
'M20005', '2018-10-01', 
'2020-12-31');
-- -----------------------------------------------------

-- En indkøbschefen
-- Eva Annette Frederiksen er ansvarlig for leverandører og købsordre.
-- Eva har 1 fuldtidsmedarbejder og 1 deltidsmedarbejder
-- 1 Fuldtidsmedarbejdere
--  1, Viggo Alberg

-- 1 Deltidsmedarbejder
-- 1, Ea Flyvholm

-- Eva Annette
Insert Medarbejdere Values('M00004', 'Frederiksen',
'Eva Annette', 'Vesterbo Vænge 34 1', 
'3500', 'Værløse', 
'Danmark', '+45 42 32 17 72', 
'efn@gmail.com','35000.00', 
'230.00', '1234 5247827447', 
'indkøbschef', 'indkøb', 
'M20001', '2018-01-01', 
'2024-12-31');
-- -----------------------------------------------------

--  Viggo Alberg
Insert Medarbejdere Values('M10003', 'Alberg',
'Viggo', 'Søndre Ringvej 55', 
'2605', 'Brøndby', 
'Danmark', '+45 42 72 12 21', 
'vag@gmail.com', '28500.00', 
'190.00', '4434 7531594026', 
'indkøber', 'indkøb', 
'M20012', '2019-10-01', 
'2025-12-31');
-- -----------------------------------------------------

--  Ea Flyvholm
Insert Medarbejdere Values('M20007', 'Flyvholm',
'Ea', 'H C Andersens Vej 23', 
'3000', 'Helsingør', 
'Danmark', '+45 32 78 49 01', 
'efm@gmail.com', '0.00', 
'155.00', '4434 1593574620', 
'indkøbsassistent', 'indkøb', 
'M20012', '2019-10-01', 
'2021-12-31');
select * from medarbejdere;
-- -----------------------------------------------------
-- Timerapporter table udfyldes
INSERT INTO `trainmodels`.`timerapporter` (`MID`, `Arbejdsdato`, `Arbejdstime`, `Status`, `StatudID`, `Bemærkning`) VALUES ('M20001', '2019-12-23', '4', 'Godkendt', 'M00001', 'Godt arbejde');
INSERT INTO `trainmodels`.`timerapporter` (`MID`, `Arbejdsdato`, `Arbejdstime`, `Status`, `StatudID`, `Bemærkning`) VALUES ('M20002', '2019-12-23', '4.5', 'Afvist', 'M00002', 'Du glemte at skrive under');
INSERT INTO `trainmodels`.`timerapporter` (`MID`, `Arbejdsdato`, `Arbejdstime`, `Status`, `StatudID`, `Bemærkning`) VALUES ('M10001', '2019-12-23', '7.5', 'Godkendt', 'M00003', 'Ingen');
INSERT INTO `trainmodels`.`timerapporter` (`MID`, `Arbejdsdato`, `Arbejdstime`, `Status`, `StatudID`, `Bemærkning`) VALUES ('M10002', '2019-12-23', '6', 'Afvist', 'M00003', 'Du tog tidligt hjem!');
INSERT INTO `trainmodels`.`timerapporter` (`MID`, `Arbejdsdato`, `Arbejdstime`, `Status`, `StatudID`, `Bemærkning`) VALUES ('M20003', '2019-12-23', '2', 'Godkendt', 'M00003', 'Ingen');
INSERT INTO `trainmodels`.`timerapporter` (`MID`, `Arbejdsdato`, `Arbejdstime`, `Status`, `StatudID`, `Bemærkning`) VALUES ('M20004', '2019-12-23', '4', 'Afvist', 'M00003', 'Ingen');
INSERT INTO `trainmodels`.`timerapporter` (`MID`, `Arbejdsdato`, `Arbejdstime`, `Status`, `StatudID`, `Bemærkning`) VALUES ('M20005', '2019-12-23', '3', 'Godkendt', 'M00003', 'Ingen');
INSERT INTO `trainmodels`.`timerapporter` (`MID`, `Arbejdsdato`, `Arbejdstime`, `Status`, `StatudID`, `Bemærkning`) VALUES ('M20006', '2019-12-23', '2', 'Godkendt', 'M00003', 'Ingen');
INSERT INTO `trainmodels`.`timerapporter` (`MID`, `Arbejdsdato`, `Arbejdstime`, `Status`, `StatudID`, `Bemærkning`) VALUES ('M10003', '2019-12-24', '12', 'Godkendt', 'M00004', 'Ingen');
INSERT INTO `trainmodels`.`timerapporter` (`MID`, `Arbejdsdato`, `Arbejdstime`, `Status`, `StatudID`, `Bemærkning`) VALUES ('M20007', '2019-12-24', '4', 'Godkendt', 'M00004', 'Ingen');
#select * from timerapporter;
-- -----------------------------------------------------
-- Kunder table udfyldes
INSERT INTO `trainmodels`.`kunder` (`KID`, `Kreditgrænse`, `Efternavn`, `Fornavn`, `Adresse`, `Postnummer`, `Bynavn`, `Land`, `Mobil`, `Email`) VALUES ('K00001', '150000.0', 'Reza', 'Reza', 'MagstrÃ¦de-Snaregade', '777', 'Copenhagen', 'Denmark', 'Unknown', 're@dk.com');
INSERT INTO `trainmodels`.`kunder` (`KID`, `Kreditgrænse`, `Efternavn`, `Fornavn`, `Adresse`, `Postnummer`, `Bynavn`, `Land`, `Mobil`, `Email`) VALUES ('K00002', '225000.0', 'Bshar', 'Bshar', 'Champs ElysÃ©es', '758', 'Paris', 'Frence', 'Unknown', 'ba@fr.com');
INSERT INTO `trainmodels`.`kunder` (`KID`, `Kreditgrænse`, `Efternavn`, `Fornavn`, `Adresse`, `Postnummer`, `Bynavn`, `Land`, `Mobil`, `Email`) VALUES ('K00003', '75000.0', 'Jawad', 'Jawad', 'Via Montenapoleone', '92631', 'Milan', 'Italy', 'Unknown', 'ja@it.com');
INSERT INTO `trainmodels`.`kunder` (`KID`, `Kreditgrænse`, `Efternavn`, `Fornavn`, `Adresse`, `Postnummer`, `Bynavn`, `Land`, `Mobil`, `Email`) VALUES ('K00004', '325000.0', 'Amer', 'Amer', 'Fifth Avenue, Manhattan', '7744', 'New York', 'USA', 'Unknown', 'am@us.com');
INSERT INTO `trainmodels`.`kunder` (`KID`, `Kreditgrænse`, `Efternavn`, `Fornavn`, `Adresse`, `Postnummer`, `Bynavn`, `Land`, `Mobil`, `Email`) VALUES ('K00005', '700000.0', 'Donald', 'Trump', 'Sheikh Zayed Road', '0', 'Dubai', 'UAE', 'Unknown', 'dt@ua.com');
#select * from kunder;
-- -----------------------------------------------------
-- Produkttyper
INSERT INTO `trainmodels`.`produkttyper` (`Produkttype`, `Beskrivelse`) VALUES ('High speed trains\n', 'High speed trains are generally defined as trains that can operate 125mph or faster. High speed trains generally connect large metropolitan areas (with very few stops in between) and are meant to be competitive with airlines in terms of overall travel time.\n\nAlthough High Speed Rail trains in general are compatible with regular passenger and freight trains (and often share tracks at major stations in Europe), it requires dedicated tracks to operate at high speed.\n\nHigh speed trains current operates in Europe (France, Germany, Britain, Spain, Italy, and more), Japan, China, South Korea, and Taiwan. In North America, Amtrak’s Acela (Boston – Washington DC) meets the definition of of high speed rail, but uses heavier trainsets than its European and Asian counterparts.\n\nThe proposed high speed rail system in California would use trainsets similar to those in Europe and Asia.');
INSERT INTO `trainmodels`.`produkttyper` (`Produkttype`, `Beskrivelse`) VALUES ('Inter-city trains\n', 'Inter-city trains generally mean trains traveling long distances connecting metropolitan areas. Although the distances covered by some of these trains are comparable to airlines, inter-city trains generally operate at highway speed. Long distance inter-city trains may provide amenities not found on most other forms of transportation, including sleeper-cars and cafe/dining cars.\n\nAmtrak is the operator of inter-city trains in the United States. Although Amtrak is much slower than airlines, inter-city trains serve small cities between metropolitan areas aren’t served by airlines.\n\nHistorically, inter-city passenger trains are operated by railroad companies that also haul freight trains. After World War II, ridership on passenger trains steadily declined with competition from automobiles and airlines. At that time, many railroads wanted to abandon passenger train service to cut operating losses. In 1971, Amtrak was established by Congress to nationalize inter-city passenger rail business. Outside the Northeast Corridor (Boston and DC), Amtrak uses tracks owned by various freight railroads.');
INSERT INTO `trainmodels`.`produkttyper` (`Produkttype`, `Beskrivelse`) VALUES ('Commuter/regional trains\n', 'Commuter trains generally mean trains connecting suburban areas with the central city and primarily serves riders to and from work. Commuter trains typically run on weekdays, during rush hours, and only in the peak directions. A prime example would be Altamont Commuter Express, which run from Stockton to San Jose during weekday mornings, and from San Jose to Stockion during weekday afternoons. However, commuter rail systems like Caltrain and Metrolink can run trains all day in both directions.\n\nIn the United States, typical commuter trains are locomotive-haul. The locomotive on one end of the train either pulls the unpowered passenger cars (from the front) or pushes them (from the back) to make them move. Most locomotives are powered by diesel fuel and some (in the East Coast) by electricity.\n\nMany commuter trains in Europe, as well as some in the U.S. use electric multiple units instead of locomotives. In a multiple-unit train, every car (or every other car) in the train has motors which are capable of propelling the vehicle. Multiple unit trains are more reliable (with multiple engine/motors rather than one engine) and more efficient (by easily changing train length for peak and off-peak hours).\n\n\nProposed Caltrain EMU\n\nMost commuter trains in the U.S. share tracks with Amtrak and freight trains, therefore they are subject to Federal Railroad Administration regulations. FRA regulations require commuter trains to be heavier (in the belief that heavier trains are safer) and less efficient than commuter trains in Europe.\n\nBayRail Alliance goal is to improve Caltrain service by converting its power source from diesel to electric, and use light weight European style rail cars. Caltrain is currently pursuing these goals under Project 2015.');
INSERT INTO `trainmodels`.`produkttyper` (`Produkttype`, `Beskrivelse`) VALUES ('Rapid transit\n', 'Rapid transit, which is also known as metro, subway, and heavy rail, mean trains that generally serve the urban-core, have large passenger capacity, and operate totally separate from road traffic. In order to run separately from road traffic in the city-core, rapid transit trains would run either above or underground.\n\nMany major cities (like New York, London, Washington D.C.) have extensive systems that make traveling within a city fast and convenient. BART is the rapid transit system in the Bay Area. However, BART does not serve San Francisco as well as other systems do in their cities.\n\nBecause of the grade-separated nature of rapid transit systems, it is generally much more expensive to build per mile compared to light rail and commuter rail. Also, these trains lack seatings and other amentities. Rapid transit technologies such as BART are not cost effective to provide long distance-suburban service.');
INSERT INTO `trainmodels`.`produkttyper` (`Produkttype`, `Beskrivelse`) VALUES ('Light rail\n', 'Light rail, which might be also known as trolley and streetcars, mean trains that function as local transit in an urban-core and can operate on the street-level. Compared to rapid transit, light rail costs less, is more pedestrian friendly, but has less passenger capacity. The major advantage with light rail is that it can operate like rapid transit or like local buses, depending on the available infrastructure.\n\nIn Sacramento, San Diego, Portland, and San Jose, light rail trains run faster in the suburbs (dedicated tracks) and slower in downtown (street median). In San Francisco, trains operate in mixed traffic outside downtown and underground in downtown. Light Rail stations can be a few city blocks apart in downtown and a mile or more apart in the suburbs.\n\nMost light rail systems are integrated with the local transit network. Fares for most light rail systems are the same as the buses.\n\nAlthough most light rail can physically share tracks with freight and commuter trains, it is not legally permitted because light rail trains do not meet the weight requirement set by the FRA. FRA however does grant waivers to some systems to share tracks as long as freight trains only run at night when there’s no light rail trains on the same track.\n\nMost light rail systems are electric (powered by overhead wires), but some suburban-only systems (Sprinter in Oceanside, Riverline in New Jersey) run on diesel. The proposed SMART system in the North Bay would run on diesel as well.');
INSERT INTO `trainmodels`.`produkttyper` (`Produkttype`, `Beskrivelse`) VALUES ('Modern streetcar\n', 'In some cities such as Portland and Seattle, they have a urban streetcar system that is somewhat compatible but operated separately from their light rail system. Those streetcars typically have smaller dimensions and operate at slower speed than their light rail counterpart. The streetcars are meant to facilitate local circulation in the urban core (and serve as a catalyst for transit oriented developments) rather than connecting nearby suburbs with downtown.\n\nOther cities are planning to build downtown streetcars modeled after Portland and Seattle. Those include Los Angeles and Oakland.');
#select * from produkttyper;
-- -----------------------------------------------------
-- produkter
INSERT INTO `trainmodels`.`produkter` (`PID`, `Produkttype`, `Produktbeskrivelse`, `HTMLBeskrivelse`, `billede_id`, `Leverandørnavnbeskrivelse`, `Købspris`, `Salgspris`, `Lagerantal`, `Transportdage_L_V`, `Transportdage_V_K`) VALUES ('P00001', 'High speed trains', 'High speed', 'High speed trains', 'P00001', 'Frankfort', '7400', '9200', '21', '18', '28');
INSERT INTO `trainmodels`.`produkter` (`PID`, `Produkttype`, `Produktbeskrivelse`, `HTMLBeskrivelse`, `billede_id`, `Leverandørnavnbeskrivelse`, `Købspris`, `Salgspris`, `Lagerantal`, `Transportdage_L_V`, `Transportdage_V_K`) VALUES ('P00002', 'Inter-city trains', 'Inter-city', 'Inter-city trains', 'P00002', 'Dublin', '3300', '6700', '14', '7', '9');
INSERT INTO `trainmodels`.`produkter` (`PID`, `Produkttype`, `Produktbeskrivelse`, `HTMLBeskrivelse`, `billede_id`, `Leverandørnavnbeskrivelse`, `Købspris`, `Salgspris`, `Lagerantal`, `Transportdage_L_V`, `Transportdage_V_K`) VALUES ('P00003', 'Commuter/regional trains', 'Commuter/regional', 'Commuter/regional trains', 'P00003', 'Berlin', '3700', '8400', '21', '2', '6');
INSERT INTO `trainmodels`.`produkter` (`PID`, `Produkttype`, `Produktbeskrivelse`, `HTMLBeskrivelse`, `billede_id`, `Leverandørnavnbeskrivelse`, `Købspris`, `Salgspris`, `Lagerantal`, `Transportdage_L_V`, `Transportdage_V_K`) VALUES ('P00004', 'Rapid transit', 'Rapid', 'Rapid transit', 'P00004', 'Madrid', '8200', '9200', '29', '5', '9');
INSERT INTO `trainmodels`.`produkter` (`PID`, `Produkttype`, `Produktbeskrivelse`, `HTMLBeskrivelse`, `billede_id`, `Leverandørnavnbeskrivelse`, `Købspris`, `Salgspris`, `Lagerantal`, `Transportdage_L_V`, `Transportdage_V_K`) VALUES ('P00005', 'Light rail', 'Light', 'Light rail', 'P00005', 'Oslo', '8900', '11200', '5', '16', '21');
INSERT INTO `trainmodels`.`produkter` (`PID`, `Produkttype`, `Produktbeskrivelse`, `HTMLBeskrivelse`, `billede_id`, `Leverandørnavnbeskrivelse`, `Købspris`, `Salgspris`, `Lagerantal`, `Transportdage_L_V`, `Transportdage_V_K`) VALUES ('P00006', 'Modern streetcar', 'Modern', 'Modern streetcar', 'P00006', 'Brussel', '10100', '13000', '3', '8', '14');
#select * from produkter;
-- -----------------------------------------------------
-- SalgsOrdrer
INSERT INTO `trainmodels`.`SalgsOrdrer` (`SOID`, `KID`, `Bestillingsdato`, `Afsendelsesdato`, `Faktureringsdato`, `Betalingsdato`) VALUES ('SO00001', 'K00001', '2020-04-17', '2020-04-19', '2020-04-18', '2020-04-17');
INSERT INTO `trainmodels`.`SalgsOrdrer` (`SOID`, `KID`, `Bestillingsdato`, `Afsendelsesdato`, `Faktureringsdato`, `Betalingsdato`) VALUES ('SO00002', 'K00002', '2020-04-12', '2020-04-15', '2020-04-13', '2020-04-12');
INSERT INTO `trainmodels`.`SalgsOrdrer` (`SOID`, `KID`, `Bestillingsdato`, `Afsendelsesdato`, `Faktureringsdato`, `Betalingsdato`) VALUES ('SO00003', 'K00003', '2020-03-15', '2020-03-19', '2020-03-14', '2020-03-15');
INSERT INTO `trainmodels`.`SalgsOrdrer` (`SOID`, `KID`, `Bestillingsdato`, `Afsendelsesdato`, `Faktureringsdato`, `Betalingsdato`) VALUES ('SO00004', 'K00004', '2019-01-21', '2019-01-23', '2019-01-22', '2019-01-21');
INSERT INTO `trainmodels`.`SalgsOrdrer` (`SOID`, `KID`, `Bestillingsdato`, `Afsendelsesdato`, `Faktureringsdato`, `Betalingsdato`) VALUES ('SO00005', 'K00005', '2007-07-07', '2007-07-11', '2007-07-08', '2007-07-07');
INSERT salgsordrer values ('SO00006','K00001','2020-04-28','2020-04-30','2020-05-03','2020-04-30');

#select * from SalgsOrdrer;
-- -----------------------------------------------------
-- Salgsordrelinie
INSERT INTO `trainmodels`.`Salgsordrelinie` (`SOID`, `PID`, `SalgsordrelinieBeskrivelse`, `Kvantitet`, `Salgsstykkepris`) VALUES ('SO00001', 'P00001', 'High speed trains', '12', '9200');
INSERT INTO `trainmodels`.`Salgsordrelinie` (`SOID`, `PID`, `SalgsordrelinieBeskrivelse`, `Kvantitet`, `Salgsstykkepris`) VALUES ('SO00002', 'P00002', 'Inter-city trains', '15', '6700');
INSERT INTO `trainmodels`.`Salgsordrelinie` (`SOID`, `PID`, `SalgsordrelinieBeskrivelse`, `Kvantitet`, `Salgsstykkepris`) VALUES ('SO00003', 'P00003', 'Commuter/regional trains', '17', '8400');
INSERT INTO `trainmodels`.`Salgsordrelinie` (`SOID`, `PID`, `SalgsordrelinieBeskrivelse`, `Kvantitet`, `Salgsstykkepris`) VALUES ('SO00004', 'P00004', 'Rapid transit', '29', '9200');
INSERT INTO `trainmodels`.`Salgsordrelinie` (`SOID`, `PID`, `SalgsordrelinieBeskrivelse`, `Kvantitet`, `Salgsstykkepris`) VALUES ('SO00005', 'P00005', 'Light rail', '47', '11200');
INSERT Salgsordrelinie VALUES ('SO00006', 'P00001', 'High speed trains', '7', '9200'), ('SO00006', 'P00004', 'Rapid transit', '13', '9200'),('SO00006', 'P00005', 'Light rail', '3', '11200');
UPDATE Salgsordrelinie SET PID='P00003', Salgsstykkepris='8400', SalgsordrelinieBeskrivelse='Commuter/regional trains' WHERE SOID='SO00006' AND PID='P00005';
DELETE FROM Salgsordrelinie  WHERE SOID='SO00006' and PID='P00001';

#select * from Salgsordrelinie;
-- -----------------------------------------------------
-- Leverandører
INSERT INTO `trainmodels`.`Leverandører` (`LID`, `Leverandørnavnbeskrivelse`, `Efternavn`, `Fornavn`, `Adresse`, `Postnummer`, `Bynavn`, `Land`, `Mobil`, `Email`) VALUES ('L00001', 'High speed trains', 'Mason', 'Smith', 'Florida', '4500', 'Florida', 'US.', 'NULL', 'NULL');
INSERT INTO `trainmodels`.`Leverandører` (`LID`, `Leverandørnavnbeskrivelse`, `Efternavn`, `Fornavn`, `Adresse`, `Postnummer`, `Bynavn`, `Land`, `Mobil`, `Email`) VALUES ('L00002', 'Inter-city trains', 'Murphy', 'Johnson', 'New York', '51385', 'New York', 'US.', 'NULL', 'NULL');
INSERT INTO `trainmodels`.`Leverandører` (`LID`, `Leverandørnavnbeskrivelse`, `Efternavn`, `Fornavn`, `Adresse`, `Postnummer`, `Bynavn`, `Land`, `Mobil`, `Email`) VALUES ('L00003', 'Commuter/regional trains', 'Brown', 'Williams', 'Las Vegas', '5124', 'Las Vegas', 'US.', 'NULL', 'NULL');
INSERT INTO `trainmodels`.`Leverandører` (`LID`, `Leverandørnavnbeskrivelse`, `Efternavn`, `Fornavn`, `Adresse`, `Postnummer`, `Bynavn`, `Land`, `Mobil`, `Email`) VALUES ('L00004', 'Rapid transit', 'Morton', 'Brown', 'Paris', '1268', 'Paris', 'Frence', 'NULL', 'NULL');
INSERT INTO `trainmodels`.`Leverandører` (`LID`, `Leverandørnavnbeskrivelse`, `Efternavn`, `Fornavn`, `Adresse`, `Postnummer`, `Bynavn`, `Land`, `Mobil`, `Email`) VALUES ('L00005', 'Light rail', 'Li', 'Jones', 'Dublin', '89412', 'Dublin', 'Ireland', 'NULL', 'NULL');
INSERT INTO `trainmodels`.`Leverandører` (`LID`, `Leverandørnavnbeskrivelse`, `Efternavn`, `Fornavn`, `Adresse`, `Postnummer`, `Bynavn`, `Land`, `Mobil`, `Email`) VALUES ('L00006', 'Modern streetcar', 'Wilson', 'Oliver', 'Berlin', '51903', 'Berlin', 'Germany', 'NULL', 'NULL');
#select * from Leverandører;
-- -----------------------------------------------------
-- Købsordrer
INSERT INTO `trainmodels`.`Købsordrer` (`KOID`, `LID`, `Bestillingsdato`, `Modtagelsesdato`, `Betalingsdato`) VALUES ('K00001', 'L00001', '2019-12-21', '2019-12-23', '2019-12-21');
INSERT INTO `trainmodels`.`Købsordrer` (`KOID`, `LID`, `Bestillingsdato`, `Modtagelsesdato`, `Betalingsdato`) VALUES ('K00002', 'L00002', '2017-04-21', '2017-04-27', '2017-04-21');
INSERT INTO `trainmodels`.`Købsordrer` (`KOID`, `LID`, `Bestillingsdato`, `Modtagelsesdato`, `Betalingsdato`) VALUES ('K00003', 'L00003', '2017-11-13', '2017-11-17', '2017-11-13');
INSERT INTO `trainmodels`.`Købsordrer` (`KOID`, `LID`, `Bestillingsdato`, `Modtagelsesdato`, `Betalingsdato`) VALUES ('K00004', 'L00004', '2017-09-07', '2017-09-11', '2017-09-07');
INSERT INTO `trainmodels`.`Købsordrer` (`KOID`, `LID`, `Bestillingsdato`, `Modtagelsesdato`, `Betalingsdato`) VALUES ('K00005', 'L00005', '2006-08-04', '2006-08-08', '2006-08-04');
#select * from Købsordrer;
-- -----------------------------------------------------
-- Købsordrelinie
INSERT INTO `trainmodels`.`Købsordrelinie` (`KOID`, `PID`, `KøbsordrelinieBeskrivelse`, `Kvantitet`, `Købsstykkepris`) VALUES ('K00001', 'P00001', 'High speed trains', '7', '7400');
INSERT INTO `trainmodels`.`Købsordrelinie` (`KOID`, `PID`, `KøbsordrelinieBeskrivelse`, `Kvantitet`, `Købsstykkepris`) VALUES ('K00002', 'P00002', 'Inter-city trains', '12', '3300');
INSERT INTO `trainmodels`.`Købsordrelinie` (`KOID`, `PID`, `KøbsordrelinieBeskrivelse`, `Kvantitet`, `Købsstykkepris`) VALUES ('K00003', 'P00003', 'Commuter/regional trains', '13', '3700');
INSERT INTO `trainmodels`.`Købsordrelinie` (`KOID`, `PID`, `KøbsordrelinieBeskrivelse`, `Kvantitet`, `Købsstykkepris`) VALUES ('K00004', 'P00004', 'Rapid transit', '24', '8200');
INSERT INTO `trainmodels`.`Købsordrelinie` (`KOID`, `PID`, `KøbsordrelinieBeskrivelse`, `Kvantitet`, `Købsstykkepris`) VALUES ('K00005', 'P00005', 'Light rail', '40', '8900');
select * from Købsordrelinie;
-- -----------------------------------------------------
