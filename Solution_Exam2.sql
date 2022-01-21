SELECT
stf.first_name,
        stf.last_name,  
        adr.address,
        adr.address2,
        cty.city,
        ctry.country,
	MONTHNAME(STR_TO_DATE(month(rnt.rental_date), '%m')) AS Month_Name, 
	YEAR(rnt.rental_date) as Year,
        	    sum(pymt.amount) TotalSales,
        dense_rank() over (partition by
            adr.address,
	        adr.address2,
            cty.city,
            ctry.country,
            month(rnt.rental_date),
            YEAR(rnt.rental_date)
            order by sum(pymt.amount) desc) as Ranking
FROM rental rnt,
     payment pymt,
     staff stf,
     address adr,
     city cty,
     country ctry
WHERE  pymt.rental_id=rnt.rental_id 
    AND rnt.staff_id=pymt.staff_id
    AND rnt.customer_id=pymt.customer_id
    AND rnt.staff_id=stf.staff_id
    AND stf.address_id=adr.address_id
    AND cty.city_id=adr.city_id
    AND cty.country_id = ctry.country_id
    AND stf.staff_id=pymt.staff_id
GROUP BY 
    adr.address,
    adr.address2,
    cty.city,
    ctry.country,
    stf.first_name,stf.last_name,MONTHNAME(STR_TO_DATE(month(rental_date), '%m')),YEAR(rnt.rental_date)
order by 
     adr.address,
     adr.address2,
     cty.city,
     ctry.country,
     month(rnt.rental_date),
     YEAR(rnt.rental_date)