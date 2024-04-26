select *
from swiggy.dbo.swiggy


/* Total number of unique resturents*/
select count(distinct  name )from swiggy.dbo.swiggy
/* almost 1 lakh 5 thousand resturent are registered in swiggy*/


/* total unique cities where swiggy is present*/
select count(distinct city) as totalcities from swiggy.dbo.swiggy


/* maximum listed resturent chains through out the cities on swiggy*/
select name,count(city) as totalcities 
from swiggy.dbo.swiggy
group by name
order by totalcities desc;
/* Dominos pizza hut and kfc are at the top
As it is expected all are the international chain hotels and has quite high customers satisfications
*/





/* least listed resturent chains through out the cities on swiggy*/
select name,count(city) as totalcities 
from swiggy.dbo.swiggy
group by name
order by totalcities asc;
/* many resturants from only one cities
almost all are local hotels/resturents.*/





/* Which cities has the maximum Resturents?*/
select city,count(id) as Totalresturents
from swiggy.dbo.swiggy
group by city
order by Totalresturents desc;
/* bikaner city has the maximum resturent listed in swiggy
It is one of the tourist destination  in south rajasthan it might the reason*/





/* Which cities has the least Resturents?*/
select city,count(id) as Totalresturents
from swiggy.dbo.swiggy
group by city
order by Totalresturents asc;
/* there are 12 cities with one one resturents listed in swiggy*/






/*Top 10 resturents as per resturent listed in swiggy*/
select top 10  name ,count(name) as resturentlist
from swiggy.dbo.swiggy
group by name 
order by resturentlist desc;


/* Top 3 cuisine accross swiggy*/
select top 3 cuisine , count (*) as cusinecount
from swiggy.dbo.swiggy
group by cuisine
order by cusinecount desc;
/*  Indian,north indian chinese,chinese are the most popular cuisine served across swiggy*/





/*Most expensive resturents across swiggy*/
select *
from swiggy.dbo.swiggy
where cost = (select MAX(cost)
from swiggy.dbo.swiggy)
/* I think its error how in this earth a north indian chinese cuisine costs 3 lac lets see second highest one*/
/* we encountered outlier it destored our data so we need to treat it




TREATING */
WITH z_scores AS (
    SELECT cuisine, cost,
           (cost - AVG(cost) OVER ()) / STDEV(cost) OVER () AS z_score
    FROM swiggy.dbo.swiggy
)
DELETE FROM t
FROM swiggy.dbo.swiggy t
JOIN z_scores z ON t.cuisine = z.cuisine AND t.cost = z.cost
WHERE ABS(z.z_score) > 8; 
/* The one which seems too much odd has been treared*/






/*most expensive resturents in  swiggy according to snacks*/ 
select *
from swiggy.dbo.swiggy
where cost = (select MAX(cost)
from swiggy.dbo.swiggy)




/*third most expensive resturents in swiggy*/
SELECT *
FROM (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY cost DESC) AS rank
    FROM swiggy.dbo.swiggy
) AS ranked_restaurants
WHERE rank = 3;




/*Top rated resturents*/
select name, max(rating) maxrating
  FROM swiggy.dbo.swiggy
  group by name
  order by maxrating desc;
 /* 156 resturents have rating 5 */



 /* now lets see which resturents has max rating with 5k + ratings */
 select name, max(rating) maxrating
  FROM swiggy.dbo.swiggy
  where rating_count='5k+ ratings'
  group by name
  order by maxrating desc;
  /*Shree Mithai in overall is the highest rated resturents across the swiggy*/




/*least rated resturents*/
select name, max(rating) maxrating
  FROM swiggy.dbo.swiggy
  group by name
  order by maxrating asc;
 /*Ice Cream And Shakes Co has the lowest rating ie 1   */





/* now lets see which resturents has minimum rating with 5k + ratings counts */
 select name, Max(rating) minrating
  FROM swiggy.dbo.swiggy
  where rating_count='5k+ ratings'
  group by name
  order by minrating asc;
 /*Raju Gari Biriyani in overall is the lowest  rated resturents across the swiggy with rating count of 5k +*/








select top 5 *
from swiggy.dbo.swiggy

