INSERT INTO animals VALUES (
1,' Agumon', '2020-02-03', 0, TRUE, 10.23
);
INSERT INTO animals VALUES (
2,'Gabumon', '2018-11-15', 2, TRUE, 8
);
INSERT INTO animals VALUES (
3,'Pikachu', '2021-01-07', 1, FALSE, 15.04
);
INSERT INTO animals VALUES (
4,'Devimon', '2017-05-12', 5, TRUE, 11
);

-- Vet clinic database: query and update animals table
INSERT INTO animals(id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES
(5, 'Charmander', '2020-02-8', 0, FALSE, -11),
(6, 'Plantmon', '2021-11-15', 2, TRUE , -5.7),
(7, 'Squirtle', '1993-04-02', 3, FALSE, -12.13),
(8, 'Angemon', '2005-06-12', 1, TRUE, -45),
(9, 'Boarmon', '2005-07-07', 7, TRUE, 20.4),
(10, 'Blossom', '1998-10-13', 3, TRUE, 17),
(11, 'Ditto', '2022-05-14', 4, TRUE, 22);

-- Vet clinic database: query multiple tables

INSERT INTO owners(full_name, age) VALUES
('Sam Smith', 34),
('Jennifer Orwell', 19),
('Bob', 45),
('Melody Pond', 77),
('Dean Winchester', 14),
('Jodie Whittaker', 38);


INSERT INTO species(name) VALUES
('Pokemon'),
('Digimon');

UDATE animals SET species_id = CASE WHEN name like '%mon' THEN 1 ELSE 2 END;

UPDATE animals SET owner_id = CASE WHEN name = 'Agumon' THEN 1 WHEN name IN ('Gabumon', 'Pikachu') 
THEN 2 WHEN name IN ('Devimon', 'Plantmon') THEN 3 WHEN name IN ('Charmander', 'Squirtle', 'Blossom') 
THEN 4 WHEN name IN ('Angemon', 'Boarmon') THEN 5
END;