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




