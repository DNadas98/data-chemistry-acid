-- SELECT id, name, gender, race, category FROM middle_earth_character;

CREATE VIEW view_1 AS SELECT m.id, m.name, g.name AS gender, r.name AS race, c.name AS category
FROM middle_earth_character m
         INNER JOIN gender g on m.gender_id = g.id
         INNER JOIN races r on m.race_id = r.id
         INNER JOIN categories c on m.category_id = c.id
ORDER BY m.id;