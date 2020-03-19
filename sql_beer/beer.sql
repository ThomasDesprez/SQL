# 1. Quels sont les tickets qui comportent l’article d’ID 500, afficher le numéro de ticket uniquement ?

SELECT ventes.NUMERO_TICKET 
FROM ventes 
INNER JOIN article ON ventes.ID_ARTICLE = article.ID_ARTICLE 
WHERE article.ID_ARTICLE = 500;

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
INNER JOIN couleur ON article.ID_Couleur = couleur.ID_Couleur
WHERE couleur.ID_Couleur = null