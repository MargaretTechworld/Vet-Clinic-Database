SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * from animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

-- Vet clinic database: query and update animals table
BEGIN;
UPDATE animals SET species='unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
UPDATE animals SET species='digimon' WHERE name LIKE '%mon';
UPDATE animals SET species='pokemon' WHERE name LIKE IS NULL;
SELECT * FROM animals;
COMMIT;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT sp1;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK sp1;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

SELECT COUNT(name) FROM animals;
SELECT COUNT(name) FROM animals WHERE escape_attempts=0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, MAX(escape_attempts) FROM animals GROUP BY neutered;
SELECT species, MAX(weight_kg), MIN(weight_kg) FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

-- made corrections as required by the code reviewer
UPDATE animals SET escape_attempts=1 WHERE name='Angemon';

-- Vet clinic database: query multiple tables

SELECT animals.name, owners.full_name FROM animals INNER JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';

SELECT animals.name, species.name FROM animals INNER JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

SELECT animals.name, owners.full_name FROM owners LEFT JOIN animals on animals.owner_id = owners.id;

SELECT species.name AS species_name, COUNT(*) AS animal_count FROM species JOIN animals ON 
animals.species_id = species.id GROUP BY species.name ORDER BY animal_count DESC;

SELECT animals.name, owners.full_name, species.name FROM animals JOIN owners ON 
animals.owner_id = owners.id JOIN species ON animals.species_id = species.id
WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';

SELECT animals.name, owners.full_name, species.name, animals.escape_attempts FROM animals JOIN 
owners ON animals.owner_id = owners.id JOIN species ON animals.species_id = species.id WHERE 
owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

SELECT owners.full_name, COUNT(*) AS most_owner FROM owners JOIN animals ON 
animals.owner_id = owners.id GROUP BY owners.full_name ORDER BY most_owner desc;

-- made corrections as required by the code reviewer

ALTER TABLE animals ALTER COLUMN name TYPE VARCHAR(255);
ALTER TABLE owners ALTER COLUMN full_name TYPE VARCHAR(255);
ALTER TABLE species ALTER COLUMN name TYPE VARCHAR(255);