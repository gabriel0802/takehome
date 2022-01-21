SELECT adr.address, adr.address2,adr.district,cty.city,ctry.country, sum(pymt.amount) totalsales FROM rental rntl, payment pymt,
	staff stf, address adr,city cty, country ctry
WHERE rntl.customer_id= pymt.customer_id 
      AND rntl.rental_id=pymt.rental_id
      AND rntl.staff_id=stf.staff_id
      AND rntl.rental_date >= ('2005-05-24' -interval 7 DAY) 
      AND stf.address_id = adr.address_id
      AND stf.staff_id=pymt.staff_id 
      AND stf.address_id=adr.address_id
      AND adr.city_id=cty.city_id 
      AND cty.country_id=ctry.country_id
GROUP BY adr.address, adr.address2,adr.district,cty.city,ctry.country

