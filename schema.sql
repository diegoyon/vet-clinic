/* Database schema to keep the structure of entire database. */

CREATE TABLE animals(
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR,
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL,
    PRIMARY KEY(id)
);

/* add species column */
ALTER TABLE animals ADD species VARCHAR;

-- Create a table named owners
CREATE TABLE owners(
    id INT GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR,
    age INT,
    PRIMARY KEY (id)
);

-- Create a table named species
CREATE TABLE species(
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR,
    PRIMARY KEY (id)
);

-- Modify animals table:
-- Make sure that id is set as autoincremented PRIMARY KEY
-- Remove column species
ALTER TABLE animals DROP COLUMN species;

-- Add column species_id which is a foreign key referencing species table
ALTER TABLE animals ADD COLUMN species_id INT; 
ALTER TABLE animals ADD CONSTRAINT fk_species FOREIGN KEY(species_id) REFERENCES species(id);

-- Add column owner_id which is a foreign key referencing the owners table
ALTER TABLE animals ADD COLUMN owner_id INT;
ALTER TABLE animals ADD CONSTRAINT fk_owner FOREIGN KEY(owner_id) REFERENCES owners(id);


-- Create a table named vets
CREATE TABLE vets (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR,
    age INT,
    date_of_graduation DATE,
    PRIMARY KEY (id)
);

-- Create a "join table" called specializations
CREATE TABLE specializations (
    species_id INT REFERENCES species(id),
    vet_id INT REFERENCES vets(id)
);

-- Create a "join table" called visits, it should also keep track of the date of the visit.
CREATE TABLE visits (
    animals_id INT REFERENCES animals(id),
    vet_id INT REFERENCES vets(id),
    date_of_visit DATE
);


-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);


CREATE INDEX animals_id_asc ON visits(animals_id ASC);

CREATE INDEX vet_id_asc ON visits(vet_id ASC);

CREATE INDEX owners__email_asc ON owners(email ASC);

