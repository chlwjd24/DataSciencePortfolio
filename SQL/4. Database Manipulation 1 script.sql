/*****************************************************************************************
Week 5 Practical: All Queries
*****************************************************************************************/

/* Example 1*/
select * from customers where city = 'Paris' AND creditLimit >= 75000;
/* Example 2*/
select * from customers where city = 'Paris' OR creditLimit >= 75000;
/* Example 3*/
select * from customers where NOT city = 'Paris';
/* Example 4*/
SELECT DISTINCT lastname FROM employees;
/* Example 5*/
select productCode, productName, buyPrice from products where buyPrice between 90 and 100;
/* Example 6*/
SELECT employeenumber, firstname, lastname from employees where firstname LIKE 'a%';
/* Example 7*/
SELECT employeenumber, firstname, lastname from employees where lastname LIKE '%on';
/* Example 8*/
SELECT employeenumber, firstname, lastname from employees where firstname LIKE '%t_m%';
/* Example 9*/
SELECT * FROM employees CROSS JOIN offices;
/* Example 10*/
SELECT firstName, lastName, city, country from employees cross join offices where employees.officeCode = offices.officeCode;
SELECT firstName, lastName, city, country from employees, offices where employees.officeCode = offices.officeCode;

/* Task 7.i) */
select productCode, productName, buyPrice from products where buyPrice not between 90 and 100;
/* Task 7.ii) */
select productName, productVendor from products where productName like '%Ford%' or productVendor = 'Second Gear Diecast';
/* Task 7.iii) */
select distinct country from offices;
/* Task 7.iv) */
select ordernumber, orderdate, customerName from orders cross join customers where orders.customerNumber = customers.customerNumber and customers.country = 'Australia';
/* Task 7.v) */
select productname, productvendor, shippeddate from orders cross join orderdetails cross join products where orders.ordernumber = orderdetails.ordernumber and orderdetails.productcode = products.productcode and year(shippeddate) = 2005;
