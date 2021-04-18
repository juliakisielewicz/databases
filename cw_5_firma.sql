-- Database: firma

-- 1. Nowa baza danych

CREATE DATABASE firma;

-- 2. Nowy schemat
 
CREATE SCHEMA IF NOT EXISTS rozliczenia;
ALTER SCHEMA rozliczenia RENAME TO ksiegowosc;

-- 3. Dodanie tabel
 
CREATE TABLE IF NOT EXISTS ksiegowosc.pracownicy (
   id_pracownika INT PRIMARY KEY, 
   imie VARCHAR(30) NOT NULL, 
   nazwisko VARCHAR(30) NOT NULL, 
   adres VARCHAR(50), 
   telefon VARCHAR(15));

CREATE TABLE IF NOT EXISTS ksiegowosc.godziny (
   id_godziny INT PRIMARY KEY, 
   "data" DATE, 
   liczba_godzin float, 
   id_pracownika INT);

CREATE TABLE IF NOT EXISTS ksiegowosc.pensja (
   id_pensji INT PRIMARY KEY, 
   stanowisko VARCHAR(30), 
   kwota float NOT NULL);

CREATE TABLE IF NOT EXISTS ksiegowosc.premia (
   id_premii INT PRIMARY KEY, 
   rodzaj VARCHAR(15), 
   kwota float NOT NULL);

CREATE TABLE IF NOT EXISTS ksiegowosc.wynagrodzenie (
	id_wynagrodzenia INT PRIMARY KEY,
	"data" DATE,
	id_pracownika INT REFERENCES ksiegowosc.pracownicy(id_pracownika),
	id_godziny INT REFERENCES ksiegowosc.godziny(id_godziny),
	id_pensji INT REFERENCES ksiegowosc.pensja(id_pensji),
	id_premii INT REFERENCES ksiegowosc.premia(id_premii));

-- 3.1 Modyfikacja - dodanie kluczy obcych

ALTER TABLE ksiegowosc.godziny 
ADD FOREIGN KEY (id_pracownika) REFERENCES ksiegowosc.pracownicy(id_pracownika);

-- 4. Komentarze do tabel

COMMENT ON TABLE ksiegowosc.pracownicy IS 'Dane osobowe pracowników';
COMMENT ON TABLE ksiegowosc.godziny IS 'Informacje na temat godzin pracy';
COMMENT ON TABLE ksiegowosc.pensja IS 'Wysokość pensji dla danych stanowisk';
COMMENT ON TABLE ksiegowosc.premia IS 'Wysokość premii';
COMMENT ON TABLE ksiegowosc.wynagrodzenie IS 'Dane dotyczące wynagrodzeń';

-- 5. Wypełnienie rekordami

INSERT INTO ksiegowosc.pracownicy VALUES 
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

INSERT INTO ksiegowosc.godziny VALUES 
(
	1, '2020-01-23', 168, 3
),
(
	2, '2020-01-30', 158, 6
),
(
	3, '2020-02-08', 167, 1
),
(
	4, '2020-02-11', 160, 5
),
(
	5, '2020-02-14', 160, 2
),
(
	6, '2020-02-20', 150, 4
),
(
	7, '2020-02-25', 155, 7
),
(
	8, '2020-02-26', 164, 8
),
(
	9, '2020-03-01', 164, 9
),
(
	10, '2020-03-11', 166, 10
);

INSERT INTO ksiegowosc.premia VALUES
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
	10, 'brak premii', 0
);

INSERT INTO ksiegowosc.pensja VALUES
(
	1, 'Księgowy', 4200
),
(
	2, 'Asystent', 900
),
(
	3, 'Dyrektor finansowy', 14100
),
(
	4, 'Sekretarka', 2900
),
(
	5, 'Projektant', 5400
),
(
	6, 'Informatyk', 5100
),
(
	7, 'Kierownik', 12300
),
(
	8, 'Przedstawiciel handlowy', 4300
),
(
	9, 'Kierowca', 2400
),
(
	10, 'Kierownik', 9400
);



INSERT INTO ksiegowosc.wynagrodzenie VALUES
(
	1, '2020-03-12', 1, 3, 10, 4
),
(
	2, '2020-03-13', 6, 2, 9, 2
),
(
	3, '2020-03-12', 2, 5, 8, 10 
),
(
	4, '2020-03-12', 3, 1, 7, 1
),
(
	5, '2020-03-13', 5, 4, 6, 4 
),
(
	6, '2020-03-12', 7, 7, 5, 6 
),
(
	7, '2020-03-13', 8, 8, 4, 3 
),
(
	8, '2020-03-12', 4, 6, 3, 6 
),
(
	9, '2020-03-12', 10, 10, 2, 8 
),
(
	10, '2020-03-13', 9, 9, 1, 10 
)

-- 6. Zapytania
-- a
SELECT id_pracownika, nazwisko FROM ksiegowosc.pracownicy

-- b
SELECT id_pracownika FROM ksiegowosc.wynagrodzenie JOIN ksiegowosc.pensja ON  ksiegowosc.wynagrodzenie.id_pensji = ksiegowosc.pensja.id_pensji WHERE ksiegowosc.pensja.kwota > 1000  

-- c
SELECT id_pracownika FROM ksiegowosc.wynagrodzenie WHERE id_premii IN
(SELECT id_premii FROM ksiegowosc.premia WHERE kwota = 0) AND id_pensji IN
(SELECT id_pensji FROM ksiegowosc.pensja WHERE kwota > 2000);

-- d
SELECT nazwisko, imie FROM ksiegowosc.pracownicy WHERE imie LIKE 'J%' 

-- e
SELECT nazwisko, imie FROM ksiegowosc.pracownicy WHERE nazwisko LIKE '%n%' AND imie LIKE '%a'

-- f
SELECT pracownicy.imie, pracownicy.nazwisko, (godziny.liczba_godzin-160) as "liczba nadgodzin" FROM ksiegowosc.pracownicy NATURAL JOIN ksiegowosc.godziny WHERE pracownicy.id_pracownika = godziny.id_pracownika AND godziny.liczba_godzin > 160

-- g
SELECT id_pracownika, imie, nazwisko FROM ksiegowosc.pracownicy WHERE id_pracownika IN 
(SELECT id_pracownika FROM ksiegowosc.wynagrodzenie JOIN ksiegowosc.pensja 
 ON  ksiegowosc.wynagrodzenie.id_pensji = ksiegowosc.pensja.id_pensji 
 WHERE ksiegowosc.pensja.kwota >= 1500 AND ksiegowosc.pensja.kwota <= 3000)

--h
SELECT imie, nazwisko, liczba_godzin, kwota FROM ksiegowosc.wynagrodzenie, ksiegowosc.godziny, ksiegowosc.pracownicy, ksiegowosc.premia 
WHERE wynagrodzenie.id_godziny = godziny.id_godziny AND wynagrodzenie.id_pracownika = pracownicy.id_pracownika AND wynagrodzenie.id_premii = premia.id_premii AND kwota = 0 AND liczba_godzin > 160

--i
SELECT pracownicy.imie, pracownicy.nazwisko, pensja.kwota FROM ksiegowosc.pracownicy NATURAL JOIN ksiegowosc.wynagrodzenie NATURAL JOIN ksiegowosc.pensja ORDER BY kwota

--j
SELECT wynagrodzenie.id_pracownika, premia.kwota, pensja.kwota FROM ksiegowosc.wynagrodzenie, ksiegowosc.pensja, ksiegowosc.premia WHERE wynagrodzenie.id_pensji = pensja.id_pensji AND wynagrodzenie.id_premii = premia.id_premii ORDER BY premia.kwota DESC, pensja.kwota DESC

--k
SELECT pensja.stanowisko, COUNT(wynagrodzenie.id_pracownika) as "liczba pracownikow" FROM ksiegowosc.wynagrodzenie NATURAL JOIN ksiegowosc.pensja WHERE wynagrodzenie.id_pensji = pensja.id_pensji GROUP BY pensja.stanowisko

--l
SELECT avg(kwota) as "srednia", min(kwota) as "min", max(kwota) as "max" FROM ksiegowosc.pensja WHERE stanowisko like 'Kierownik'

--m
SELECT sum(pensja.kwota + premia.kwota) as "suma wynagrodzen" FROM ksiegowosc.wynagrodzenie, ksiegowosc.pensja, ksiegowosc.premia WHERE wynagrodzenie.id_pensji = pensja.id_pensji AND wynagrodzenie.id_premii = premia.id_premii

--n
SELECT pensja.stanowisko, SUM(pensja.kwota + premia.kwota) as "suma wynagrodzen" FROM ksiegowosc.wynagrodzenie, ksiegowosc.pensja, ksiegowosc.premia WHERE wynagrodzenie.id_pensji = pensja.id_pensji AND wynagrodzenie.id_premii = premia.id_premii GROUP BY pensja.stanowisko

--o
SELECT pensja.stanowisko, COUNT(wynagrodzenie.id_premii) as "liczba premii" FROM ksiegowosc.wynagrodzenie, ksiegowosc.pensja, ksiegowosc.premia WHERE wynagrodzenie.id_pensji = pensja.id_pensji AND wynagrodzenie.id_premii = premia.id_premii GROUP BY pensja.stanowisko

--p
DELETE FROM ksiegowosc.godziny
WHERE id_pracownika IN
(SELECT wynagrodzenie.id_pracownika FROM ksiegowosc.wynagrodzenie 
	INNER JOIN ksiegowosc.pensja ON wynagrodzenie.id_pensji = pensja.id_pensji WHERE pensja.kwota < 1200);


DELETE FROM ksiegowosc.pracownicy
WHERE id_pracownika IN
(SELECT wynagrodzenie.id_pracownika FROM ksiegowosc.wynagrodzenie 
	INNER JOIN ksiegowosc.pensja ON wynagrodzenie.id_pensji = pensja.id_pensji WHERE pensja.kwota < 1200);


DELETE FROM ksiegowosc.wynagrodzenie
WHERE id_pensji IN
(SELECT pensja.id_pensji FROM ksiegowosc.pensja WHERE pensja.kwota < 1200);


