-- Example 1
SELECT ordernumber, sum(quantityordered) 
FROM orderdetails
WHERE productcode in ('S18_1749','S18_2248')
GROUP BY ordernumber;

-- Example 2
SELECT ordernumber, sum(quantityordered) 
FROM orderdetails
GROUP BY ordernumber
HAVING sum(quantityOrdered) >= 500;

-- Example 3
SELECT city FROM offices 
UNION
SELECT city FROM customers;

-- Example 4
SELECT customername, creditlimit
FROM customers 
WHERE creditlimit >= ALL (select creditlimit FROM customers);

-- Example 5
SELECT customername, creditlimit
FROM customers 
WHERE creditlimit < ANY (select creditlimit FROM customers);

-- Example 6
SELECT productname, productline, textDescription
FROM products natural join productlines
WHERE productvendor = 'Second Gear Diecast';

-- Example 7
SELECT o1.ordernumber, customerName, country
FROM orders o1, customers c1
WHERE o1.customerNumber = c1.customerNumber and 
		EXISTS 	( 
				SELECT * FROM orders o2, customers c
				WHERE o1.ordernumber = o2.ordernumber 
				and o1.customerNumber = c.customerNumber 
                and c.country = 'Australia'
				);


-- Task 6. i) 
-- using HAVING
SELECT temp.customername, temp.country, sum(total_amount) `Total Valuation of Orders`
FROM (SELECT d.orderNumber, c.customerName, c.country, sum(quantityOrdered*priceEach) total_amount
FROM orderdetails d, orders o, customers c
WHERE d.orderNumber = o.orderNumber AND o.customerNumber = c.customerNumber
GROUP BY d.orderNumber, customerName, c.country
HAVING c.country in ('USA','Australia')) temp
GROUP BY temp.customername, temp.country
ORDER BY `Total Valuation of Orders` DESC;

-- using WHERE 
SELECT temp.customername, temp.country, sum(total_amount) `Total Valuation of Orders`
FROM (SELECT d.orderNumber, c.customerName, c.country, sum(quantityOrdered*priceEach) total_amount
FROM orderdetails d, orders o, customers c
WHERE d.orderNumber = o.orderNumber AND o.customerNumber = c.customerNumber AND c.country in ('USA','Australia')
GROUP BY d.orderNumber, customerName, c.country) temp
GROUP BY temp.customername, temp.country
ORDER BY `Total Valuation of Orders` DESC;

-- Task 6.ii)
SELECT ordernumber, total_quantity 
FROM (SELECT ordernumber, sum(quantityordered) total_quantity FROM orderdetails
      GROUP BY ordernumber) temp
WHERE total_quantity >= 500;

-- Task 6.iii)
SELECT officecode, city FROM offices WHERE city in (SELECT city from customers);

-- Task 6.iv)

SELECT productname, quantityInStock
FROM products 
WHERE (productname, quantityInStock) NOT IN (SELECT productname, quantityInStock 
											FROM products 
											WHERE quantityInStock > SOME (SELECT quantityInStock 
																		  FROM products));
-- same query using ALL
SELECT productname, quantityInStock 
FROM products 
WHERE quantityInStock <= ALL (select quantityInStock from products);

-- Task 6.v)
SELECT productcode, productname, quantityinstock 
FROM products
WHERE quantityInStock > (select avg(quantityInStock) from products)
ORDER BY quantityInStock desc
LIMIT 5; 

-- Task 6.vi)

SELECT ordernumber, customerName, country
FROM orders natural join customers
WHERE country = 'Australia';

-- Task 6.vii)
SELECT productcode, productname
FROM products p
WHERE NOT EXISTS (select * FROM orderdetails o WHERE p.productCode = o.productCode);

-- Task 6.viii)

SELECT distinct e2.employeenumber, e2.firstname, e2.lastname
FROM employees e1, employees e2
WHERE e1.reportsTo = e2.employeeNumber;

-- extension
SELECT employeenumber, firstname, lastname
FROM employees 
WHERE reportsTo is NULL;