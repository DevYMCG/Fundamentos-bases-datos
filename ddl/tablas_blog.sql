CREATE TABLE categorias(
    id int not null auto_increment,
    categoria varchar(30) not null,
    PRIMARY KEY (id)
)

CREATE TABLE etiquetas(
    id int not null auto_increment,
    nombre_etiqueta varchar(30) not null,
    PRIMARY KEY (id)
)