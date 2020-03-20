# 1. Quels sont les tickets qui comportent l’article d’ID 500, afficher le numéro de ticket uniquement ?

SELECT ventes.NUMERO_TICKET 
FROM ventes 
WHERE ventes.ID_ARTICLE = 500;

# 2. Afficher les tickets du 15/01/2014.

SELECT * 
FROM beer.ticket
WHERE DATE_VENTE LIKE ("2014-01-15%");

# 3. Afficher les tickets émis du 15/01/2014 et le 17/01/2014.

SELECT * 
FROM beer.ticket
WHERE DATE_VENTE IN("2014-01-15 00:00:00","2014-01-18 00:00:00");

SELECT * 
FROM beer.ticket
WHERE DATE_VENTE ="2014-01-15 00:00:00" OR "2014-01-18 00:00:00";

# 4. Editer la liste des articles apparaissant à 50 et plus exemplaires sur un ticket.

SELECT *
FROM article 
INNER JOIN ventes ON ventes.ID_ARTICLE = article.ID_ARTICLE 
WHERE ventes.QUANTITE > 50;

# 5. Quelles sont les tickets émis au mois de mars 2014.

SELECT * 
FROM ticket
WHERE DATE_VENTE LIKE "2014-03-%";

# 6. Quelles sont les tickets émis entre les mois de mars et avril 2014 ?

SELECT * 
FROM ticket
WHERE DATE_VENTE BETWEEN "2014-03-01 00:00:00" AND "2014-05-01 00:00:00";

# 7. Quelles sont les tickets émis au mois de mars et juin 2014 ?

SELECT *
FROM ticket 
WHERE DATE_VENTE LIKE "2014-03-%" OR DATE_VENTE LIKE "2014-06-%";

# 8. Afficher la liste des bières classée par couleur. (Afficher l’id et le nom)

SELECT DISTINCT article.ID_ARTICLE, article.NOM_ARTICLE
FROM article
INNER JOIN couleur ON article.ID_Couleur = couleur.ID_Couleur
ORDER BY NOM_COULEUR;

# 9. Afficher la liste des bières n’ayant pas de couleur. (Afficher l’id et le nom)

SELECT article.ID_ARTICLE, article.NOM_ARTICLE
FROM article
WHERE article.ID_Couleur IS NULL;

# 10. Lister pour chaque ticket la quantité totale d’articles vendus. (Classer par quantité décroissante)

SELECT ventes.NUMERO_TICKET, SUM(ventes.QUANTITE)
FROM ventes 
GROUP BY ventes.NUMERO_TICKET
ORDER BY SUM(ventes.QUANTITE) DESC;

# 11.Lister chaque ticket pour lequel la quantité totale d’articles vendus est supérieure à 500. (Classer par quantité décroissante)

SELECT ventes.NUMERO_TICKET, SUM(ventes.QUANTITE) AS total
FROM ventes
GROUP BY ventes.NUMERO_TICKET
HAVING total > 500
ORDER BY SUM(ventes.QUANTITE) DESC;

# 12. Lister chaque ticket pour lequel la quantité totale d’articles vendus est supérieure à 500. 
# On exclura du total, les ventes ayant une quantité supérieure à 50 (classer par quantité décroissante)

SELECT ventes.NUMERO_TICKET, SUM(ventes.QUANTITE) AS total
FROM ventes
WHERE ventes.QUANTITE < 50
GROUP BY ventes.NUMERO_TICKET
HAVING total > 500
ORDER BY SUM(ventes.QUANTITE) DESC;

# 13. Lister les bières de type ‘Trappiste’. (id, nom de la bière, volume et titrage)

SELECT DISTINCT article.ID_ARTICLE, article.NOM_ARTICLE, article.VOLUME, article.TITRAGE
FROM article
INNER JOIN type ON type.ID_TYPE = article.ID_TYPE
WHERE type.NOM_TYPE = "Trappiste";

# 14. Lister les marques de bières du continent ‘Afrique’

SELECT marque.NOM_MARQUE
FROM marque
INNER JOIN pays ON pays.ID_PAYS = marque.ID_PAYS
INNER JOIN continent ON continent.ID_CONTINENT = pays.ID_CONTINENT
WHERE continent.NOM_CONTINENT = "Afrique";

# 15. Lister les bières du continent ‘Afrique’

SELECT article.NOM_ARTICLE
FROM article
INNER JOIN marque ON article.ID_MARQUE = marque.ID_MARQUE
INNER JOIN pays ON pays.ID_PAYS = marque.ID_PAYS
INNER JOIN continent ON continent.ID_CONTINENT = pays.ID_CONTINENT
WHERE continent.NOM_CONTINENT = "Afrique";

# 16. Lister les tickets (année, numéro de ticket, montant total payé). 
# En sachant que le prix de vente est égal au prix d’achat augmenté de 15% et que l’on n’est pas assujetti à la TVA.

SELECT ventes.ANNEE, ventes.NUMERO_TICKET, ROUND(SUM(article.PRIX_ACHAT*1.15),2) AS "Prix de vente"
FROM ventes 
INNER JOIN article ON ventes.ID_ARTICLE = article.ID_ARTICLE
GROUP BY  ventes.ANNEE, ventes.NUMERO_TICKET;

# 17. Donner le C.A. par année.

SELECT ventes.ANNEE, ROUND(SUM(article.PRIX_ACHAT*ventes.QUANTITE),2) AS CA
FROM ventes
INNER JOIN article ON ventes.ID_ARTICLE = article.ID_ARTICLE
GROUP BY ventes.ANNEE;

# 18. Lister les quantités vendues de chaque article pour l’année 2016.

SELECT article.ID_ARTICLE, article.NOM_ARTICLE, SUM(ventes.QUANTITE)
FROM ventes
INNER JOIN article ON ventes.ID_ARTICLE = article.ID_ARTICLE
WHERE ventes.ANNEE = "2016"
GROUP BY article.NOM_ARTICLE;

# 19. Lister les quantités vendues de chaque article pour les années 2014,2015 ,2016.

SELECT ventes.ANNEE, article.NOM_ARTICLE, SUM(ventes.QUANTITE) AS "Quantité vendue"
FROM ventes
INNER JOIN article ON ventes.ID_ARTICLE = article.ID_ARTICLE
WHERE ventes.ANNEE IN("2016","2014","2015")
GROUP BY article.NOM_ARTICLE, ventes.ANNEE;

# 20. Lister les articles qui n’ont fait l’objet d’aucune vente en 2014.

SELECT article.ID_ARTICLE, article.NOM_ARTICLE 
FROM article 
WHERE id_article not in (
						SELECT ventes.id_article 
						FROM ventes 
						WHERE annee = 2014);  
                        
# 21. Coder de 3 manières différentes la requête suivante : Lister les pays qui fabriquent des bières de type ‘Trappiste’

SELECT DISTINCT pays.NOM_PAYS 
FROM pays 
INNER JOIN marque ON pays.ID_PAYS = marque.ID_PAYS 
INNER JOIN article ON marque.ID_MARQUE = article.ID_MARQUE 
INNER JOIN type ON article.ID_TYPE = type.ID_TYPE where type.NOM_TYPE = 'Trappiste';

#SELECT DISTINCT pays.NOM_PAYS 
#FROM pays 
#INNER JOIN marque ON pays.ID_PAYS = marque.ID_PAYS

#Je reviens dessus après

# 22. Lister les tickets sur lesquels apparaissent un des articles apparaissant aussi sur le ticket 2014-856 (le ticket 856 de l’année 2014)

SELECT ventes.NUMERO_TICKET
FROM ventes
WHERE ventes.ID_ARTICLE IN (
							SELECT ventes.ID_ARTICLE
							FROM ventes
                            INNER JOIN article ON article.ID_ARTICLE = ventes.ID_ARTICLE
                            WHERE ventes.NUMERO_TICKET=856 AND ventes.ANNEE ="2014");
# 23. Lister les articles ayant un degré d’alcool plus élevé que la plus forte des trappistes

SELECT article.NOM_ARTICLE
FROM article 
WHERE article.TITRAGE > (
						SELECT MAX(article.TITRAGE)
						FROM article
						INNER JOIN type ON article.ID_TYPE = type.ID_TYPE
						WHERE type.NOM_TYPE = "Trappiste");
                        
# 24. Editer les quantités vendues pour chaque couleur en 2014

SELECT couleur.NOM_COULEUR AS "Couleur", SUM(ventes.QUANTITE) AS "Quantité vendue"
FROM ventes
INNER JOIN article ON ventes.ID_ARTICLE = article.ID_ARTICLE
INNER JOIN couleur ON article.ID_Couleur = couleur.ID_Couleur
WHERE ventes.ANNEE = "2014"
GROUP BY couleur.NOM_COULEUR;

# 25. Donner pour chaque fabricant, le nombre de tickets sur lesquels apparait un de ses produits en 2014

SELECT DISTINCT fabricant.NOM_FABRICANT, COUNT(ventes.NUMERO_TICKET) AS "Nombre Tickets"
FROM fabricant
INNER JOIN marque USING(ID_FABRICANT)
INNER JOIN article USING(ID_MARQUE) 
INNER JOIN ventes USING(ID_ARTICLE)
WHERE ventes.annee = "2014"
GROUP BY fabricant.NOM_FABRICANT;

# 26. Donner l’ID, le nom, le volume et la quantité vendue des 20 articles les plus vendus en 2016

SELECT  article.ID_ARTICLE, article.NOM_ARTICLE, article.VOLUME , SUM(ventes.QUANTITE) AS "Quantite"
FROM article
INNER JOIN ventes USING(ID_ARTICLE)
WHERE ventes.ANNEE = 2016
GROUP BY article.ID_ARTICLE
ORDER BY Quantite DESC
LIMIT 20;

# 27. Donner l’ID, le nom, le volume et la quantité vendue des 5 ‘Trappistes’ les plus vendus en 2016

SELECT article.ID_ARTICLE, article.NOM_ARTICLE, article.VOLUME, SUM(ventes.QUANTITE) as "Quantite"
FROM article
INNER JOIN ventes USING(ID_ARTICLE)
INNER JOIN type USING(ID_TYPE)
WHERE ventes.ANNEE = 2016 AND type.NOM_TYPE = "Trappiste"
GROUP BY article.NOM_ARTICLE
ORDER BY quantite DESC
LIMIT 5;

# 28. Donner l’ID, le nom, le volume et les quantités vendues en 2015 et 2016, des bières dont les ventes ont été stables. (Moinsde 1% de variation)

SELECT article.ID_ARTICLE, article.NOM_ARTICLE, article.VOLUME, total2015.ventes2015 AS "Total de 2015", total2016.ventes2016 AS "Total de 2016" 
FROM article
INNER JOIN (
			SELECT ventes.ID_article AS article2015 , SUM(ventes.QUANTITE) AS ventes2015 
			FROM ventes
			WHERE ventes.ANNEE = "2015"
			GROUP BY ventes.ID_ARTICLE
            ) 
            AS total2015 ON total2015.article2015 = article.ID_ARTICLE
INNER JOIN (
			SELECT ventes.ID_article AS article2016, SUM(ventes.QUANTITE) AS ventes2016 
			FROM ventes
			WHERE ventes.ANNEE = "2016"
			GROUP BY ventes.ID_ARTICLE
            ) 
            AS total2016 ON total2016.article2016 = article.ID_ARTICLE
WHERE ((((total2016.ventes2016-total2015.ventes2015)/total2016.ventes2016)*100)
BETWEEN -1 AND 1);

 # 29. Lister les types de bières suivant l’évolution de leurs ventes entre 2015 et 2016. Classer le résultat par ordre décroissant des performances

SELECT article.ID_ARTICLE, article.NOM_ARTICLE, article.VOLUME, total2015.ventes2015 AS "Total de 2015", total2016.ventes2016 AS "Total de 2016", total2016.ventes2016-total2015.ventes2015 AS "Evolution"
FROM article
INNER JOIN (
			SELECT ventes.ID_article AS article2015 , SUM(ventes.QUANTITE) AS ventes2015 
			FROM ventes
			WHERE ventes.ANNEE = "2015"
			GROUP BY ventes.ID_ARTICLE
            ) 
            AS total2015 ON total2015.article2015 = article.ID_ARTICLE
INNER JOIN (
			SELECT ventes.ID_article AS article2016, SUM(ventes.QUANTITE) AS ventes2016 
			FROM ventes
			WHERE ventes.ANNEE = "2016"
			GROUP BY ventes.ID_ARTICLE
            ) 
            AS total2016 ON total2016.article2016 = article.ID_ARTICLE
ORDER BY (total2016.ventes2016-total2015.ventes2015) DESC;

 
 # 30. Existe-t-il des tickets sans vente ?
 
 SELECT * 
 FROM ticket
 WHERE CONCAT(ticket.NUMERO_TICKET,ticket.ANNEE) NOT IN (
									SELECT CONCAT(ventes.NUMERO_TICKET,ventes.ANNEE)
                                    FROM ventes);
 
 # 31. Lister les produits vendus en 2016 dans des quantités jusqu’à -15% des quantités de l’article le plus vendu.

SELECT * 
FROM article
INNER JOIN ventes USING(ID_ARTICLE)
WHERE ventes.ANNEE = "2016"
GROUP BY article.ID_ARTICLE
HAVING SUM(ventes.QUANTITE) > (SELECT SUM(QUANTITE*0.85) AS ventes_quantite FROM ventes
									WHERE ANNEE = 2016 
                                    GROUP BY ID_ARTICLE 
                                    ORDER BY ventes_quantite DESC 
                                    LIMIT 1);

# 32. Appliquer une augmentation de tarif de 10% pour toutes les bières ‘Trappistes’ de couleur ‘Blonde’

UPDATE article 
INNER JOIN type USING(ID_TYPE) 
INNER JOIN couleur USING(ID_COULEUR)
SET article.PRIX_ACHAT = article.PRIX_ACHAT*1.1 
WHERE type.NOM_TYPE = "Trappiste" AND couleur.NOM_COULEUR = "Blonde";

# 33. Mettre à jour le degré d’alcool des toutes les bières n’ayant pas cette information. On y mettra le degré d’alcool de la moins forte des bières du même type et de même couleur.

# 34. Suppression des bières qui ne sont pas des bières ! (Type ‘Bière Aromatisée’)


# 35. Supprimer les tickets qui n’ont pas de ventes.
