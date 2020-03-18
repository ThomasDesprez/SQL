create database tp2;

CREATE TABLE IF NOT EXISTS tp2.ville (
	id_ville int not null unique primary key auto_increment,
    nom_ville VARCHAR(45) NOT NULL,
    code_postal VARCHAR(5) NOT NULL,
    id_pays int
);

CREATE TABLE IF NOT EXISTS tp2.langue (
	id_langue int not null unique primary key auto_increment,
    nom_langue VARCHAR(45) NOT NULL
);

CREATE TABLE IF NOT EXISTS tp2.pays_langue (
	id_langue int not null,
    id_pays int not null
);

CREATE TABLE IF NOT EXISTS tp2.pays (
	id_pays int not null unique primary key auto_increment,
    nom_pays VARCHAR(45) NOT NULL
);

ALTER TABLE tp2.pays_langue add constraint FK_pays_langue_id foreign key (id_pays) references tp2.pays(id_pays) on update cascade on delete restrict;
ALTER TABLE tp2.pays_langue add constraint FK_langue_pays_id foreign key (id_langue) references tp2.langue(id_langue) on update cascade on delete restrict;
ALTER TABLE tp2.ville add constraint FK_pays_id foreign key (id_pays) references tp2.pays(id_pays) on update cascade on delete restrict;

insert into tp2.langue(nom_langue) values ("Français"), ("Anglais"), ("Espagnol"), ("Arabe");
insert into tp2.pays(nom_pays) values ("France"), ("Etat Unis"), ("Maroc"), ("Espagne"), ("Belgique");
insert into tp2.pays_langue(id_langue, id_pays) values	( 1, 1), ( 2, 2), (3, 4), (4, 3), (1, 3), (1, 5);
insert into tp2.ville(nom_ville, code_postal, id_pays) values	("Lille", "59600", 1), ("Marrakech", "????", 3), ("New York", "???", 2), ("Valence", "???", 4), ("Bruxelle", "????", 5), ("Paris", "93000", 1);

select tp2.pays.nom_pays from tp2.pays inner join tp2.pays_langue on tp2.pays_langue.id_pays = tp2.pays.id_pays inner join tp2.langue on tp2.pays_langue.id_langue = tp2.langue.id_langue WHERE tp2.langue.nom_langue = "Anglais";