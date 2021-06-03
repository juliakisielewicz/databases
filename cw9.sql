--CREATE DATABASE geochronolo;

--CREATE SCHEMA geochro;

CREATE TABLE geochro.GeoEon (
id_eon INT PRIMARY KEY,
nazwa_eon VARCHAR(30));

CREATE TABLE geochro.GeoEra (
id_era INT PRIMARY KEY,
id_eon INT,
nazwa_era VARCHAR(30));

CREATE TABLE geochro.GeoOkres (
id_okres INT PRIMARY KEY,
id_era INT,
nazwa_okres VARCHAR(30));

CREATE TABLE geochro.GeoEpoka (
id_epoka INT PRIMARY KEY,
id_okres INT,
nazwa_epoka VARCHAR(30));

CREATE TABLE geochro.GeoPietro (
id_pietro INT PRIMARY KEY,
id_epoka INT,
nazwa_pietro VARCHAR(30));

---------------------------------------------------

INSERT INTO geochro.GeoEon VALUES 
(1, 'Fanerozoik');

INSERT INTO geochro.GeoEra VALUES 
(1, 1, 'Paleozoik'),
(2, 1, 'Mezozoik'),
(3, 1, 'Kenozoik');

INSERT INTO geochro.GeoOkres VALUES 
(1, 1, 'Dewon'),
(2, 1, 'Karbon'),
(3, 1, 'Perm'),
(4, 2, 'Trias'),
(5, 2, 'Jura'),
(6, 2, 'Kreda'),
(7, 3, 'Paleogen'),
(8, 3, 'Neogen'),
(9, 3, 'Czwartorzêd');

INSERT INTO geochro.GeoEpoka VALUES
(1, 1, 'Dolny'),
(2, 1, 'Œrodkowy'),
(3, 1, 'Górny'),
(4, 2, 'Dolny'),
(5, 2, 'Górny'),
(6, 3, 'Dolny'),
(7, 3, 'Górny'),
(8, 4, 'Dolny'),
(9, 4, 'Œrodkowy'),
(10, 4, 'Górny'),
(11, 5, 'Dolny'),
(12, 5, 'Œrodkowy'),
(13, 5, 'Górny'),
(14, 6, 'Dolny'),
(15, 6, 'Górny'),
(16, 7, 'Paleocen'),
(17, 7, 'Eocen'),
(18, 7, 'Oligocen'),
(19, 8, 'Miocen'),
(20, 8, 'Pliocen'),
(21, 9, 'Plejstocen'),
(22, 9, 'Holocen');

INSERT INTO geochro.GeoPietro VALUES 
(1, 1, 'lochkow'),
(2, 1, 'prag'),
(3, 1, 'ems'),
(4, 2, 'eifel'),
(5, 2, 'zywet'),
(6, 3, 'fran'),
(7, 3, 'famen'),
(8, 4, 'turnej'),
(9, 4, 'wizen'),
(10, 4, 'serpuchow'),
(11, 5, 'baszkir'),
(12, 5, 'moskow'),
(13, 5, 'kasimow'),
(14, 5, 'gzel'),
(15, 6, 'assel'),
(16, 6, 'sakmar'),
(17, 6, 'artinsk'),
(18, 6, 'kungur'),
(19, 7, 'road'),
(20, 7, 'word'),
(21, 7, 'kapitan'),
(22, 8, 'wucziaping'),
(23, 8, 'czangsing'),
(24, 9, 'ind'),
(25, 9, 'olenek'),
(26, 10, 'anizyk'),
(27, 10, 'ladyn'),
(28, 11, 'karnik'),
(29, 11, 'noryk'),
(30, 11, 'retyk'),
(31, 12, 'hettang'),
(32, 12, 'synemur'),
(33, 12, 'pliensbach'),
(34, 12, 'toark'),
(35, 13, 'aalen'),
(36, 13, 'bajos'),
(37, 13, 'baton'),
(38, 13, 'kelowej'),
(39, 14, 'oksford'),
(40, 14, 'kimeryd'),
(41, 14, 'tyton'),
(42, 15, 'berrias'),
(43, 15, 'walanzyn'),
(44, 15, 'hoteryw'),
(45, 15, 'barrem'),
(46, 15, 'apt'),
(47, 15, 'alb'),
(48, 16, 'cenoman'),
(49, 16, 'turon'),
(50, 16, 'koniak'),
(51, 16, 'santon'),
(52, 16, 'kampan'),
(53, 16, 'mastrycht'),
(54, 17, 'dan'),
(55, 17, 'zeland'),
(56, 17, 'tanet'),
(57, 18, 'iprez'),
(58, 18, 'lutet'),
(59, 18, 'barton'),
(60, 18, 'priabon'),
(61, 19, 'rupel'),
(62, 19, 'szat'),
(63, 20, 'akwitan'),
(64, 20, 'burdygal'),
(65, 20, 'lang'),
(66, 20, 'serrawal'),
(67, 20, 'torton'),
(68, 20, 'messyn'),
(69, 21, 'zankl'),
(70, 21, 'piacent'),
(71, 22, 'gelas'),
(72, 22, 'kalabr'),
(73, 22, 'chiban'),
(74, 22, 'pozny'),
(75, 23, 'grenland'),
(76, 23, 'northgrip'),
(77, 23, 'megalaj');

---------------------------------------------------------

/*
CREATE TABLE geochro.GeoTabela (
id_pietro INT PRIMARY KEY,
nazwa_pietro VARCHAR(30),
id_epoka INT,
nazwa_epoka VARCHAR(30),
id_okres INT,
nazwa_okres VARCHAR(30),
id_era INT,
nazwa_era VARCHAR(30),
id_eon INT,
nazwa_eon VARCHAR(30)
);
*/

SELECT GeoEon.id_eon, GeoEra.id_era, GeoOkres.id_okres, GeoEpoka.id_epoka, GeoPietro.id_pietro, 
GeoEon.nazwa_eon, GeoEra.nazwa_era, GeoOkres.nazwa_okres, GeoEpoka.nazwa_epoka, GeoPietro.nazwa_pietro
INTO geochro.GeoTabela
FROM geochro.GeoPietro JOIN geochro.GeoEpoka ON GeoPietro.id_epoka = GeoEpoka.id_epoka
JOIN geochro.GeoOkres ON GeoEpoka.id_okres = GeoOkres.id_okres JOIN geochro.GeoEra ON GeoOkres.id_era = GeoEra.id_era
JOIN geochro.GeoEon ON GeoEra.id_eon = GeoEon.id_eon;

-------------------------------------------------------------

CREATE TABLE geochro.Dziesiec (cyfra int, "bit" int);
INSERT INTO geochro.Dziesiec VALUES 
(0, 0),
(1, 1),
(2, 0),
(3, 0),
(4, 1),
(5, 0),
(6, 1),
(7, 1),
(8, 0),
(9, 1);

CREATE TABLE geochro.Milion (liczba int, cyfra int, "bit" int);
INSERT INTO geochro.Milion 
SELECT a1.cyfra +10* a2.cyfra +100*a3.cyfra + 1000*a4.cyfra
+ 10000*a5.cyfra + 10000*a6.cyfra AS liczba, a1.cyfra AS cyfra, a1.bit AS bit
FROM geochro.Dziesiec a1, geochro.Dziesiec a2, geochro.Dziesiec a3, 
geochro.Dziesiec a4, geochro.Dziesiec a5, geochro.Dziesiec a6;

-----------------------------------------------------------------------------------------------
--ZAPYTANIA

SELECT COUNT(*) FROM geochro.Milion INNER JOIN geochro.GeoTabela ON ((Milion.liczba%77)=(GeoTabela.id_pietro));

SELECT COUNT(*) FROM geochro.Milion INNER JOIN geochro.GeoPietro ON ((Milion.liczba%77)=GeoPietro.id_pietro) 
JOIN geochro.GeoEpoka ON GeoPietro.id_epoka = GeoEpoka.id_epoka
JOIN geochro.GeoOkres ON GeoEpoka.id_okres = GeoOkres.id_okres JOIN geochro.GeoEra ON GeoOkres.id_era = GeoEra.id_era
JOIN geochro.GeoEon ON GeoEra.id_eon = GeoEon.id_eon;


SELECT COUNT(*) FROM geochro.Milion WHERE (geochro.Milion.liczba%77)=
(SELECT id_pietro FROM geochro.GeoTabela WHERE (geochro.Milion.liczba%77)=(id_pietro));


SELECT COUNT(*) FROM geochro.Milion WHERE (Milion.liczba%77) IN
(SELECT GeoPietro.id_pietro FROM geochro.GeoPietro 
JOIN geochro.GeoEpoka ON GeoPietro.id_epoka = GeoEpoka.id_epoka
JOIN geochro.GeoOkres ON GeoEpoka.id_okres = GeoOkres.id_okres JOIN geochro.GeoEra ON GeoOkres.id_era = GeoEra.id_era
JOIN geochro.GeoEon ON GeoEra.id_eon = GeoEon.id_eon);

----------------------------------------------------------------
--ZAK£ADANIE INDEKSÓW

CREATE INDEX EON_IDX ON geochro.GeoEra (id_eon);
CREATE INDEX ERA_IDX ON geochro.GeoOkres (id_era);
CREATE INDEX OKRES_IDX ON geochro.GeoEpoka (id_okres);
CREATE INDEX EPOKA_IDX ON geochro.GeoPietro (id_epoka);

CREATE INDEX EON_T_IDX ON geochro.GeoTabela (id_eon);
CREATE INDEX ERA_T_IDX ON geochro.GeoTabela (id_era);
CREATE INDEX OKRES_T_IDX ON geochro.GeoTabela (id_okres);
CREATE INDEX EPOKA_T_IDX ON geochro.GeoTabela (id_epoka);

CREATE INDEX LICZBA_IDX ON geochro.Milion (liczba);



