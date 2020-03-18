CREATE DATABASE tp3;

CREATE TABLE IF NOT EXISTS tp3.user (
  id_user INT NOT NULL auto_increment,
  nom VARCHAR(40) NOT NULL,
  prenom VARCHAR(40) NOT NULL,
  email VARCHAR(255) NOT NULL,
  PRIMARY KEY (id_user)
);

CREATE TABLE IF NOT EXISTS tp3.article (
  id_article INT NOT NULL auto_increment,
  titre VARCHAR(40) NOT NULL,
  texte text NOT NULL,
  id_categorie INT NOT NULL,
  PRIMARY KEY (id_article)
);

CREATE TABLE IF NOT EXISTS tp3.commentaire (
  id_commentaire INT NOT NULL auto_increment,
  titre_commentaire VARCHAR(40) NOT NULL,
  texte_commentaire VARCHAR(255) NOT NULL,
  id_article INT NOT NULL,
  PRIMARY KEY (id_commentaire)
);

CREATE TABLE IF NOT EXISTS tp3.categorie (
  id_categorie INT NOT NULL auto_increment,
  titre_categorie VARCHAR(40) NOT NULL,
  PRIMARY KEY (id_categorie)
);

CREATE TABLE IF NOT EXISTS tp3.tags (
  id_tags INT NOT NULL auto_increment,
  titre_tags VARCHAR(40) NOT NULL,
  PRIMARY KEY (id_tags)
);

CREATE TABLE IF NOT EXISTS tp3.tags_articles (
  id_tags INT NOT NULL,
  id_articles INT NOT NULL
);

ALTER TABLE tp3.article add constraint FK_categorie_article foreign key (id_categorie) references tp3.categorie(id_categorie) on update cascade on delete restrict;
ALTER TABLE tp3.commentaire add constraint FK_article_commentaire foreign key (id_article) references tp3.article(id_article) on update cascade on delete restrict;
ALTER TABLE tp3.tags_articles add constraint FK_tags_tags_articles foreign key (id_tags) references tp3.tags(id_tags) on update cascade on delete restrict;
ALTER TABLE tp3.tags_articles add constraint FK_article_tags_articles foreign key (id_articles) references tp3.article(id_article) on update cascade on delete restrict;

insert into tp3.user(nom, prenom, email) values	("Dupont", "Pascal", "lalalal@gmail.com"),("Dupond", "George", "test@gmail.com"),("Desbois", "Pierre", "cailloux@gmail.com") ;
insert into tp3.categorie(titre_categorie) values ("Travail"),("Musique"),("Random");
insert into tp3.tags(titre_tags) values ("workteam"),("chill"),("test"),("corona"),("mushroom"),("test2");
insert into tp3.article(titre, texte, id_categorie) values ("mon article 1","je suis le texte de l'article 1", 2),("mon article 2","je suis le texte de l'article 2", 1),("mon article 3","je suis le texte de l'article 3", 3) ;
insert into tp3.commentaire(titre_commentaire, texte_commentaire, id_article) values ("mon commentaire 1","je suis le texte du commentaire 1", 3),("mon commentaire 2","je suis le texte du commentaire 2", 1),("mon commentaire 3","je suis le texte du commentaire 3", 2),("mon commentaire 4","je suis le texte du commentaire 4", 1);
insert into tp3.tags_articles(id_tags, id_articles) values	( 1, 1), ( 4, 1), (1, 2), (5, 2), (2, 3), (6, 3), (3, 3);
