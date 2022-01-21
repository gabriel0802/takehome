SELECT cust.customer_id, cust.first_name,cust.last_name,addr.address,
	addr.address2, addr.district,cty.city, ctry.country
FROM customer cust, address addr,city cty, country ctry
WHERE cty.country_id=ctry.country_id  
      AND cty.city_id=addr.city_id  
      AND cust.address_id = addr.address_id 
      AND cust.customer_id NOT IN 
	(SELECT DISTINCT rnt.customer_id FROM rental rnt
		WHERE rnt.rental_date BETWEEN '2006-01-24' AND  DATE_ADD('2006-01-24', INTERVAL 30 DAY))
