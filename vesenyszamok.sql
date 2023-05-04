PuskaHasznos linkekOnline tesztadatbázissuliPY
Összes almenü nyitása
1. Adatbázisok
2. SQL nyelv alapjai
3. Szoftverkörnyezet kialakítása
4. SQL nyelvről bővebben
5. Gyakorló feladatok érttségirebővül!
6. Érettségi feladatokbővül!
Mintafeladatsor
2022. október - Állóképesség
7. Python és SQL
CREATE, DROP és ALTER


Forrásfájlok letöltése
Az alábbi kódban az oszlopok megnevezése teljes elérési útvonallal szerepel. Ennek indoka a könyebb kódolvashatóság mellett az lehet, hogy a phpMyAdmin kódkiegészítője így az oszlopok nevének írásában is segít.

A másik alternatíva az alies-ek használata.

Érdemes kipróbálni ezeket a különböző opciókat, és annál maradni, amely számunkra a legkényelmesebb.

    -- 1. 1980 utáni, szegedi születésű, egyéni versenyzők névsora
    SELECT versenyzok.nev, versenyzok.szul_dat 
    FROM versenyzok 
    WHERE versenyzok.szul_hely = 'Szeged' AND versenyzok.egyen_csapat = 'e' 
      AND versenyzok.szul_dat >= '1981-01-01' 
    ORDER BY nev;
    
    -- 2. Vajda Attila eredményei, versenyszámonként, megjegyzésekkel
    SELECT versenyszamok.versenyszam, eredmenyek.helyezes, eredmenyek.megjegyzes 
    FROM versenyzok, eredmenyek, versenyszamok 
    WHERE versenyzok.azon = eredmenyek.versenyzo_azon 
        AND eredmenyek.versenyszam_azon = versenyszamok.azon 
        AND versenyzok.nev = 'Vajda Attila';
    
    -- 3. Első helyzést elért országok
    SELECT DISTINCT orszagok.orszag 
    FROM eredmenyek, versenyzok, orszagok 
    WHERE eredmenyek.helyezes = 1 AND eredmenyek.versenyzo_azon = versenyzok.azon 
      AND versenyzok.orszag_azon = orszagok.azon;
      
    -- 4. Cseh Lászlónál fiatalabb versenyzők adatai
    SELECT versenyzok.nev, versenyzok.szul_hely, versenyzok.szul_dat 
    FROM versenyzok 
    WHERE versenyzok.szul_dat > 
      (SELECT versenyzok.szul_dat FROM versenyzok WHERE versenyzok.nev='Cseh László');
    
    -- 5. Versenyzőket nem indító európai országok
    SELECT * FROM orszagok 
    WHERE orszagok.foldresz = 'Európa' 
      AND orszagok.azon NOT IN (SELECT versenyzok.orszag_azon FROM versenyzok);
    
    -- 6. Országok száma, összlakossága, átlagos területe földrészenként
    SELECT orszagok.foldresz, COUNT(*), SUM(orszagok.lakossag), AVG(orszagok.terulet) 
    FROM orszagok 
    WHERE orszagok.foldresz IS NOT NULL 
    GROUP BY orszagok.foldresz;
    
    -- 7. A legfiatalabb versenyzőt indító ország
    SELECT orszagok.orszag 
    FROM orszagok, versenyzok  
    WHERE orszagok.azon = versenyzok.orszag_azon 
      AND versenyzok.szul_dat = (SELECT MAX(versenyzok.szul_dat) FROM versenyzok);
    
    -- 8. Az országok által elért pontszámok az új pont_tabla táblába
    CREATE TABLE pont_tabla 
    SELECT orszagok.orszag, erem_tabla.arany*3+erem_tabla.ezust*2+erem_tabla.bronz AS pont 
    FROM orszagok, erem_tabla 
    WHERE orszagok.azon = erem_tabla.orszag_azon 
    HAVING pont >= 20;
    
    -- 9. A magyar női kézilabda csapat névsora életkor szerint növekvő sorrendben
    SELECT versenyzok.nev FROM versenyzok WHERE versenyzok.azon IN (
	    SELECT csapattagok.versenyzo_azon FROM csapattagok
        WHERE csapattagok.csapat_azon = (
            SELECT versenyzok.azon FROM versenyzok, orszagok
            WHERE versenyzok.orszag_azon = orszagok.azon 
                AND versenyzok.nev = 'Kézilabda női' AND orszagok.orszag = 'Magyarország'
        )
    ) ORDER BY versenyzok.szul_dat DESC;
    
    -- 10. A csapatok szul_hely mezőjének feltöltése az indító ország fővárosával
    UPDATE versenyzok 
    SET szul_hely = (
        SELECT orszagok.fovaros FROM orszagok 
        WHERE orszagok.azon = versenyzok.orszag_azon) 
    WHERE versenyzok.egyen_csapat = 'c';    
  
Impresszum
Bemutatkozás
Napló
Tanároknak
Adatkezelési tájékoztató
Copyright © 2022 | Minden jog fenntartva!