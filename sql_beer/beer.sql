# 1. Quels sont les tickets qui comportent l’article d’ID 500, afficher le numéro de ticket uniquement ?
SELECT ventes.NUMERO_TICKET 
FROM ventes 
INNER JOIN article ON ventes.ID_ARTICLE = article.ID_ARTICLE 
WHERE article.ID_ARTICLE = 500;


