-- a
UPDATE ksiegowosc.pracownicy
SET telefon = '(+48)' || telefon;

SELECT telefon FROM ksiegowosc.pracownicy

-- b 
UPDATE ksiegowosc.pracownicy
SET telefon = SUBSTRING(telefon, 1, 8) || '-' || SUBSTRING(telefon, 9, 3) || '-' || SUBSTRING(telefon, 12, 3);

SELECT telefon FROM ksiegowosc.pracownicy

-- c
SELECT * FROM ksiegowosc.pracownicy
SELECT UPPER(imie) as "IMIE", UPPER(nazwisko) as "NAZWISKO" FROM ksiegowosc.pracownicy 
WHERE length(nazwisko) = (SELECT max(length(nazwisko)) FROM ksiegowosc.pracownicy);

-- d

SELECT MD5(imie) as "imie", MD5(nazwisko) as "nazwisko", MD5(kwota::varchar(20)) as "kwota" FROM ksiegowosc.pracownicy JOIN 
ksiegowosc.wynagrodzenie ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika JOIN 
ksiegowosc.pensja ON pensja.id_pensji = wynagrodzenie.id_pensji

-- f
SELECT pracownicy.id_pracownika, imie, nazwisko, pensja.kwota as "pensja", premia.kwota as "premia" 
FROM ksiegowosc.pracownicy LEFT JOIN 
ksiegowosc.wynagrodzenie ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika LEFT JOIN 
ksiegowosc.pensja ON pensja.id_pensji = wynagrodzenie.id_pensji LEFT JOIN
ksiegowosc.premia ON premia.id_premii = wynagrodzenie.id_premii;

-- g
SELECT CONCAT('Pracownik ', imie, ' ', nazwisko, ', w dniu ', wynagrodzenie.data,
			  ' otrzymał(a) pensję całkowitą na kwotę ', 
			  CASE WHEN (godziny.liczba_godzin - 160)>=0 THEN (pensja.kwota + premia.kwota + (godziny.liczba_godzin - 160)*100) ELSE (pensja.kwota + premia.kwota) END,
			  ', gdzie wynagrodzenie zasadnicze wynosiło: ', pensja.kwota, ' zł, premia: ', premia.kwota, 
			  ' zł, nadgodziny: ', CASE WHEN (godziny.liczba_godzin - 160)>=0 THEN (godziny.liczba_godzin - 160)*100 ELSE 0 END) as "raport" 
FROM ksiegowosc.pracownicy JOIN
ksiegowosc.wynagrodzenie ON pracownicy.id_pracownika = wynagrodzenie.id_pracownika JOIN
ksiegowosc.pensja ON wynagrodzenie.id_pensji = pensja.id_pensji JOIN
ksiegowosc.premia ON wynagrodzenie.id_premii = premia.id_premii JOIN
ksiegowosc.godziny ON godziny.id_pracownika = pracownicy.id_pracownika;



