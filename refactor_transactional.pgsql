BEGIN;
SAVEPOINT before_refactor;

ALTER TABLE middle_earth_character
    RENAME TO deprecated_middle_earth_character;

CREATE TABLE gender
(
    id   SERIAL PRIMARY KEY,
    name CHAR(1) NOT NULL UNIQUE
);

CREATE TABLE races
(
    id   SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE categories
(
    id   SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE middle_earth_character
(
    id          SERIAL PRIMARY KEY,
    name        VARCHAR(255) NOT NULL,
    gender_id   INT          NOT NULL,
    race_id     INT          NOT NULL,
    category_id INT          NOT NULL,
    CONSTRAINT fk_character_gender_id FOREIGN KEY (gender_id) REFERENCES gender (id),
    CONSTRAINT fk_character_race_id FOREIGN KEY (race_id) REFERENCES races (id),
    CONSTRAINT fk_character_category_id FOREIGN KEY (category_id) REFERENCES categories (id)
);

INSERT INTO gender(name) (SELECT DISTINCT gender FROM deprecated_middle_earth_character);
INSERT INTO races(name) (SELECT DISTINCT race FROM deprecated_middle_earth_character);
INSERT INTO categories(name) (SELECT DISTINCT category FROM deprecated_middle_earth_character);

INSERT INTO middle_earth_character (name, gender_id, race_id, category_id)
SELECT d.name,
       g.id as gender_id,
       r.id as race_id,
       c.id as category_id
FROM deprecated_middle_earth_character d
         INNER JOIN gender g ON d.gender = g.name
         INNER JOIN races r ON d.race = r.name
         INNER JOIN categories c ON d.category = c.name;

COMMIT;

-- In case of error:
-- ROLLBACK TO SAVEPOINT before_refactor;