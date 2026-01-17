
/* Data Project
 * Script: LogicaConsultasSQL 1
 */

-- 2. Muestra los nombres de todas las películas con una clasificación por edades de ‘R’.
select "title" as "Titulo pelicula",
       "rating" as "Clasificacion"
from film
where "rating" = 'R';

-- 3. Encuentra los nombres de los actores que tengan un “actor_id” entre 30 y 40.
select "actor_id",
concat(first_name , ' ', last_name) as "Nombre actores"
from actor
where actor_id between 30 and 40;

-- 4. Obtén las películas cuyo idioma coincide con el idioma original.
/*In the below case, it looks like there is no original id assigned to any movie in the film table. 
The result in this case would be 0.
*/
SELECT COUNT(*) as "Orginal language ID"
FROM film
WHERE original_language_id IS NOT NULL;

SELECT f.title as "Title movie"
FROM film f
WHERE f.language_id = f.original_language_id;

-- 5. Ordena las películas por duración de forma ascendente.
select "film_id" , "title" as "Titulo pelicula", 
        "length" as "Duracion" 
from film
order by "length";

-- 6. Encuentra el nombre y apellido de los actores que tengan ‘Allen’ en su apellido.
/* Important to write the last name as in the data. All CAPS needed, otherwise it is not recognised.
 * Using two different ways to show result with IN and =.
 */
-- USE OF IN
select "first_name" , "last_name" 
from actor
where "last_name" in('ALLEN');

-- USE OF =
select "first_name" , "last_name" 
from actor
where "last_name" = 'ALLEN' ;

-- 7. Encuentra la cantidad total de películas en cada clasificación de la tabla “film” 
-- y muestra la clasificación junto con el recuento.
select f.rating,
       count(f.rating) as "Total per rating"
from film f 
group by f.rating ;

-- 8. Encuentra el título de todas las películas que son ‘PG-13’ o tienen una duración mayor a 3 horas en la tabla film.
select f.rating,
       f.title as "Titulo pelicula",
       f.length as "Duracion"
from film f 
where f.rating = 'PG-13'
or f.length > 180
order by "Duracion" desc;

-- 9. Encuentra la variabilidad de lo que costaría reemplazar las películas.
select round(variance(f.replacement_cost),2) as "Variance of replacement cost"
from film f ;

-- 10. Encuentra la mayor y menor duración de una película de nuestra BBDD.
select max(f.length)as "Mayor duracion pelicula",
       min(f.length) as "Menor duracion pelicula"
from film f ;

-- 11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día.
select payment_date as "Fecha pago", 
       amount as "Total pago",
       payment_id
from payment
order by "Fecha pago" desc
limit 1
offset 2 ;

-- 12. Encuentra el título de las películas en la tabla “film” que no sean ni ‘NC17’ ni ‘G’ en cuanto a su clasificación.
select title as "Titulo pelicula",
       rating as "Clasificacion"
from film f 
where f.rating not in('NC-17', 'G')
order by "Clasificacion" ;

-- 13. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film 
-- y muestra la clasificación junto con el promedio de duración.
select rating as "Clasificacion",
       round(avg(length),2) as "Promedio duracion pelicula"
from film
group by rating ;

-- 14. Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.
select title as "Titulo pelicula",
       length as "Duracion pelicula"
from film
where length > 180 ;

-- 15. ¿Cuánto dinero ha generado en total la empresa?
select round(sum(amount)) as "Total income"
from payment ;

-- 16. Muestra los 10 clientes con mayor valor de id.
select customer_id,
       concat(first_name , ' ' , last_name) as "Customer full name"
 from customer
order by customer_id desc
limit 10 ;

-- 17. Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igby’.
select concat(a.first_name , ' ', a.last_name) as "Actors full name", 
       f.title as "Titulo pelicula"
from actor as a 
 inner join film_actor as fa 
  on a.actor_id = fa.actor_id 
 inner join film as f 
  on fa.film_id = f.film_id
where title in('EGG IGBY');


/* Data Project
 * Script: LogicaConsultasSQL 2
 */

-- 18. Selecciona todos los nombres de las películas únicos.
select distinct f.title as "Titulos peliculas"
from film f ; 

-- 19. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “film”.
select f.title as "Titulo pelicula",
       c."name" as "Categoria pelicula",
       f.length 
from film as f
 inner join film_category as fc 
  on f.film_id = fc.film_id 
 inner join category as c 
  on fc.category_id = c.category_id 
where c.name = 'Comedy' and f.length > 180;

-- 20. Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos y muestra el nombre de la categoría
--junto con el promedio de duración.
select c."name" as "Categoria pelicula",
       round(AVG(f.length),2) as "Promedio duracion pelicula"
from film as f
 inner join film_category as fc 
  on f.film_id = fc.film_id 
 inner join category as c 
  on fc.category_id = c.category_id
group by c."name"  
having round(AVG(f.length),2) > 110
order by round(AVG(f.length),2);

-- 21. ¿Cuál es la media de duración del alquiler de las películas?
select round(avg(rental_duration)) as "Duracion media pelicula"
from film ;

-- 22. Crea una columna con el nombre y apellidos de todos los actores y actrices.
select concat(first_name, ' ', last_name) as "Actors' Full name"
from actor ;

-- 23. Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.
select count(*) as "Total rentals", 
       DATE(r.rental_date) as "Rental day"
from rental r 
group by DATE(r.rental_date)
order by "Total rentals" desc ;

-- 24. Encuentra las películas con una duración superior al promedio.
select film_id, 
       title as "Pelicula",
       length as "Duracion" 
from film
where length > 
      (select avg(length) 
       from film );

-- 25. Averigua el número de alquileres registrados por mes.
select DATE_TRUNC('month', rental_date) AS "Month",
       COUNT(*) AS "Total rentals"
from rental
group by DATE_TRUNC('month', rental_date)
order by "Month";

-- 26. Encuentra el promedio, la desviación estándar y varianza del total pagado.
select round(avg(amount),2) as "Promedio Total Pagado",
       round(stddev(amount),2) as "Desviacion estandar Total Pagado",
       round(variance(amount),2) as "Varianza Total pagado"
from payment ;

-- 27. ¿Qué películas se alquilan por encima del precio medio?
select title as "Titulo pelicula"
from film
     where rental_rate > 
     (select AVG(film.rental_rate) 
     from film);

-- 28. Muestra el id de los actores que hayan participado en más de 40 películas.
select fa.actor_id,
       count(fa.film_id) as "Total pelicula"
from film_actor fa 
group by actor_id 
Having count(fa.film_id) > 40;

-- 29. Obtener todas las películas y, si están disponibles en el inventario,
--mostrar la cantidad disponible.
select 
    f.film_id,
    f.title as "Titulo pelicula",
    (
        select COUNT(i.film_id)
        from inventory i
        where i.film_id = f.film_id
    ) as "Total inventario"
from film f ;

-- 30. Obtener los actores y el número de películas en las que ha actuado.
select 
      concat(a.first_name , ' ', a.last_name) as "Nombre completo actor",
      (
        select COUNT(fa.film_id)
        from film_actor fa 
        where a.actor_id = fa.actor_id 
    ) as "Total peliculas"      
from actor a ;

-- 31. Obtener todas las películas y 
-- mostrar los actores que han actuado en ellas, incluso si algunas películas no tienen actores asociados.
select f.title as "Pelicula",
       concat(a.first_name , ' ', a.last_name) as "Nombre completo actor"
from film f 
   left join film_actor fa 
   on f.film_id = fa.film_id 
   left join actor a 
   on fa.actor_id = a.actor_id
 order by "Nombre completo actor" ;

-- 32. Obtener todos los actores y mostrar las películas en las que han actuado, 
--incluso si algunos actores no han actuado en ninguna película. 
select concat(a.first_name , ' ', a.last_name) as "Nombre completo actor",
       f.title as "Pelicula"
from actor a
    left join film_actor fa 
    on a.actor_id = fa.actor_id 
    left join film f 
    on fa.film_id = f.film_id 
order by "Nombre completo actor" ;

-- 33. Obtener todas las películas que tenemos y todos los registros de alquiler.
select f.title as "Pelicula", 
       r.rental_id , 
       r.rental_date 
from film f 
    full join inventory i 
    on f.film_id = i.film_id 
    full join rental r 
    on i.inventory_id = r.inventory_id 
order by "Pelicula" ;

-- 34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.
select CONCAT(c.first_name, ' ', c.last_name) AS "Customer",
       SUM(p.amount) AS "Total paid"
from customer c
 inner join payment p
       on c.customer_id = p.customer_id
group by c.customer_id, c.first_name, c.last_name
order by "Total paid" desc
limit 5;

-- 35. Selecciona todos los actores cuyo primer nombre es 'Johnny'.
select first_name ,
       last_name 
from actor 
where first_name in('JOHNNY') ;

-- 36. Renombra la columna “first_name” como Nombre y “last_name” como Apellido.
select first_name as "Nombre",
       last_name  as "Apellido"
from actor;

/* DataProject 
* LogicaConsultas_SQL 3
*/

-- 37. Encuentra el ID del actor más bajo y más alto en la tabla actor.
select MIN(actor_id) as "ID mas bajo",
       MAX(actor_id) as "ID mas alto"
from actor ;

-- 38. Cuenta cuántos actores hay en la tabla “actor”.
select count(actor_id)
from actor ;

-- 39. Selecciona todos los actores y ordénalos por apellido en orden ascendente.
select first_name as "Nombre",
       last_name  as "Apellido"
from actor
order by "Apellido" ;

-- 40. Selecciona las primeras 5 películas de la tabla “film”.
select film_id,
       title as "Pelicula"
from film
order by film_id 
limit 5;

-- 41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. 

select first_name as "Actors name",
       count(*) as "Repeated name count"
from actor
group by "Actors name" 
having count(*) > 1 
order by count(*) desc; 

-- ¿Cuál es el nombre más repetido?
select first_name as "Actors name",
       count(*) as "Repeated name count"
from actor
group by "Actors name" 
having count(*) > 1 
order by count(*) desc 
limit 1 ;

-- 42. Encuentra todos los alquileres y los nombres de los clientes que los realizaron.
select concat(c.first_name , ' ', c.last_name) as "Client name",
       r.rental_id 
from customer as "c"
     inner join rental r 
     on "c".customer_id = r.customer_id ;

-- 43. Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres.
select concat(c.first_name , ' ', c.last_name) as "Client name",
       r.rental_id 
from customer as "c"
     left join rental r 
     on "c".customer_id = r.customer_id ;

-- 44. Realiza un CROSS JOIN entre las tablas film y category.
/*¿Aporta valor esta consulta? ¿Por qué? 
 *Deja después de la consulta la contestación.
*/
select *
from film f 
cross join category c ;

/*This query does not bring any practical value as the CROSS join returns all possible combinations between films and categories.
 * This results in a large number of rows. 
 * It is very hard to undertand what benefit this query would give considering the combinations and the data represenation.
 */

-- 45. Encuentra los actores que han participado en películas de la categoría 'Action'.
select distinct
       a.actor_id ,
       concat(a.first_name , ' ', a.last_name ) as "Actors' name",
       c."name" as "Category"
from actor a 
    inner join film_actor fa 
    on a.actor_id = fa.actor_id 
     inner join film f 
     on fa.film_id = f.film_id 
      inner join film_category fc 
      on f.film_id = fc.film_id 
       inner join category c 
       on fc.category_id = c.category_id 
where c."name" = 'Action'
order by "Actors' name" ;

-- 46. Encuentra todos los actores que no han participado en películas.
select 
      a.first_name , 
      a.last_name ,
      fa.film_id 
from actor a 
 left join film_actor fa 
 on a.actor_id = fa.actor_id
where fa.film_id is null ;

 -- 47. Selecciona el nombre de los actores y la cantidad de películas en las que han participado.
select
      concat(a.first_name , ' ', a.last_name) as "Actors' name",
      count(fa.film_id) as "Total films"
from actor a 
 left join film_actor fa 
 on a.actor_id = fa.actor_id
group by "Actors' name" ,
          a.actor_id 
order by "Total films" desc;

-- 48. Crea una vista llamada “actor_num_peliculas” que muestre los nombres de los actores
-- y el número de películas en las que han participado.
create view Actor_Num_Peliculas as 
 select
      concat(a.first_name , ' ', a.last_name) as "Actors' name",
      count(fa.film_id) as "Total films"
from actor a 
 left join film_actor fa 
 on a.actor_id = fa.actor_id
group by "Actors' name" ,
          a.actor_id ;

select *
from actor_num_peliculas

-- 49. Calcula el número total de alquileres realizados por cada cliente.
select 
       c.customer_id,
       concat(c.first_name , ' ', c.last_name) as "Client name",
       count(r.rental_id) as "Total rentals"
from customer c 
  left join rental r 
  on c.customer_id = r.customer_id   
group by c.customer_id ,
         "Client name" ;

-- 50. Calcula la duración total de las películas en la categoría 'Action'.
select
     c."name" as "Categoria",
     sum(f.length) as "Duracion total"
from film f 
  inner join film_category fc 
  on f.film_id = fc.film_id 
  inner join category c 
  on fc.category_id = c.category_id 
where c."name" = 'Action'
group by "Categoria" ;

-- 51. Crea una tabla temporal llamada “cliente_rentas_temporal” para almacenar el total de alquileres por cliente.
create temp table Cliente_rentas_temporal as 
 select 
       c.customer_id,
       concat(c.first_name , ' ', c.last_name) as "Client name",
       count(r.rental_id) as "Total rentals"
 from customer c 
  left join rental r 
  on c.customer_id = r.customer_id   
 group by c.customer_id ,
         "Client name" ;

-- 52. Crea una tabla temporal llamada “peliculas_alquiladas” que almacene las películas que han sido alquiladas al menos 10 veces.
create temp table Peliculas_Alquiladas as
 select f.title as "Pelicula",
       count(r.rental_id) as "Total rental"
 from film f 
  left join inventory i 
  on f.film_id = i.film_id 
   left join rental r 
   on i.inventory_id  = r.inventory_id 
 group by f.film_id 
 having count(r.rental_id) >= 10 ;

-- 53. Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre ‘Tammy Sanders’ 
--y que aún no se han devuelto. Ordena los resultados alfabéticamente por título de película.
select 
      f.title as "Titulo pelicula",
      concat(c.first_name, c.last_name) as "Client name" ,
      r.return_date 
from customer c 
  inner join rental r 
  on c.customer_id = r.customer_id 
   inner join inventory i 
   on r.inventory_id = i.inventory_id 
    inner join film f 
    on i.film_id = f.film_id
 where r.return_date is null
     and concat(c.first_name , ' ', c. last_name) = 'TAMMY SANDERS'
 order by "Titulo pelicula" ;
 
-- 54. Encuentra los nombres de los actores que han actuado en al menos una película que pertenece a la categoría ‘Sci-Fi’. 
--Ordena los resultados alfabéticamente por apellido.
select distinct
       a.actor_id ,
       a.first_name as "Nombre actor",
       a.last_name as "Apellido",
       c."name" as "Category"
from actor a 
    inner join film_actor fa 
    on a.actor_id = fa.actor_id 
     inner join film f 
     on fa.film_id = f.film_id 
      inner join film_category fc 
      on f.film_id = fc.film_id 
       inner join category c 
       on fc.category_id = c.category_id 
where c."name" = 'Sci-Fi'
order by a.last_name 

/*DataProject: 
 * LógicaConsultasSQL 4
 */

-- 55. Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron después de que la película 
--‘Spartacus Cheaper’ se alquilara por primera vez. Ordena los resultados alfabéticamente por apellido.
select distinct
      a.first_name as "Nombre actor" ,
      a.last_name  as "Apellido" ,
      f.title as "Titulo pelicula" ,
      r.rental_date 
from actor a 
 inner join film_actor fa 
 on a.actor_id = fa.actor_id 
  inner join film f 
  on fa.film_id = f.film_id 
   inner join inventory i 
   on f.film_id = i.film_id 
    inner join rental r 
     on i.inventory_id = r.inventory_id
where r.rental_date > 
       (
          select r2.rental_date
          from film f2
          inner join inventory i2 
          on f2.film_id = i2.film_id 
          inner join rental r2 
          on i2.inventory_id = r2.inventory_id
          where f2.title = 'SPARTACUS CHEAPER'
          order by r2.rental_date 
          limit 1
)
order by "Apellido" ;

-- 56. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría ‘Music’.
select distinct
       a.actor_id ,
       a.first_name as "Nombre actor",
       a.last_name as "Apellido",
       c."name" as "Category"
from actor a 
    left join film_actor fa 
    on a.actor_id = fa.actor_id 
     left join film f 
     on fa.film_id = f.film_id 
      left join film_category fc 
      on f.film_id = fc.film_id 
       left join category c 
       on fc.category_id = c.category_id 
       where c."name" not in('Music') ;

-- 57. Encuentra el título de todas las películas que fueron alquiladas por más de 8 días.
select distinct 
      f.title as "Titulo pelicula" ,
      f.rental_duration 
from film f
group by f.film_id 
having f.rental_duration > 8 ;
/* I don´t think this is correct, cause I belive the rental durantion means the days a customer can rent the movie for. 
 * It might be on the rental table where to calculate rental return date and rental date.
 *  Not sure how to find the rental' days - need support.
 */      

-- 58. Encuentra el título de todas las películas que son de la misma categoría que ‘Animation’.
select f.title as "Titulo pelicula",
       c."name" as "Category"
from film f 
  inner join film_category fc 
  on f.film_id = fc.film_id 
   inner join category c 
   on fc.category_id = c.category_id 
where c."name" in('Animation') ;

-- another option 
select f.title as "Titulo pelicula",
       c."name" as "Category"
from film f 
  inner join film_category fc 
  on f.film_id = fc.film_id 
   inner join category c 
   on fc.category_id = c.category_id 
   where c.category_id  in 
(
  select c2.category_id  
  from category c2 
  where c2.name in('Animation') 
);

-- 59. Encuentra los nombres de las películas que tienen la misma duración que la película con el título ‘Dancing Fever’. 
--Ordena los resultados alfabéticamente por título de película.
select f.title as "Titulo pelicula",
       f.length 
from film f 
where f.length =
(
 select f2.length 
 from film f2  
 where f2.title in('DANCING FEVER')
 )
order by f.title ;

-- 60. Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas. 
--Ordena los resultados alfabéticamente por apellido.
select c.first_name as "Nombre cliente", 
       c.last_name as "Apellido"
from customer c 
 inner join rental r 
 on c.customer_id = r.customer_id 
group by c.customer_id 
having count(distinct r.rental_id) >=7
order by "Apellido" ; 

-- 61. Encuentra la cantidad total de películas alquiladas por categoría 
--y muestra el nombre de la categoría junto con el recuento de alquileres.
select c."name" as "Categoria",
       count(r.rental_id) as "Total rental"
from category c 
 inner join film_category fc 
 on c.category_id = fc.category_id 
  inner join film f 
  on fc.film_id = f.film_id 
   inner join inventory i 
   on f.film_id = i.film_id 
    inner join rental r
    on i.inventory_id = r.inventory_id 
group by c."name"
order by "Total rental" desc;

-- 62. Encuentra el número de películas por categoría estrenadas en 2006.
select c."name" as "Categoria",
       count(f.film_id) "Total peliculas",
       f.release_year 
from category c 
 inner join film_category fc 
 on c.category_id = fc.category_id 
  inner join film f 
  on fc.film_id = f.film_id 
where f.release_year = 2006   
group by c.name,
         f.release_year 
order by "Total peliculas" desc;

-- 63. Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.
select s.staff_id,
       s.first_name , s.last_name,
       s2.store_id 
from staff s 
 cross join store s2  ;

-- 64. Encuentra la cantidad total de películas alquiladas por cada cliente 
-- y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.
select 
      c.customer_id ,
      concat(c.first_name , ' ', c.last_name) as "Client full name",
      count(r.rental_id) as "Total rental"
from customer c 
 inner join rental r 
 on c.customer_id = r.customer_id 
group by c.customer_id ,
         "Client full name"
order by "Total rental" desc;

