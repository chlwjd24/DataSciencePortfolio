/* Practical - Week 06 */

/* Example 1 */
SELECT officeCode, city, phone, country
FROM   offices
WHERE country IN ('USA' , 'France'); 

/* Example 2 */
SELECT productCode, productName, (MSRP-buyPrice) AS `difference`
FROM products;

/* Example 3 */
SELECT customerName, lastName, firstName
FROM customers c, employees e
WHERE c.salesRepEmployeeNumber = e.employeeNumber;

/* Example 4 */
SELECT avg(creditLimit) `Average Credit Limit` 
FROM customers;

/* Example 5 */
SELECT country, avg(creditLimit) `Average Credit Limit` 
FROM customers
GROUP BY country;

/* Example 6 */
SELECT contactLastname, contactFirstname
FROM customers
ORDER BY contactLastname DESC, contactFirstname ASC;

/* Example 7 */
SELECT customernumber, customername, creditlimit
FROM customers
LIMIT 10;

/* Example 8 */
SELECT customernumber, customername, creditlimit
FROM customers
ORDER BY creditlimit DESC
LIMIT 5;

/*  Task 7.i) */
SELECT officeCode, city, phone, country
FROM   offices
WHERE country NOT IN ('USA' , 'France'); 

/* Task 7.ii) */
SELECT orderNumber, productCode, (quantityOrdered*priceEach) `Amount Payable`
FROM orderdetails;

/* Task 7.iii) */
SELECT orderNumber, sum(quantityOrdered*priceEach) `Total Amount`
FROM orderdetails
GROUP BY orderNumber;

/* Task 7.iv) */
SELECT d.orderNumber, customerName, sum(quantityOrdered*priceEach) `Total Amount`
FROM orderdetails d, orders o, customers c
WHERE d.orderNumber = o.orderNumber AND o.customerNumber = c.customerNumber
GROUP BY d.orderNumber, customerName;

/* Task 7.v) */
SELECT d.orderNumber, orderDate, customerName, sum(quantityOrdered*priceEach) as TotalAmount
FROM orderdetails d, orders o, customers c
WHERE d.orderNumber = o.orderNumber AND o.customerNumber = c.customerNumber AND c.country = 'Australia'
GROUP BY d.orderNumber, customerName
ORDER BY TotalAmount DESC
LIMIT 5;