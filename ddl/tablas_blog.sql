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

CREATE TABLE usuarios(
    id int not null auto_increment,
    login varchar(30) not null,
    password varchar(32) not null,
    nickname varchar(40) not null,
    email varchar(40) not null,
    PRIMARY KEY (id),
    UNIQUE INDEX email_UNIQUE (email asc)
);

CREATE TABLE posts(
    id int not null auto_increment,
    titulo varchar(150) not null,
    fecha_publicacion Timestamp null,
    contenido Text not null,
    status Char(8) null default 'activo',
    usuario_id int not null,
    categoria_id int not null,
    PRIMARY KEY (id)
);

/*Contraint*/
ALTER TABLE posts
ADD INDEX posts_usuarios_idx (usuario_id asc);

ALTER TABLE posts
ADD Constraint posts_usuarios
    FOREIGN KEY (usuario_id)
    REFERENCES usuarios (id)
    ON DELETE NO ACTION
    ON UPDATE CASCADE;