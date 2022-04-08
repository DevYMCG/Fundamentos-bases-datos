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

ALTER TABLE posts
ADD INDEX posts_categorias_idx (categoria_id asc);

ALTER TABLE posts
ADD Constraint posts_categorias
    FOREIGN KEY (categoria_id)
    REFERENCES categorias (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

/*tablas transitivas*/

CREATE TABLE comentarios(
    id int not null auto_increment,
    comentario Text not null,
    usuario_id int not null,
    post_id int not null,
    PRIMARY KEY (id)
);

ALTER TABLE comentarios
ADD INDEX comentarios_usuarios_idx (usuario_id asc);

ALTER TABLE comentarios
ADD Constraint comentarios_usuarios
    FOREIGN KEY (usuario_id)
    REFERENCES usuarios (id)
    ON DELETE NO ACTION
    ON UPDATE CASCADE;

ALTER TABLE comentarios
ADD INDEX comentarios_posts_idx (posts_id asc);

ALTER TABLE comentarios
ADD Constraint comentarios_posts
    FOREIGN KEY (posts_id)
    REFERENCES posts (id)
    ON DELETE NO ACTION
    ON UPDATE CASCADE;