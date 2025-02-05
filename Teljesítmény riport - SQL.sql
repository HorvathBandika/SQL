-- CCP CP - Dolgozos fül

SELECT 
    [Operátor Split], 
    [Logikai kód], 
    [Operátor név], 
    FORMAT(CONVERT(DATE, Időpont), 'yyyy.MM.dd') AS Dátum, 
    [Időpont], 
    [CP_kód], 
    [CP_név], 
    [Időtartam],
    dbo.tct_statuszok_seged.Típus AS Besorolás
FROM dbo.tct_statuszok
JOIN dbo.tct_statuszok_seged
    ON tct_statuszok.[CP név] = [dbo].[tct_statuszok_seged].CP_név
WHERE [Operátor Split] IN (
    'D_CC_Pécs_BB',
    'D_CC_Pécs_Cs01',
    'D_CC_Pécs_EKA',
    'D_CC_Pécs_FK',
    'D_CC_Pécs_GA',
    'D_CC_Pécs_KP',
    'D_CC_Pécs_VB',
    'D_CC_Szeg_ÉDDSO',
    'D_CC_Szeged_BZS',
    'D_CC_Szeged_DM',
    'D_CC_Szeged_GB',
    'D_CC_Szeged_HFG',
    'D_CC_Szeged_TKA',
    'D_CC_Szeged_VSE',
    'K_CC_Db_BR',
    'K_CC_Db_CF',
    'K_CC_Db_CSJO',
    'K_CC_Db_JB',
    'K_CC_Db_KCS',
    'K_CC_Db_KEM',
    'K_CC_Db_KTCS',
    'K_CC_Db_NE',
    'K_CC_Db_SZL',
    'K_CC_MC_AP',
    'K_CC_MC_GL',
    'K_CC_MC_KG',
    'K_CC_MC_KM',
    'K_CC_MC_MH',
    'K_CC_MC_ÖDCS',
    'K_CC_MC_VM',
    'K_CC_Db_KNN'
)
AND FORMAT(CONVERT(DATE, Időpont), 'yyyy.MM.dd') = '2024.11.07'
AND dbo.tct_statuszok_seged.Típus IN ('Produktív', 'Improduktív', 'Technikai')
AND CP_név LIKE '%/GSZ%'
ORDER BY [Operátor Split] ASC, [Operátor név] ASC;

-----------------------------------------------------------------------------------

-- CCP CP - Produktív - Inproduktív fül

SELECT 
    [Logikai kód],
    
    -- GSZ produktív idő összegzése
    FORMAT(DATEADD(SECOND, SUM(CASE 
            WHEN [CP név] IN (
                'Bejelentkezés/GSZ Hívásfogadás',
                'Bejelentkezés/GSZ Háttértevékenység/GSZ SM feldolgozás',
                'Bejelentkezés/GSZ Személyes ügyfélszolg/GSZ Általános ügyintézés',
                'Bejelentkezés/GSZ Háttértevékenység/GSZ Túlóra',
                'Bejelentkezés/GSZ Háttértevékenység/GSZ ÉD DSO',
                'Bejelentkezés/GSZ Utómunka',
                'Bejelentkezés/GSZ Háttértevékenység/GSZ Iktatás',
                'Bejelentkezés/GSZ Háttértevékenység/GSZ Excel tábla feldolg',
                'Bejelentkezés/GSZ Videochat',
                'Bejelentkezés/GSZ Háttértevékenység/GSZ Non-core termékek',
                'Bejelentkezés/GSZ Kimenő hívás/GSZ Ügyfél',
                'Bejelentkezés/GSZ Hulladékgazdálkodás',
                'Bejelentkezés/GSZ Kereskedőváltás-DF',
                'Bejelentkezés/GSZ Kommentkezelés',
                'Bejelentkezés/GSZ Hívásfogadás_Túlóra',
                'Bejelentkezés/GSZ Személyes ügyfélszolg/GSZ Pénztár',
                'Bejelentkezés/GSZ Hívásfogadás-Hibacím',
                'Bejelentkezés/GSZ Kimenő hívás/GSZ Kényelmi szolg',
                'Bejelentkezés/GSZ Kimenő hívás/GSZ Termék',
                'Bejelentkezés/GSZ Háttértevékenység/GSZ Videochat',
                'Kijelentkezés/A GSZ Hivatalos/A GSZ Megbeszélés',
                'Kijelentkezés/GSZ Hivatalos/GSZ Megbeszélés'
            ) THEN DATEDIFF(SECOND, 0, TRY_CAST([Időtartam] AS TIME))
            ELSE 0
        END), 0), 'HH:mm:ss') AS [GSZ produktív],

    -- GSZ inproduktív idő összegzése
    FORMAT(DATEADD(SECOND, SUM(CASE 
            WHEN [CP név] IN (
                'Kijelentkezés/GSZ Hivatalos/GSZ Logon',
                'Kijelentkezés/GSZ Külső munka szakmai',
                'Kijelentkezés/GSZ Hivatalos/GSZ Oktatás/GSZ Önoktatás',
                'Kijelentkezés/GSZ Hivatalos/GSZ Megbeszélés/GSZ Határozatlan',
                'Kijelentkezés/GSZ Hivatalos/GSZ Oktatás/GSZ Tréning',
                'Kijelentkezés/GSZ Kereskedőváltás',
                'Kijelentkezés/GSZ ÉD ügyintézés',
                'Kijelentkezés/GSZ Hivatalos/GSZ Megbeszélés/GSZ 10 perc',
                'Kijelentkezés/GSZ Háttértev-Áram',
                'Kijelentkezés/GSZ MVMI HelpDesk',
                'Kijelentkezés/GSZ Hivatalos/GSZ Megbeszélés/GSZ 30 perc',
                'Kijelentkezés/GSZ Segítő munkatárs',
                'Kijelentkezés/GSZ Hivatalos/GSZ Oktatás/GSZ Hulladékgazd oktatás',
                'Kijelentkezés/GSZ Külső munka egyéb',
                'Kijelentkezés/GSZ Pihenö/Rekreáció',
                'Kijelentkezés/GSZ ELO ügyintézés',
                'Kijelentkezés/GSZ Betanulás'
            ) THEN DATEDIFF(SECOND, 0, TRY_CAST([Időtartam] AS TIME))
            ELSE 0
        END), 0), 'HH:mm:ss') AS [GSZ inproduktív],

    -- GSZ szünet idő összegzése
    FORMAT(DATEADD(SECOND, SUM(CASE 
            WHEN [CP név] IN (
                'Kijelentkezés/GSZ Pihenö/10 perc',
                'Kijelentkezés/GSZ Pihenö/10 perc-Túlóra',
                'Kijelentkezés/GSZ Étkezés',
                'Kijelentkezés/GSZ Étkezés-Túlóra',
                'Kijelentkezés/GSZ Pihenö/25 perc-Túlóra',
                'Kijelentkezés/GSZ Pihenö/25 perc',
                'Kijelentkezés/GSZ Pihenö/15 perc-Túlóra',
                'Kijelentkezés/GSZ Pihenö/15 perc',
                'Kijelentkezés/GSZ Hostess munka'
            ) THEN DATEDIFF(SECOND, 0, TRY_CAST([Időtartam] AS TIME))
            ELSE 0
        END), 0), 'HH:mm:ss') AS [GSZ szünet]

FROM [dbo].[tct_statuszok]
WHERE [Operátor Split] IN (
    'D_CC_Pécs_BB',
    'D_CC_Pécs_Cs01',
    'D_CC_Pécs_EKA',
    'D_CC_Pécs_FK',
    'D_CC_Pécs_GA',
    'D_CC_Pécs_KP',
    'D_CC_Pécs_VB',
    'D_CC_Szeg_ÉDDSO',
    'D_CC_Szeged_BZS',
    'D_CC_Szeged_DM',
    'D_CC_Szeged_GB',
    'D_CC_Szeged_HFG',
    'D_CC_Szeged_TKA',
    'D_CC_Szeged_VSE',
    'K_CC_Db_BR',
    'K_CC_Db_CF',
    'K_CC_Db_CSJO',
    'K_CC_Db_JB',
    'K_CC_Db_KCS',
    'K_CC_Db_KEM',
    'K_CC_Db_KTCS',
    'K_CC_Db_NE',
    'K_CC_Db_SZL',
    'K_CC_MC_AP',
    'K_CC_MC_GL',
    'K_CC_MC_KG',
    'K_CC_MC_KM',
    'K_CC_MC_MH',
    'K_CC_MC_ÖDCS',
    'K_CC_MC_VM',
    'K_CC_Db_KNN'
)
AND FORMAT(CONVERT(DATE, Időpont), 'yyyy.MM.dd') = '2024.11.07'
GROUP BY [Logikai kód]
ORDER BY [Logikai kód]



--------------------------------------------------------------------
-- ACD fogadott - összegzés fül 

SELECT 
    Operator_kod,
    
    -- [Beszedido] darabszáma
    COUNT([Beszedido]) AS Mennyiség_Beszedido,

    -- [Beszedido] összideje
    RIGHT('00' + CAST(SUM(DATEDIFF(SECOND, '00:00:00', TRY_CAST([Beszedido] AS TIME))) / 3600 AS VARCHAR), 2) + ':' + 
    RIGHT('00' + CAST((SUM(DATEDIFF(SECOND, '00:00:00', TRY_CAST([Beszedido] AS TIME))) % 3600) / 60 AS VARCHAR), 2) + ':' + 
    RIGHT('00' + CAST(SUM(DATEDIFF(SECOND, '00:00:00', TRY_CAST([Beszedido] AS TIME))) % 60 AS VARCHAR), 2) AS Összeg_Beszedido,

       -- [Beszedido] átlaga
    RIGHT('00' + CAST(AVG(DATEDIFF(SECOND, '00:00:00', TRY_CAST([Beszedido] AS TIME))) / 3600 AS VARCHAR), 2) + ':' + 
    RIGHT('00' + CAST((AVG(DATEDIFF(SECOND, '00:00:00', TRY_CAST([Beszedido] AS TIME))) % 3600) / 60 AS VARCHAR), 2) + ':' + 
    RIGHT('00' + CAST(AVG(DATEDIFF(SECOND, '00:00:00', TRY_CAST([Beszedido] AS TIME))) % 60 AS VARCHAR), 2) AS Atlag_Beszedido,

	-- [Utomunka_ido] összideje
    RIGHT('00' + CAST(SUM(DATEDIFF(SECOND, '00:00:00', TRY_CAST([Utomunka_ido] AS TIME))) / 3600 AS VARCHAR), 2) + ':' + 
    RIGHT('00' + CAST((SUM(DATEDIFF(SECOND, '00:00:00', TRY_CAST([Utomunka_ido] AS TIME))) % 3600) / 60 AS VARCHAR), 2) + ':' + 
    RIGHT('00' + CAST(SUM(DATEDIFF(SECOND, '00:00:00', TRY_CAST([Utomunka_ido] AS TIME))) % 60 AS VARCHAR), 2) AS Utomunka_ido_Osszido

	FROM [dbo].[tct_acd_fogadott]
WHERE [Operator_split] IN (
    'D_CC_Pécs_BB',
    'D_CC_Pécs_Cs01',
    'D_CC_Pécs_EKA',
    'D_CC_Pécs_FK',
    'D_CC_Pécs_GA',
    'D_CC_Pécs_KP',
    'D_CC_Pécs_VB',
    'D_CC_Szeg_ÉDDSO',
    'D_CC_Szeged_BZS',
    'D_CC_Szeged_DM',
    'D_CC_Szeged_GB',
    'D_CC_Szeged_HFG',
    'D_CC_Szeged_TKA',
    'D_CC_Szeged_VSE',
    'K_CC_Db_BR',
    'K_CC_Db_CF',
    'K_CC_Db_CSJO',
    'K_CC_Db_JB',
    'K_CC_Db_KCS',
    'K_CC_Db_KEM',
    'K_CC_Db_KTCS',
    'K_CC_Db_NE',
    'K_CC_Db_SZL',
    'K_CC_MC_AP',
    'K_CC_MC_GL',
    'K_CC_MC_KG',
    'K_CC_MC_KM',
    'K_CC_MC_MH',
    'K_CC_MC_ÖDCS',
    'K_CC_MC_VM',
    'K_CC_Db_KNN'
)
AND FORMAT(CONVERT(DATE, [IVR_ba_lepes_idopontja]), 'yyyy.MM.dd') = '2024.11.07'
GROUP BY [Operator_kod]
ORDER BY [Operator_kod];