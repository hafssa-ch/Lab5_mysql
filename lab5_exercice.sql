
WITH emprunts_2025 AS (
    SELECT 
        e.ouvrage_id,
        e.abonne_id,
        YEAR(e.date_debut) AS annee,
        MONTH(e.date_debut) AS mois
    FROM emprunt e
    WHERE YEAR(e.date_debut) = 2025
),



indicateurs_base AS (
    SELECT
        annee,
        mois,
        COUNT(*) AS total_emprunts,
        COUNT(DISTINCT abonne_id) AS abonnes_actifs,
        ROUND(COUNT(*) / COUNT(DISTINCT abonne_id), 2) AS moyenne_par_abonne
    FROM emprunts_2025
    GROUP BY annee, mois
),


emprunts_par_ouvrage AS (
    SELECT
        annee,
        mois,
        ouvrage_id,
        COUNT(*) AS nb_emprunts
    FROM emprunts_2025
    GROUP BY annee, mois, ouvrage_id
),


top_ouvrages AS (
    SELECT
        epo.annee,
        epo.mois,
        o.titre,
        epo.nb_emprunts,
        ROW_NUMBER() OVER (PARTITION BY epo.annee, epo.mois ORDER BY epo.nb_emprunts DESC) AS rang
    FROM emprunts_par_ouvrage epo
    JOIN ouvrage o ON o.id = epo.ouvrage_id
),

top3_ouvrages AS (
    SELECT
        annee,
        mois,
        GROUP_CONCAT(titre ORDER BY rang ASC SEPARATOR ', ') AS top_3_titres
    FROM top_ouvrages
    WHERE rang <= 3
    GROUP BY annee, mois
),


pct_ouvrages AS (
    SELECT
        e.annee,
        e.mois,
        ROUND(COUNT(DISTINCT e.ouvrage_id) * 100 / (SELECT COUNT(*) FROM ouvrage), 2) AS pct_empruntes
    FROM emprunts_2025 e
    GROUP BY e.annee, e.mois
)

SELECT 
    ib.annee,
    ib.mois,
    COALESCE(ib.total_emprunts, 0) AS total_emprunts,
    COALESCE(ib.abonnes_actifs, 0) AS abonnes_actifs,
    COALESCE(ib.moyenne_par_abonne, 0) AS moyenne_par_abonne,
    COALESCE(po.pct_empruntes, 0) AS pct_empruntes,
    COALESCE(t3.top_3_titres, 'Aucun emprunt') AS top_3_ouvrages
FROM indicateurs_base ib
LEFT JOIN pct_ouvrages po ON po.annee = ib.annee AND po.mois = ib.mois
LEFT JOIN top3_ouvrages t3 ON t3.annee = ib.annee AND t3.mois = ib.mois
ORDER BY ib.annee, ib.mois;
