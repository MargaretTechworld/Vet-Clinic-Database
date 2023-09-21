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