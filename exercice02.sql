-- Base de données Northwing_Mysql
-- 1 Liste des contacts français
SELECT CompanyName AS Societé, contactName AS contact, contacttitle AS Fonction, phone AS Téléphone FROM customers WHERE country = 'France';

--2 Produits vendus par le fournisseur Exotic Liquids
SELECT products.productName AS Produit, products.UnitPrice AS Prix
FROM (products
INNER JOIN suppliers ON suppliers.supplierID = products.supplierID)
WHERE suppliers.CompanyName = 'Exotic Liquids';

-- 3 
SELECT suppliers.CompanyName AS 'Fournisseur', COUNT( products.productID) AS 'Nbrproduits'
FROM (products
INNER JOIN suppliers ON suppliers.supplierID = products.supplierID)
WHERE suppliers.country = 'France'
GROUP BY suppliers.CompanyName
ORDER BY  Nbrproduits desc;

-- 4 Listes des clients Français ayant plus de 10 comandes
SELECT customers.CompanyName AS 'Client', COUNT(Orders.OrderID) AS 'Numbre comandes'
FROM (Orders
INNER JOIN customers ON Orders.customerID = Customers.customerID)
WHERE customers.country = 'France'
GROUP BY customers.CompanyName
HAVING COUNT(Orders.OrderID) > 10;

-- 5 Liste des clients ayant un chiffre d'affaires > 30000
SELECT customers.CompanyName AS `Client`, sum(UnitPrice * quantity) AS `CA`, country AS `Pays`
FROM ((customers
INNER JOIN orders ON Orders.CustomerID = Customers.CustomerID)
INNER JOIN `order details` ON `order details`.orderID = orders.orderID)
GROUP BY customers.CustomerID
HAVING sum(UnitPrice * quantity) > 30000
ORDER BY sum(UnitPrice * quantity) DESC;

-- 6 Liste des pays dont les clients ont passé commande de produits fournis par « Exotic Liquids » :
SELECT customers.Country AS Pays
FROM ((((customers
INNER JOIN orders ON Orders.CustomerID = Customers.CustomerID)
INNER JOIN `order details` ON `order details`.orderID = orders.orderID)
Inner join products ON products.productID = `order details`.productID )
INNER JOIN suppliers ON suppliers.SupplierID = products.SupplierID)
WHERE suppliers.CompanyName = 'Exotic Liquids'
GROUP BY customers.Country;

-- 7 Montant des Ventes 97
SELECT sum(UnitPrice * quantity) AS `Montant Ventes 97`
FROM (`order details`
INNER JOIN orders ON `order details`.orderID = orders.orderID)
WHERE YEAR (`orderdate`) = '1997';

-- 8 Montant des ventes de 1997 mois par mois:
SELECT MONTH (`orderdate`) AS `Mois 97`, sum(UnitPrice * quantity) AS `Montant Ventes`
FROM (`order details`
INNER JOIN orders ON `order details`.orderID = orders.orderID)
WHERE YEAR (`orderdate`) = '1997'
GROUP BY MONTH (`orderdate`);

-- 9 Depuis quelle date le client « Du monde entier » n’a plus commandé ?
SELECT MAX(orderdate) AS 'Date de dernère comande'
FROM `orders`
WHERE shipname = 'Du monde entier';

-- 10 Quel est le délai moyen de livraison en jours
SELECT ROUND (AVG (DATEDIFF (shippeddate, orderdate))) AS 'Délai moyen de livraison' FROM orders;