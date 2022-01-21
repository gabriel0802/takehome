SELECT  cat.name Categoryname,MONTHNAME(STR_TO_DATE(month(rnt.rental_date), '%m')) AS Month_Name, YEAR(rnt.rental_date) as Yearrented,
sum((pymt.amount/flm.rental_rate)) TotalQuantity,
dense_rank() over (partition by MONTHNAME(STR_TO_DATE(month(rnt.rental_date), '%m')),YEAR(rnt.rental_date)  order by sum((pymt.amount/flm.rental_rate)) desc) as Ranking
FROM rental rnt,
     inventory inv,
     payment pymt,
     film flm,
     film_category flmcat,
     category cat
WHERE rnt.inventory_id=inv.inventory_id 
      and pymt.rental_id=rnt.rental_id
      and flm.film_id=inv.film_id
      and flm.film_id=flmcat.film_id
      and flmcat.category_id=cat.category_id
      and rnt.staff_id=pymt.staff_id
      and rnt.customer_id=pymt.customer_id
      GROUP BY cat.name,MONTHNAME(STR_TO_DATE(month(rental_date), '%m')),YEAR(rnt.rental_date)
order by YEAR(rnt.rental_date) ASC,month(rental_date) ASC,totalquantity DESC