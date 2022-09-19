/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Agumon', '2020-02-02', 10.23, TRUE, 0);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Gabumon', '2018-11-15', 8, TRUE, 2);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Pikachu', '2021-01-07', 15.04, FALSE, 1);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Devimon', '2017-05-12', 11, TRUE, 5);

/* Query and Update animals table */
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Charmander', '2020-02-08', 11, FALSE, 0);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Plantmon', '2021-11-15', 5.7, TRUE, 2);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Squirtle', '1993-04-02', 12.13, FALSE, 3);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Angemon', '2005-06-12', 45, TRUE, 1);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Boarmon', '2005-06-07', 20.4, TRUE, 7);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Blossom', '1998-10-13', 17, TRUE, 3);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES ('Ditto', '2022-05-14', 22, TRUE, 4);

/* Populate owners and species table */
INSERT INTO owners (full_name, age) VALUES ('Sam Smith', 34), ('Jennifer Orwell', 19), ('Bob', 45), ('Melody Pond', 77), ('Dean Winchester', 14), ('Jodie Whittaker', 38);
INSERT INTO species (name) VALUES ('Pokemon'), ('Digimon');

-- Modify your inserted animals so it includes the species_id value:
-- If the name ends in "mon" it will be Digimon
UPDATE animals SET species_id = 2 WHERE name LIKE '%mon';
-- All other animals are Pokemon
UPDATE animals SET species_id = 1 WHERE species_id IS NULL;

-- Modify your inserted animals to include owner information (owner_id):
-- Sam Smith owns Agumon.
UPDATE animals SET owner_id = 1 WHERE name = 'Agumon';
-- Jennifer Orwell owns Gabumon and Pikachu.
UPDATE animals SET owner_id = 2 WHERE name IN ('Gabumon', 'Pikachu');
-- Bob owns Devimon and Plantmon.
UPDATE animals SET owner_id = 3 WHERE name IN ('Devimon', 'Plantmon');
-- Melody Pond owns Charmander, Squirtle, and Blossom.
UPDATE animals SET owner_id = 4 WHERE name IN ('Charmander', 'Squirtle', 'Blossom');
-- Dean Winchester owns Angemon and Boarmon.
UPDATE animals SET owner_id = 5 WHERE name IN ('Angemon', 'Boarmon');


-- Add data to vets table
INSERT INTO vets (name, age, date_of_graduation) VALUES
('William Tatcher', 45, '2000-04-23'),
('Maisy Smith', 26, '2019-01-17'),
('Stephanie Mendez', 64, '1981-05-04'),
('Jack Harkness', 38, '2008-06-08');

-- Add data to specializations table
INSERT INTO specializations (species_id, vet_id) VALUES
(1, 1),
(1, 3),
(2, 3),
(2, 4);

-- Add data to visits table
INSERT INTO visits (animals_id, vet_id, date_of_visit) VALUES
(1, 1, '2020-05-24'),
(1, 3, '2020-07-22'),
(2, 4, '2021-02-02'),
(3, 2, '2020-01-05'),
(3, 2, '2020-03-08'),
(3, 2, '2020-05-14'),
(4, 3, '2021-05-04'),
(5, 4, '2021-02-24'),
(6, 2, '2019-12-21'),
(6, 1, '2020-08-10'),
(6, 2, '2020-04-07'),
(7, 3, '2019-09-29'),
(8, 4, '2020-10-03'),
(8, 4, '2020-11-04'),
(9, 2, '2019-01-24'),
(9, 2, '2019-05-15'),
(9, 2, '2020-02-27'),
(9, 2, '2020-08-03'),
(10, 3, '2020-05-24'),
(10, 1, '2021-01-11');


-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animals_id, vet_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
INSERT INTO owners (full_name, email) SELECT 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';