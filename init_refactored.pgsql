DROP TABLE IF EXISTS middle_earth_character;
DROP TABLE IF EXISTS gender;
DROP TABLE IF EXISTS races;
DROP TABLE IF EXISTS categories;

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

CREATE TABLE gender
(
    id   SERIAL PRIMARY KEY,
    name CHAR(1) NOT NULL UNIQUE
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

INSERT INTO gender (name)
VALUES ('M'),
       ('F');

INSERT INTO races (name)
VALUES ('Men'),
       ('Hobbit'),
       ('Maia'),
       ('Dwarf'),
       ('Elf'),
       ('Dragon');

INSERT INTO categories (name)
VALUES ('Fellowship'),
       ('Nobility'),
       ('Royalty'),
       ('Antagonist');


INSERT INTO middle_earth_character
    (name, gender_id, race_id, category_id)
VALUES ('Aragorn', 1, 1, 1),
       ('Boromir', 1, 1, 1),
       ('Frodo Baggins', 1, 2, 1),
       ('Gandalf', 1, 3, 1),
       ('Gimli', 1, 4, 1),
       ('Legolas Greenleaf', 1, 5, 1),
       ('Samwise Gamgee', 1, 2, 1),
       ('Merry Brandybuck', 1, 2, 1),
       ('Peregrin "Pippin" Took', 1, 2, 1),
       ('Arwen Undómiel', 2, 5, 2),
       ('Éowyn', 2, 1, 3),
       ('Galadriel', 2, 5, 3),
       ('Sauron', 1, 3, 4),
       ('Smaug', 1, 6, 4),
       ('Gollum', 1, 2, 4);