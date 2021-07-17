DROP DATABASE IF EXISTS example;
CREATE DATABASE example;

USE example;

DROP TABLE IF EXISTS users;
CREATE TABLE users(
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) COMMENT 'Имя пользователя'
)COMMENT = "Перечень пользователей";

INSERT INTO users VALUES 
(NULL, 'Пупкин')
(NULL, 'Голубкин')
(NULL, 'Синицын')
(NULL, 'Ащьф Лштшфум')