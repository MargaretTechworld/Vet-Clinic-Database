CREATE TABLE animals (
  id INTEGER,
  name VARCHAR,
  date_of_birth DATE,
  escape_attempts INTEGER,
  neutered BOOLEAN,
  weight_kg DECIMAL
);

-- Vet clinic database: query and update animals table
ALTER TABLE animals ADD COLUMN species VARCHAR;

-- Vet clinic database: query multiple tables

 CREATE TABLE owners(id INT GENERATED ALWAYS AS IDENTITY, full_name VARCHAR, age INT, PRIMARY KEY(id));
 CREATE TABLE species (id INT GENERATED ALWAYS AS IDENTITY, name VARCHAR, PRIMARY KEY(id));
 ALTER TABLE animals ADD PRIMARY KEY(id);
 ALTER TABLE animals ALTER id ADD GENERATED ALWAYS AS IDENTITY;
 ALTER TABLE animals DROP COLUMN species;
 ALTER TABLE animals ADD COLUMN species_id INT;
 ALTER TABLE animals ADD CONSTRAINT fk_species FOREIGN KEY(species_id) REFERENCES species(id);
 ALTER TABLE animals ADD COLUMN owner_id INT;
 ALTER TABLE animals ADD CONSTRAINT fk_owner FOREIGN KEY(owner_id) REFERENCES owners(id);

 