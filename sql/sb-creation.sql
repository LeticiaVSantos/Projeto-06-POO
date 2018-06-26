DROP TABLE users;
CREATE TABLE users(
    id BIGINT not null primary key
       GENERATED ALWAYS AS IDENTITY
       (START WITH 1, INCREMENT BY 1)
    , role varchar(200) not null
    , name varchar(200) not null
    , login varchar(20) not null
    , passwordHash BIGINT not null

);

INSERT INTO users VALUES
(default, 'ADMIN', 'Administrador', 'admin', 1509442);
INSERT INTO users VALUES
(default, 'OPERADOR', 'Leticia Santos', 'leticia', 1509442);

DROP TABLE customers;
CREATE TABLE customers(
    id BIGINT not null primary key
        GENERATED ALWAYS AS IDENTITY
        (START WITH 1, INCREMENT BY 1)
    , customer_name varchar(200) not null
    , rg varchar(9) not null
    , cpf varchar(11) not null
    , address varchar(50) not null
    , telephone varchar(11) not null
    , email varchar(25) not null
    
);

DROP TABLE prices;
CREATE TABLE prices(
     id BIGINT not null primary key
        GENERATED ALWAYS AS IDENTITY
        (START WITH 1, INCREMENT BY 1)
    , timestamp TIMESTAMP not null
    , new_price DOUBLE PRECISION not null
);

DROP TABLE cars_periods;
CREATE TABLE cars_periods(
     id BIGINT not null primary key
        GENERATED ALWAYS AS IDENTITY
        (START WITH 1, INCREMENT BY 1)
    , model varchar(50) not null
    , plate varchar(7) not null
    , retirada date not null
    , dev date not null
    , price DOUBLE PRECISION

);






