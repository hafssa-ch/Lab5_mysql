# Lab 5 – Agrégation, Groupements et Analyses

## Objectif
Apprendre à synthétiser et analyser des données dans MySQL en utilisant :  
- Fonctions d’agrégation (`COUNT`, `AVG`, `SUM`, `MAX`, `MIN`)  
- Clauses `GROUP BY` et `HAVING`  
- Sous-requêtes et CTE  
- Fonctions de fenêtre (`ROW_NUMBER`) pour produire des rapports exploitables  

## Base utilisée
**Tables** : `auteur`, `ouvrage`, `abonne`, `emprunt`  
**Schéma** :

AUTEUR(id, nom)

OUVRAGE(id, titre, disponible, auteur_id)

ABONNE(id, nom, email)

EMPRUNT(ouvrage_id, abonne_id, date_debut, date_fin)


## Contenu du lab
1. **Fonctions d’agrégation** : total d’abonnés, moyenne d’emprunts, prix moyen des ouvrages  
2. **GROUP BY / HAVING** : compter les emprunts par abonné et les ouvrages par auteur, filtrer les groupes  
3. **Jointures et agrégats combinés** : lier abonnés et auteurs avec leurs emprunts pour obtenir des synthèses  
4. **Analyses avancées** : pourcentage d’ouvrages empruntés, top abonnés et auteurs, moyenne par ouvrage  
5. **CTE et sous-requêtes** : calculs complexes et rapports mensuels  
6. **Optimisation** : index sur `emprunt(abonne_id)`, utilisation de `EXPLAIN`  
7. **Exercice final** : rapport mensuel d’activité 2025 incluant :
   - total emprunts  
   - abonnés actifs  
   - moyenne par abonné  
   - pourcentage d’ouvrages empruntés  
   - top 3 ouvrages par mois  

## Livrables
- Script SQL `lab5_aggregation.sql` : toutes les requêtes d’agrégation et analyses  
- Script SQL `lab5_exercice.sql` : rapport mensuel détaillé avec CTE et fonction de fenêtre  
- Captures d’écran   

