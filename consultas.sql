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