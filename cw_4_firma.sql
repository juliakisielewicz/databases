-- Database: firma

-- 1. Nowa baza danych

CREATE DATABASE firma;

-- 2. Nowy schemat
 
CREATE SCHEMA IF NOT EXISTS rozliczenia;

-- 3. Dodanie tabel
 
CREATE TABLE IF NOT EXISTS rozliczenia.pracownicy (
   id_pracownika INT PRIMARY KEY, 
   imie VARCHAR(30) NOT NULL, 
   nazwisko VARCHAR(30) NOT NULL, 
   adres VARCHAR(50), 
   telefon VARCHAR(15));

CREATE TABLE IF NOT EXISTS rozliczenia.godziny (
   id_godziny INT PRIMARY KEY, 
   "data" DATE, 
   liczba_godzin float, 
   id_pracownika INT);

CREATE TABLE IF NOT EXISTS rozliczenia.pensje (
   id_pensji INT PRIMARY KEY, 
   stanowisko VARCHAR(30), 
   kwota float NOT NULL, 
   id_premii INT);

CREATE TABLE IF NOT EXISTS rozliczenia.premie (
   id_premii INT PRIMARY KEY, 
   rodzaj VARCHAR(15), 
   kwota float NOT NULL);

-- 3.1 Modyfikacja - dodanie kluczy obcych

ALTER TABLE rozliczenia.godziny 
ADD FOREIGN KEY (id_pracownika) REFERENCES rozliczenia.pracownicy(id_pracownika);

ALTER TABLE rozliczenia.pensje
ADD FOREIGN KEY (id_premii) REFERENCES rozliczenia.premie(id_premii);

-- 4. Wypełnienie rekordami

INSERT INTO rozliczenia.pracownicy VALUES 
(
	1, 
	'Zofia', 
	'Wrona', 
	'ul. Zwierzyniecka 34 32-890 Bochnia', 
	'982398473'
),
(
	2, 
	'Franciszek', 
	'Pająk', 
	'ul. Magnoliowa 2 35-367 Katowice', 
	'982747223'
),
(
	3, 
	'Edward', 
	'Delfin', 
	'ul. Krótka 94 36-987 Kraków', 
	'974823656'
),
(
	4, 
	'Andrzej', 
	'Kot', 
	'ul. Prosta 11 36-680 Kraków', 
	'925362963'
),
(
	5, 
	'Karol', 
	'Sowa', 
	'ul. Jodłowa 56 33-212 Kraków', 
	'975433560'
),
(
	6, 
	'Zuzanna', 
	'Łoś', 
	'ul. Zakątek 89 34-756 Kraków', 
	'908648376'
),
(
	7, 
	'Mateusz', 
	'Foka', 
	'ul. Dąbrowskiej 78 33-909 Lublin', 
	'975999560'
),
(
	8, 
	'Jadwiga', 
	'Wróbel', 
	'ul. Maki 4 38-555 Wieliczka', 
	'898274624'
),
(
	9, 
	'Maria', 
	'Rekin', 
	'ul. Dobczycka 9 33-111 Warszawa', 
	'98928278'
),
(
	10, 
	'Miłosz', 
	'Owca', 
	'ul. Zielona 234 31-898 Kraków', 
	'909345246'
);

INSERT INTO rozliczenia.godziny VALUES 
(
	1, '2020-01-23', 5, 3
),
(
	2, '2020-01-30', 8, 6
),
(
	3, '2020-02-08', 8, 1
),
(
	4, '2020-02-11', 8, 5
),
(
	5, '2020-02-14', 5, 2
),
(
	6, '2020-02-20', 8, 6
),
(
	7, '2020-02-25', 8, 7
),
(
	8, '2020-02-26', 5, 8
),
(
	9, '2020-03-01', 8, 9
),
(
	10, '2020-03-11', 5, 5
);

INSERT INTO rozliczenia.premie VALUES
(
	1, 'uznaniowa', 400
),
(
	2, 'regulaminowa', 200
),
(
	3, 'uznaniowa', 350
),
(
	4, 'uznaniowa', 400
),
(
	5, 'regulaminowa', 300
),
(
	6, 'regulaminowa', 300
),
(
	7, 'uznaniowa', 700
),
(
	8, 'regulaminowa', 850
),
(
	9, 'uznaniowa', 750
),
(
	10, 'regulaminowa', 200
);

INSERT INTO rozliczenia.pensje VALUES
(
	1, 'Księgowy', 4200, 4
),
(
	2, 'Asystent', 3100, 1
),
(
	3, 'Dyrektor finansowy', 14100, 7
),
(
	4, 'Sekretarka', 3200, 2
),
(
	5, 'Projektant', 5400, 3
),
(
	6, 'Informatyk', 5100, 5
),
(
	7, 'Dyrektor ds. marketingu', 12300, 9
),
(
	8, 'Przedstawiciel handlowy', 4300, 6
),
(
	9, 'Kierowca', 3000, 10
),
(
	10, 'Radca Prawny', 9400, 8
);

-- 5. Wyswietl pracowników i adresy 

SELECT nazwisko, adres FROM rozliczenia.pracownicy;

-- 6. Konwersja daty - dzień tygodnia (niedziela to 0) i miesiąc

SELECT DATE_PART('dow', "data") AS dzien_tygodnia, 
		DATE_PART('month', "data") AS miesiac FROM rozliczenia.godziny;

-- 7. rodział na kwoty netto i brutto

ALTER TABLE rozliczenia.pensje RENAME COLUMN kwota TO kwota_brutto;
ALTER TABLE rozliczenia.pensje ADD kwota_netto float GENERATED ALWAYS AS (kwota_brutto * 0.81) STORED; 
SELECT * FROM rozliczenia.pensje;