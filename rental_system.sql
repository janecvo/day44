-- 1. Customer 'Angel' has rented 'SBA1111A' from today for 10 days
INSERT INTO rental_records(veh_reg_no, customer_id, start_date, end_date)
VALUES ('SBA1111A',
(SELECT customer_id FROM customers WHERE name='Angel'),
(SELECT curdate()),
(date_add(curdate(), interval 10 day)));

-- 2. Customer 'Kumar' has rented 'GA5555E' from tomorrow for 3 months.
INSERT INTO rental_records(veh_reg_no, customer_id, start_date, end_date)
VALUES ('GA5555E',
(SELECT customer_id
FROM customers
WHERE name='Kumar'),
(SELECT curdate()+1),
(date_add(curdate()+1, interval 3 MONTH)));

-- 3.List all rental records (start date, end date) with vehicle's registration number, brand, and customer name, sorted by vehicle's categories followed by start date.
SELECT start_date,  
end_date, 
v.veh_reg_no, 
name,  
brand, 
v.category 
FROM rental_records as r, customers AS c, vehicles AS v
WHERE c.customer_id = r.customer_id 
AND r.veh_reg_no = v.veh_reg_no
ORDER BY category, start_date; 


-- 4. List all the expired rental records (end_date before CURDATE()).
select * 
FROM rental_records
where end_date < curdate();

 -- 5. List the vehicles rented out on '2012-01-10' (not available for rental), in columns of vehicle registration no, customer name, start date and end date. (Hint: the given date is in between the start_date and end_date.)
 SELECT r.veh_reg_no, name, start_date, end_date
 FROM rental_records AS r, customers AS c
 WHERE c.customer_id = r.customer_id
 AND start_date < '2012-01-10' AND end_date > '2012-01-10';


-- 6. List all vehicles rented out today, in columns registration number, customer name, start date, end date. Should only be Angel)
 SELECT r.veh_reg_no, c.name, start_date, end_date
 FROM rental_records as r, customers as c
 WHERE c.customer_id = r.customer_id
 AND start_date <= curdate() AND end_date >= curdate();


 -- 7. Similarly, list the vehicles rented out (not available for rental) for the period from '2012-01-03' to '2012-01-18'. (Hint: start_date is inside the range; or end_date is inside the range; or start_date is before the range and end_date is beyond the range.)
SELECT r.veh_reg_no, start_date, end_date
FROM rental_records as r
WHERE (start_date BETWEEN '2012-01-03' AND '2012-01-18') 
OR (end_date BETWEEN '2012-01-03' AND '2012-01-18')
OR ((start_date < '2012-01-03') AND (end_date > '2012-01-18'));

-- 8. List the vehicles (registration number, brand and description) available for rental (not rented out) on '2012-01-10' (Hint: You could use a subquery based on a earlier query).
 SELECT r.veh_reg_no, v.brand, v.desc
 FROM vehicles AS v LEFT JOIN rental_records AS r 
 ON  v.veh_reg_no = r.veh_reg_no
 AND NOT (start_date < '2012-01-10' AND end_date > '2012-01-10');


-- 9. Similarly, list the vehicles available for rental for the period from '2012-01-03' to '2012-01-18'.
SELECT r.veh_reg_no, v.brand, v.desc
 FROM vehicles AS v LEFT JOIN rental_records AS r 
 ON  v.veh_reg_no = r.veh_reg_no
 AND NOT ((start_date between '2012-01-03' AND '2012-01-18')
 OR (end_date between '2012-01-03' AND end_date > '2012-01-18')
 OR (start_date < '2012-01-03' AND end_date > '2012-01-18') );


-- 10. Similarly, list the vehicles available for rental from today for 10 days.
SELECT r.veh_reg_no, v.brand, v.desc
 FROM vehicles AS v LEFT JOIN rental_records AS r 
 ON  v.veh_reg_no = r.veh_reg_no
 AND NOT ((start_date between curdate() AND (date_add(curdate(), interval 10 day)))
 OR (end_date between curdate() AND end_date (date_add(curdate(), interval 10 day)))
 OR (start_date < curdate() AND end_date > (date_add(curdate(), interval 10 day))) );
