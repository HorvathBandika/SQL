-- 2. feladat Készítsen lekérdezést, amely megadja a „Vas” megyei tanulók számát!
SELECT megye.letszam
FROM megye
WHERE megye.nev='Vas';

-- 3. feladat Készítsen lekérdezést, amely megadja, hogy „Somogy” megyében hány tanuló vett részt a felmérésben!
SELECT sum(aerob.letszam)
FROM aerob, megye
WHERE aerob.mkod=megye.kod AND megye.nev='Somogy';

-- 4. feladat Készítsen lekérdezést, amely megadja, hogy összesen hány fiú tanuló kapott egészséges besorolást „Zala” megyéből!
SELECT aerob.letszam
FROM aerob, megye, allapot
WHERE aerob.mkod=megye.kod AND aerob.allkod=allapot.kod 
  AND megye.nev='Zala' AND aerob.nem=1 
  AND allapot.nev='egészséges';

-- 5. feladat Lekérdezés segítségével adja meg, hogy hány megyében van kevesebb tanuló, mint „Heves” megyében!  
SELECT count(megye.nev) 
FROM megye
WHERE megye.letszam<(
	SELECT megye.letszam 
	FROM megye 
	WHERE megye.nev="Heves");

-- 6. feladat Lekérdezés segítségével adja meg, hogy „Pest” megyében a tanulók hányadrésze vett részt a felmérésben! 
SELECT sum(aerob.letszam)/megye.letszam
FROM aerob, megye
WHERE aerob.mkod=megye.kod AND megye.nev='Pest';

-- 7. feladat Adja meg lekérdezés segítségével, hogy melyik megyében hány „egészséges” besorolást kapott lány tanuló van! A lekérdezés a megye nevét és az egészséges tanulók számát adja meg ez utóbbi szerint csökkenő sorrendben!
SELECT megye.nev, aerob.letszam
FROM aerob, megye, allapot
WHERE aerob.mkod=megye.kod 
	AND nem=0 AND allkod=allapot.kod AND allapot.nev='egészséges'
ORDER BY aerob.letszam DESC;

-- 8. feladat Készítsen lekérdezést, amely megadja, hogy melyik megyében volt a legnagyobb a felmérésben részt vevő tanulók aránya! A megye nevét és az arányt jelenítse meg!
SELECT megye.nev, SUM(aerob.letszam)/megye.letszam
FROM megye, aerob
WHERE aerob.mkod=megye.kod
GROUP BY megye.nev
ORDER BY 2 DESC
LIMIT 1;

-- 9. feladat Lekérdezés segítségével adja meg, hogy mely megyékben bizonyult valamilyen mértékben fejlesztendőnek az ott tanuló diákok több mint negyede! A lekérdezés jelenítse meg a keresett megyéket, valamint a megyénként fejlesztést igénylő tanulók és a megyei összes tanulók arányát! A mezőket nevezze el a mintának megfelelően!
SELECT megye.nev AS Megyenév, sum(aerob.letszam)/megye.letszam AS Arány
FROM megye, aerob, allapot  
WHERE aerob.mkod=megye.kod AND aerob.allkod=allapot.kod
AND allapot.nev LIKE '%fejlesztés%'
GROUP BY aerob.mkod
HAVING Arány>0.25;
