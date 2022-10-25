CREATE DATABASE Gestion_Comercial;
USE Gestion_Comercial;
CREATE TABLE client (
    numClient INT(11)  AUTO_INCREMENT ,
    raisonSocial VARCHAR(10) NOT NULL,
    adresseClient VARCHAR(50) NOT NULL,
    villeClient VARCHAR(20) NOT NULL,
    telephone VARCHAR(15) UNIQUE NOT NULL,
    PRIMARY KEY(numClient)
);

CREATE TABLE commande(
    numCommande INT(11) AUTO_INCREMENT, 
    numClient INT(11) NOT NULL,
    dateCommande DATE NOT NULL,
    CONSTRAINT fk_num_client FOREIGN KEY(numClient) REFERENCES client(numClient),
    PRIMARY KEY(numCommande)
);

CREATE TABLE produit(
    refProduit VARCHAR(20) PRIMARY KEY,
    nomProduit VARCHAR(20) NOT NULL,
    prixUnitaire FLOAT(4) NOT NULL,
    qteStockee INT(11) NOT NULL,
    disponible BOOLEAN NOT NULL
);

CREATE TABLE details_commande(
    numCommande INT(11),
    refProduit VARCHAR(20),
    qteCommandee INT(11) NOT NULL,
    CONSTRAINT fk_num_commande FOREIGN KEY(numCommande) REFERENCES commande(numCommande),
    CONSTRAINT fk_ref_produit FOREIGN KEY(refProduit) REFERENCES produit(refProduit),
    PRIMARY KEY(numCommande,refProduit)
);


insert into client (raisonSocial, adresseClient, villeClient, telephone) values ('WRG', 'DJKFGFG', 'Agadir', '0545583345');
insert into client (raisonSocial, adresseClient, villeClient, telephone) values ('ERG', ';DLSFGDFFD', 'Boujdour', '0675847563');
insert into client (raisonSocial, adresseClient, villeClient, telephone) values ('DHD', 'LKZXDFGFF', 'Agadir', '0685948765');
insert into client (raisonSocial, adresseClient, villeClient, telephone) values ('DFH', 'LDFUJGCZXF', 'Casablanca', '0673845276');


insert into produit (refProduit, nomProduit, prixUnitaire, qteStockee, disponible) values ('REF1', 'Capon - Breast, Double, Wing On', 5000, 92, false);
insert into produit (refProduit, nomProduit, prixUnitaire, qteStockee, disponible) values ('REF2', 'Assorted Desserts', 430, 98, false);
insert into produit (refProduit, nomProduit, prixUnitaire, qteStockee, disponible) values ('REF3', 'Glass - Wine, Plastic, Clear 5 Oz', 650, 70, false);
insert into produit (refProduit, nomProduit, prixUnitaire, qteStockee, disponible) values ('REF4', 'Cheese - Brick With Onion', 4000, 91, true);
insert into produit (refProduit, nomProduit, prixUnitaire, qteStockee, disponible) values ('REF5', 'Sea Bass - Fillets', 9000, 77, false);

insert into commande (numCommande, numClient, dateCommande) values (1,4, '2022-01-26');
insert into commande (numCommande, numClient, dateCommande) values (2,1, '2021-09-12');
insert into commande (numCommande, numClient, dateCommande) values (3,4, '2022-05-19');
insert into commande (numCommande, numClient, dateCommande) values (4,20, '2022-04-13');
insert into commande (numCommande, numClient, dateCommande) values (5,5, '2022-08-05');

insert into details_commande (numCommande,refProduit,qteCommandee) values (53,'REF1' ,5);
insert into details_commande (numCommande,refProduit,qteCommandee) values (44 ,'REF2' ,6);
insert into details_commande (numCommande,refProduit,qteCommandee) values (23 ,'REF3' ,45);
insert into details_commande (numCommande,refProduit,qteCommandee) values (13 ,'REF4' ,8);
insert into details_commande (numCommande,refProduit,qteCommandee) values (87 ,'REF5' ,51);

-----Query-------

-- 1
SELECT * 
FROM `client`;
-- 2
SELECT * 
FROM `produit`;
-- 3
SELECT `numClient` as `Numero client`,`villeClient` as `Ville client`
FROM `client`;
-- 4
SELECT `numClient` as `Numero`,`raisonSocial` as `Raison Social`, `telephone`
FROM `client`;
-- 5
SELECT *
FROM `client`
WHERE `numClient` = 15;
-- 6
SELECT * 
FROM `client` 
ORDER BY `raisonSocial` DESC;
--7
SELECT * 
FROM `client`
ORDER BY `raisonSocial` DESC,`villeClient` ASC;
-- 8
SELECT * 
FROM `client` 
WHERE `raisonSocial` LIKE 'S%';
-- 9
SELECT * 
FROM `client` 
WHERE `raisonSocial` LIKE '%E';
-- 10
SELECT * 
FROM `client` 
WHERE `raisonSocial` LIKE 'A%E';
-- 11
SELECT * 
FROM `client` 
WHERE `raisonSocial` LIKE 'A%'
OR `raisonSocial` LIKE '%E';
-- 12
SELECT *
FROM `client`
WHERE `villeClient` IN ('Casablanca','Ouarzazate','Rabat');
-- 13
SELECT *
FROM `produit`
WHERE `prixUnitaire` = 300;
-- 14
SELECT *
FROM `produit`
WHERE `prixUnitaire` < 300;
-- 15
SELECT *
FROM `produit`
WHERE `prixUnitaire` BETWEEN 300 AND 5000;
--16
SELECT * 
FROM `produit` 
WHERE `disponible` IS true
-- 17
SELECT * 
FROM `produit` 
WHERE `disponible` IS NOT true
AND `prixUnitaire` > 300;
-- 18
SELECT *
FROM `commande`
WHERE `dateCommande` = date('2016-01-11');
----- 19
SELECT * 
FROM `commande` 
WHERE `dateCommande` > date('2016-01-11');
---- 20
SELECT *
FROM `commande`
WHERE `dateCommande` BETWEEN date('2021-01-01') AND date('2021-12-31');
----21
SELECT *
FROM `commande`
WHERE `dateCommande` = CURDATE();
--- 22
SELECT *
FROM `commande`
WHERE year(`dateCommande`) = year(curdate());
---- 23
SELECT *
FROM `commande`
WHERE month(`dateCommande`) = month('0000-07-00');
---- 24
SELECT *, (`prixUnitaire`*`qteStockee`) as `Prix de Stock`
FROM `produit`;
---25
SELECT *,((prixUnitaire*0.2) + prixUnitaire) AS `Prix TTC` 
FROM produit;
--- 26
SELECT DISTINCT `villeClient` 
FROM `client`;
---- 27
SELECT DISTINCT cl.*
FROM `client` cl
JOIN `commande` co
ON cl.numClient = co.numClient

SELECT cl.* ,co.numCommande
FROM `client` cl
JOIN `commande` co
ON cl.numClient = co.numClient
GROUP BY cl.numClient

---- 28
SELECT DISTINCT p.* 
FROM `produit` p
JOIN `details_commande` d
ON p.refProduit = d.refProduit
JOIN `commande` c
ON c.numCommande = d.numCommande
--- 29
SELECT co.*
FROM `commande` co
JOIN `client` cl
ON co.numClient = cl.numClient
WHERE cl.numClient = 15;
--- 30
SELECT p.*
FROM `produit` p
JOIN `details_commande` d
ON p.refProduit = d.refProduit
JOIN `commande` co 
ON d.numCommande = co.numCommande
WHERE co.numCommande = 5;
--- 31
SELECT p.*,co.dateCommande
FROM `produit` p 
JOIN `details_commande` d
ON p.refProduit = d.refProduit
JOIN `commande` co
ON co.numCommande = d.numCommande
WHERE co.dateCommande = date('2020-09-19');
---- 32
SELECT p.nomProduit,cl.villeClient as `Ville client`
FROM `produit` p
JOIN `details_commande` d
ON p.refProduit = d.refProduit
JOIN `commande` co
ON co.numCommande = d.numCommande
JOIN `client` cl
ON cl.numClient = co.numClient
WHERE cl.villeClient = 'Madrid' #Ouarzazate
GROUP BY p.nomProduit
---- 33
SELECT p.*
FROM `produit` p
JOIN `details_commande` d
ON p.refProduit = d.refProduit
JOIN `commande` co
ON d.numCommande = co.numCommande
JOIN `client` cl
ON cl.numClient = co.numClient
WHERE cl.numClient = 15;
---- 34
SELECT COUNT(*) as `Nombre des clients`
FROM `client`;
---- 35
SELECT COUNT(*) as `Nombre des clients`
FROM `client`
WHERE `villeClient` = 'Agadir'; #Berlin
---- 36
SELECT COUNT(*) as `Nombre des produit disponible`
FROM `produit`
WHERE `disponible` IS true;
--- 37
SELECT COUNT(*) as `Nombre des produit disponible`
FROM `produit`
WHERE `disponible` IS NOT true;-- 38
SELECT MAX(produit.prixUnitaire) as `Grand prix`
FROM `produit`;
-- 39
SELECT MIN(produit.prixUnitaire) as `Petit prix`
FROM `produit`;
-- 40
SELECT AVG(produit.prixUnitaire) as `Moyenne des prix`
FROM `produit`;
--41
SELECT SUM(produit.prixUnitaire) as `Somme des prix`
FROM `produit`

-- 43
SELECT cl.*,COUNT(co.numCommande) as `Nombre commande`
FROM `client` cl 
JOIN `commande` co
ON cl.numClient = co.numClient
GROUP BY co.numClient
HAVING COUNT(co.numCommande) > 2;
-- 44
SELECT cl.raisonSocial, COUNT(p.refProduit) AS `Nombre  produit`
FROM produit p 
JOIN details_commande d 
ON p.refProduit = d.refProduit 
JOIN commande co 
ON co.numCommande = d.numCommande 
JOIN client cl 
ON co.numClient = cl.numClient
GROUP BY cl.raisonSocial
-- 45
SELECT cl.* 
FROM `client` cl
LEFT JOIN `commande` co
ON cl.numClient = co.numClient
WHERE co.numClient IS null;
-- 46
SELECT p.* 
FROM `produit` p
LEFT JOIN `details_commande` d
ON p.refProduit = d.refProduit
WHERE d.refProduit IS null
-- 47
SELECT produit.qteStockee 
FROM `produit`;
-- 48
SELECT co.numCommande,SUM(p.prixUnitaire) as `Montant`
FROM `commande` co
JOIN `details_commande` d
ON co.numCommande = d.numCommande
JOIN `produit` p
ON d.refProduit = p.refProduit
GROUP BY co.numCommande
HAVING SUM(p.prixUnitaire);
-- 53
SELECT client.villeClient,client.adresseClient
FROM `client`