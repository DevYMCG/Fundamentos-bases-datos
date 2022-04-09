/*
    @Traer todos los posts con fecha de 
    publicación mayor a 2024

*/

SELECT * FROM posts WHERE YEAR(fecha_publicacion) > '2024';
