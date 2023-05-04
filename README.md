Digitális kultúra 
emelt szint 
 
Állóképesség 
A 10 éves és annál idősebb tanulók állóképességét 2014/15-ös tanévtől kezdve 
rendszeresen mérik az iskolákban. Az állóképességi ingafutás során az általános és 
középiskolás diákoknak egy adott távolságot kell egyre rövidülő időközök alatt egymás után 
lefutniuk. A futás eredménye alapján a tanulók aerob fittség, azaz állóképesség szempontjától 
az alábbi kategóriák egyikébe kerülnek: 
− egészséges (állóképessége megfelelő); 
− fejlesztést igényel (állóképessége nem megfelelő); 
− fokozott fejlesztést igényel (állóképessége gyenge). 
A felmérésben Magyarország 19 megyéjéből és Budapestről származnak adatok, a fővárost 
a feladatban önálló megyének tekintjük. Az adatbázisban a 2016/17-es tanév során vizsgált 
állóképességek megyei eredményei szerepelnek állapot és nem szerinti bontásban. 
A felmérésben nem minden tanuló vett részt. 
Táblák: 
megye (kod, nev, letszam) 
kod A megye azonosítója (szám), ez az elsődleges kulcs 
nev A megye neve (szöveg) 
letszam A megyében tanuló diákok száma (szám) 
allapot (kod, nev) 
kod A tanulói állapot kódja (egész szám), ez az elsődleges kulcs
nev A tanulói állapot megnevezése (szöveg)
aerob (azon, mkod, nem, allkod, letszam) 
azon Az eredmény azonosítója (szám), ez az elsődleges kulcs 
mkod A megye kódja (szám), idegen kulcs, megadja, hogy melyik megyéből 
származik az eredmény 
nem A felmérésében szereplő tanulók neme (egész), 
fiúk esetén 1, lányok esetén 0 
allkod A felmérés eredményeként kapott állapot kódja (egész szám), idegen kulcs 
letszam A felmérés során az adott nemű, adott állapotba sorolt tanulók létszáma 
(egész szám) 
Az aerob tábla egy rekordja például a (35, 6, 1, 2, 1507), ami azt jelenti, hogy a 35-ös 
azonosítóval rendelkező rekord szerint a 6-os kódú megyében, a fiúk (1) felmérése alapján 
fejlesztést igényel (2) a felmérés szerint 1507 tanuló. A megye tábla alapján a 6-os kód Somogy 
megyét jelenti, tehát a rekord adatai innen származnak. 
 
A következő feladatokat megoldó SQL-parancsokat rögzítse a feladatok végén zárójelben 
megadott nevű és .sql kiterjesztésű szöveges állományban! Például a 3. feladat megoldását 
a 3somogy.sql nevű állományban. A javítás során csak ezeknek az állománynak a tartalma 
lesz értékelve! Ügyeljen arra, hogy a lekérdezésekben pontosan a kívánt mezők szerepeljenek, 
felesleges mezőt ne jelenítsen meg! 
1. Az allokep_forras.sql állomány tartalmazza az adatbázist és a táblákat létrehozó, 
valamint az adatokat a táblába beszúró SQL-parancsokat! Futtassa az SQL-szerveren 
az allokep_forras.sql parancsfájlt! (A „Nincs kiválasztott adatbázis” üzenet nem 
befolyásolja az adatimportálás sikerességét.) 
2. Készítsen lekérdezést, amely megadja a „Vas” megyei tanulók számát! (2vas) 
3. Készítsen lekérdezést, amely megadja, hogy „Somogy” megyében hány tanuló vett részt 
a felmérésben! (3somogy) 
4. Készítsen lekérdezést, amely megadja, hogy összesen hány fiú tanuló kapott egészséges 
besorolást „Zala” megyéből! (4zala) 
5. Lekérdezés segítségével adja meg, hogy hány megyében van kevesebb tanuló, mint 
„Heves” megyében! (5heves) 
6. Lekérdezés segítségével adja meg, hogy „Pest” megyében a tanulók hányadrésze vett részt 
a felmérésben! (6pest) 
7. Adja meg lekérdezés segítségével, hogy melyik megyében hány „egészséges” besorolást 
kapott lány tanuló van! A lekérdezés a megye nevét és az egészséges tanulók számát adja 
meg ez utóbbi szerint csökkenő sorrendben! (7egesz) 
8. Készítsen lekérdezést, amely megadja, hogy melyik megyében volt a legnagyobb 
a felmérésben részt vevő tanulók aránya! A megye nevét és az arányt jelenítse meg! 
(8arany) 
9. Lekérdezés segítségével adja meg, hogy mely megyékben bizonyult valamilyen mértékben 
fejlesztendőnek az ott tanuló diákok több mint negyede! A lekérdezés jelenítse meg 
a keresett megyéket, valamint a megyénként fejlesztést igénylő tanulók és a megyei összes 
tanulók arányát! A mezőket nevezze el a mintának megfelelően! (9negyed) 
