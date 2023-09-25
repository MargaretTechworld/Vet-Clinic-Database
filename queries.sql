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

-- Vet clinic database: add 'join table' for visits
SELECT a.name, vi.date_of_visits 
FROM animals a 
JOIN visits vi ON a.id = vi.animal_id 
JOIN vets ve ON ve.id = vi.vet_id 
WHERE ve.name ='Vet William Tatcher' 
ORDER BY(vi.date_of_visits) DESC LIMIT 1;

SELECT COUNT(DISTINCT(a.name)) AS total_seen
FROM animals a 
JOIN visits vi ON a.id = vi.animal_id 
JOIN vets ve ON vi.vet_id = ve.id 
WHERE ve.name = 'Vet Stephanie Mendez'; 

SELECT ve.name, s.name AS specialties FROM vets ve 
LEFT JOIN specializations sp ON ve.id = sp.vet_id 
LEFT JOIN species s ON s.id = sp.species_id;


SELECT a.name, vi.date_of_visits 
FROM animals a JOIN visits vi ON a.id = vi.animal_id 
JOIN vets v ON vi.vet_id = v.id 
WHERE v.name = 'Vet Stephanie Mendez'
AND vi.date_of_visits BETWEEN '2020-04-01' and '2020-08-30';

SELECT a.name AS most_visited, COUNT(vi.animal_id) 
FROM animals a JOIN visits vi ON a.id = vi.animal_id 
JOIN vets v ON v.id = vi.vet_id 
GROUP BY(vi.animal_id, a.name) 
ORDER BY COUNT(vi.animal_id) DESC LIMIT 1;

SELECT a.name, vi.date_of_visits AS most_visited 
FROM animals a 
JOIN visits vi ON a.id = vi.animal_id 
JOIN vets v ON v.id = vi.vet_id 
WHERE v.name = 'Vet Maisy Smith' 
ORDER BY(vi.date_of_visits) LIMIT 1;

SELECT a.name,v.name AS vet_name, vi.date_of_visits 
FROM animals a JOIN visits vi ON a.id = vi.animal_id 
JOIN vets v ON v.id = vi.vet_id 
ORDER BY(vi.date_of_visits) DESC LIMIT 1;

SELECT COUNT(*) FROM visits 
JOIN animals ON animals.id = visits.animal_id 
JOIN species ON species.id = animals.species_id 
JOIN vets ON vets.id = visits.vet_id 
LEFT JOIN specializations sp ON sp.vet_id = vets.id 
WHERE sp.species_id != animals.species_id OR sp.species_id IS NULL;

SELECT species.name, COUNT(species.id) 
FROM species JOIN animals ON species.id = animals.species_id 
JOIN visits ON visits.animal_id = animals.id 
JOIN vets ON vets.id = visits.vet_id 
WHERE vets.name = 'Vet Maisy Smith' 
GROUP BY(species.id) 
ORDER BY(species.id) DESC LIMIT 1;

SELECT COUNT(*) FROM visits where animal_id = 4;
SELECT * FROM visits where vet_id = 2;
SELECT * FROM owners where email = 'owner_18327@mail.com';

explain analyze SELECT COUNT(*) FROM visits where animal_id = 4;
explain analyze SELECT * FROM visits where vet_id = 2;
explain analyze SELECT * FROM owners where email = 'owner_18327@mail.com';