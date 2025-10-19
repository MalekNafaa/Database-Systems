
use classicmodels;


# Get the maximum, minimum, total and average credit limit for all customers in each country and each city and where the country and city are not null.
# Order the result set by country in descending order and by city in ascending order. (customers)

select country, city, max(creditLimit), min(creditLimit), sum(creditLimit), avg(creditLimit)
from customers
where country is not null and city is not null
group by country, city
order by country desc, city asc


#Get 10 customers which have the maximum amount (payments)

select c.customerNumber,sum(amount) as total_payments
from customers c
join payments on c.customerNumber = payments.customerNumber
group by c.customerNumber
order by total_payments desc
limit 10

#Write a query that will count how many orders were created starting from October 10th, 2003 and September 9th,
# 2004 for each status. (orders)

select status,count(*) as order_count
from orders
where orderDate between '2003-10-10' and '2004-09-09'
group by status
order by status asc

#Get the maximum payments and their average for each client. (payments)

select customerNumber,max(amount),avg(amount)
from payments
group by customerNumber

#Get the maximum, minimum and average for quantityInStock and buyPrice columns,
# where the product line is one of the following: (products)
    #Classic Cars
    #Trucks and Buses
    #Motorcycles

select productLine,max(quantityInStock),min(quantityInStock),avg(quantityInStock),max(buyPrice),min(buyPrice),avg(buyPrice)
from products
where productLine in ('Classic Cars','Trucks and Buses','Motorcycles')
group by productLine


# Get the product code, orderLineNumber and average of  priceEach for every product
# and every orderLineNumber where max priceEach is greater than 100.
# Order the result set by product in descending order and orderLineNumber in ascending order.
# (orderdetails)

select productCode,orderLineNumber,avg(priceEach) as avg_priceEach
from orderdetails
group by productCode,orderLineNumber
having max(priceEach) > 100
order by productCode desc, orderLineNumber asc


#Get a comma separated list of customerNames for every country.
# Order the result set by country in descending order. (customers)

select country, group_concat(customerName) as customerNames
from customers
group by country
order by country desc


/*
Get customer name, phone number and column called state_or_address_line2_or_country that
will return first non null value out of these three columns (state, addressLine2, country)
where credit limit is greater that 20000 and less than 100000; (customers)*/

select customerName, phone, coalesce(state,addressLine2,country) as state_or_address_line2_or_country
from customers
where creditLimit > 20000 and creditLimit < 100000

# Get customer number,
# if amount is greater than 10000 divide it by 100 for all payments
# where checkNumber starts with 'HQ'; (payments)

select customerNumber,IF(amount>10000,amount/100,amount) as adjusted_amount
from payments
where checkNumber like 'HQ%'

#Get city, phone number and addressLine2 from offices.
# If state is null return 'N/A' for all offices where country is USA (offices)

select city ,phone,addressLine2,COALESCE(state,'N/A') AS state
from offices
where country = 'USA'



#Get all orders where comment exist and status is 'Shipped'.
#We are interested just in orders where shippedDate is between 2003-01-25 and 2003-03-20.
# (orders)

select * from orders
where comments is not null and status = 'Shipped' and shippedDate between '2003-01-25' and '2003-03-20'

#For all products calculate how much retailer will earn money by
# subracting buy price from MSRP where product code starts with 'S12' OR 'S18' (products)

select productCode,(MSRP-buyPrice) as retailer_earnings
from products
where productCode like 'S12%' or productCode like 'S18%'

#For every product in order details table get product code and calculate subtotal (quantity * price)
# for every product order where quantity is greater than 20 and price is less than 120.
# Round subtotal on two decimal places. (orderdetails).

select productCode,round((quantityOrdered*priceEach),2)as subtotal
from orderdetails
where quantityOrdered > 20 and priceEach < 120

#Get first and last name, reportsTo and job title and email of all employees whose job
# title is President or VP Sales or Sales Rep or those who reports to office code 1.
# In email replace 'classicmodelcars.com' with 'ibu.edu.ba'.
# Result set should be order by job title in descending order. (employees)

select firstName,lastName,reportsTo,jobTitle,replace(email,'classicmodelcars.com','ibu.edu.ba') as email
from employees
where jobTitle in ('President','VP Sales','Sales Rep','VP Marketing') or reportsTo = 1
order by jobTitle desc

#Get all product lines where productLine contains 'Cars' in its name. (productlines)
select * from productlines
where productLine like '%Cars%'
