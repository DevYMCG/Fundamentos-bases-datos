/*
    @Traer todos los posts con fecha de 
    publicación mayor a 2024

*/

SELECT * 
FROM posts 
WHERE YEAR(fecha_publicacion) > '2024';

/*
    @Traer todos los usuarios tengan o no 
    tengan posts "LEFT JOIN"

*/

SELECT *
FROM usuarios
LEFT JOIN posts on usuarios.id = posts.usuario_id

/*
    @Traer todos los usuarios pero solo aquellos
    que no tengan ningún posts

*/

SELECT * 
FROM usuarios 
LEFT JOIN posts on usuarios.id = posts.usuario_id
where posts.usuario_id is null;

/*
    @Traer todos los POSTS tengan o no 
    tengan usuario "RIGHT JOIN"
*/

SELECT * 
FROM usuarios 
RIGHT JOIN posts on usuarios.id = posts.usuario_id;

/*
    @Traer todos los POSTS pero solo aquellos
    que no tengan ningún usuario

*/

SELECT * 
FROM usuarios 
RIGHT JOIN posts on usuarios.id = posts.usuario_id
where usuario_id is null;

/*
    @Traer todos los usuarios que tengan
    posts
*/
SELECT * 
FROM usuarios INNER JOIN posts on usuarios.id = posts.usuario_id;

/*
    @Traer todos los usuarios que tengan
    o que no tengan post y trae todos los posts
    que tengan o no tengan usuario
*/
SELECT * 
FROM usuarios 
LEFT JOIN posts on usuarios.id = posts.usuario_id
UNION
SELECT * 
FROM usuarios 
RIGHT JOIN posts on usuarios.id = posts.usuario_id;

/*
    @Traer solo los usuarios que tengan el usuario_id vacio
    y traer los posts que tengan el post_id vacio
*/
SELECT * 
FROM usuarios 
LEFT JOIN posts on usuarios.id = posts.usuario_id
where usuario_id is null
UNION
SELECT * 
FROM usuarios 
RIGHT JOIN posts on usuarios.id = posts.usuario_id
where posts.usuario_id is null;

/*
    @Traer todos los posts donde el estatus sea
    diferente a activo tambien se puede denotar
    con !=
*/
SELECT * FROM posts WHERE estatus<>'activo';

/*
    @un breve resumen del like y uso del %:
    – %termina_en
    – %en medio%
    – inicia_con%
*/

SELECT * 
FROM posts
WHERE titulo LIKE '%escandalo%'

/*
    @Cabe mencionar que los operadores LIKE y BETWEEN AND, pueden ser negados con NOT
    NOT LIKE
    NOT BETWEEEN – AND –
*/
SELECT * FROM posts WHERE titulo NOT LIKE '%escandalo%';

/*
     @Selecciona los posts cuya fecha de publicación es mayor a '2022-01-01’
*/
SELECT * FROM posts WHERE fecha_publicacion > '2022-01-01';

/*
     @Selecciona los posts cuya fecha de publicación este entre este rango.
*/
SELECT * FROM posts WHERE fecha_publicacion BETWEEN '2024-01-01' and '2025-01-01';

/* 
    @Seleccionar los posts que esten en este rango de fechas
*/
SELECT * FROM posts WHERE year(fecha_publicacion) BETWEEN '2024' and '2025';

/* 
    @Seleccionar los posts del mes de abril
*/
SELECT * FROM posts WHERE month(fecha_publicacion)='04';

/* 
    @Seleccionar los posts donde usuario_id no sea nulo y
    el estatus sea igual a activo
*/
select * from posts 
where usuario_id is not null and estatus = 'activo';

/* 
    @Agrupar por estatus los posts
*/
SELECT estatus, COUNT(*) post_quantity
FROM `posts`
group by estatus;

/* 
    @Tambien contamos con el operador suma este es util
    cuando queremos sumar data tiene que ver mucho con informes.
*/
SELECT estatus, SUM(id) post_quantity
FROM `posts`
group by estatus;

/* 
    @Mostrar cuantos posts se hicieron por año
*/
SELECT year(fecha_publicacion) as post_year, count(*) as post_quantity
FROM `posts`
GROUP by post_year

/* 
    @Mostrar cuantos posts se hicieron por mes
*/
SELECT monthname(fecha_publicacion) as post_month, count(*) as post_quantity
 FROM `posts` GROUP by post_month;

/* 
    @Mostrar cuantos posts se hicieron por mes y agrupar por estatus.
*/
SELECT estatus, monthname(fecha_publicacion) as post_month, count(*) as post_quantity 
FROM `posts` GROUP by estatus, post_month;

/* 
    @Ordenar los registros por fecha de publicación 
    de manera ascendente
*/

SELECT * FROM `posts` ORDER by fecha_publicacion;

/* 
    @Ordenar los registros por fecha de publicación 
    de manera descendente y limitarlo a los primeros 5
*/

SELECT * 
FROM `posts` 
ORDER by fecha_publicacion desc
LIMIT 5;

/*
    @Cuando se desea hacer una selección de rows, se hace con WHERE, 
    pero cuando se desea hacer una selección de rows agrupados debe
     hacerse con HAVING.
*/

SELECT estatus, monthname(fecha_publicacion) as post_month, count(*) as post_quantity 
FROM `posts`
GROUP by estatus, post_month
HAVING post_quantity > 1
ORDER BY post_month;

/*  
    @Quiero seleccionar todo de la tabla posts pero la condicion es
    que la fecha de publicacion sea igual a la fecha maxima de publicacion

*/

select *
from posts
where fecha_publicacion = (
    select max(fecha_publicacion) 
    from posts
)

/*  @Cuantas etiquetas hay por post*/

select posts.titulo posts,etiquetas.nombre_etiqueta etiquetas, COUNT(etiqueta_id) as num_etiqueta
from posts_etiquetas 
join etiquetas on posts_etiquetas.etiqueta_id=etiquetas.id 
join posts on posts_etiquetas.post_id=posts.id 
group by post_id 
order by num_etiqueta;

/*  @Cuales etiquetas pertenecen a este post*/
select posts.titulo posts, GROUP_CONCAT(etiquetas.nombre_etiqueta)
from posts_etiquetas 
join etiquetas on posts_etiquetas.etiqueta_id=etiquetas.id 
join posts on posts_etiquetas.post_id=posts.id 
group by post_id 

/*  @Cuales son las etiquetas que no tienen ningun post*/
select *
from etiquetas
	LEFT JOIN posts_etiquetas on etiquetas.id = posts_etiquetas.etiqueta_id
  WHERE posts_etiquetas.etiqueta_id is null;

/*cantidad de posts por categoria*/
SELECT c.categoria ,count(*) count_categoria
FROM `posts` p join categorias c
on p.categoria_id = c.id
group by categoria_id
order by count_categoria desc;

/*usuario que a estado creando mas posts en el sistema*/
SELECT u.nickname ,count(*) count_post
FROM `posts` p join usuarios u
on p.usuario_id = u.id
group by p.usuario_id
order by count_post desc;

/*usuario que a estado creando mas posts en el sistema y categoria que ha estado
escribiendo*/

SELECT u.nickname ,GROUP_CONCAT(c.categoria),count(*) count_post
FROM `posts` p 
join usuarios u on p.usuario_id = u.id
join categorias c on p.categoria_id = c.id
group by p.usuario_id
order by count_post desc;

/*usuario que a estado creando mas posts en el sistema y categoria que ha estado
escribiendo sin repetir la categoria*/

SELECT u.nickname ,GROUP_CONCAT(DISTINCT c.categoria),count(*) count_post
FROM `posts` p 
join usuarios u on p.usuario_id = u.id
join categorias c on p.categoria_id = c.id
group by p.usuario_id
order by count_post desc;

/*usuarios que no han escrito ningún posts*/
select *
FROM `posts` p 
right join usuarios u on p.usuario_id = u.id
where p.id is null;

