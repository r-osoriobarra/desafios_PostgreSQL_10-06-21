-- Desafío Top 100
--DROP DATABASE peliculas;

-- 1. Crear base de datos llamada películas.
    CREATE DATABASE peliculas;
-- Conectarse a la base
    \c peliculas

-- Creando tabla peliculas y reparto
    CREATE TABLE peliculas(
        id INT UNIQUE PRIMARY KEY,
        movie VARCHAR(100),
        release_year INT,
        director VARCHAR(50)
    );

    CREATE TABLE reparto(
        id_peliculas INT,
        actor_name VARCHAR(50),
        FOREIGN KEY (id_peliculas) REFERENCES peliculas(id)
    );

-- 2. Cargar ambos archivos a su tabla correspondiente.
    \copy peliculas FROM 'peliculas.csv' csv header;
    \copy reparto FROM 'reparto.csv' csv;

-- 3. Obtener el ID de la película “Titanic”.
    SELECT id FROM peliculas WHERE movie = 'Titanic';

-- 4. Listar a todos los actores que aparecen en la película "Titanic".
    SELECT actor_name FROM reparto WHERE id_peliculas = 2;

-- 5. Consultar en cuántas películas del top 100 participa Harrison Ford.
    SELECT actor_name, COUNT(actor_name) FROM reparto 
    WHERE actor_name = 'Harrison Ford' GROUP BY actor_name;

-- 6. Indicar las películas estrenadas entre los años 1990 y 1999 ordenadas por título de manera ascendente.
    SELECT movie, release_year FROM peliculas WHERE release_year BETWEEN 1990 AND 1999 
    ORDER BY movie ASC;

-- 7. Hacer una consulta SQL que muestre los títulos con su longitud, la longitud debe ser nombrado para la consulta como “longitud_titulo”. 
    SELECT movie, LENGTH(movie) AS longitud_titulo FROM peliculas;

-- 8. Consultar cual es la longitud más grande entre todos los títulos de las películas.
    SELECT MAX(LENGTH(movie)) AS Longest_title FROM peliculas;

-- Extra. Listar todas las películas y sólo 1 actor de cada reparto.
    SELECT p.movie, r.actor_name FROM peliculas AS p 
    INNER JOIN (SELECT DISTINCT ON (id_peliculas) id_peliculas, actor_name 
    FROM reparto) AS r 
    ON id = id_peliculas;