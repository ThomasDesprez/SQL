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
WHERE DATE_VENTE BETWEEN "2014-01-15 00:00:00" AND "2014-01-18 00:00:00";

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
