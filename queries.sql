/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-01-01';
SELECT name FROM animals WHERE neutered = FALSE AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = TRUE;
SELECT * FROM animals WHERE name NOT IN ('Gabumon');
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

/* Transactions */

-- Update the animals table by setting the species column to unspecified. Verify that change was made. Then roll back the change and verify that the species columns went back to the state before the transaction.
BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

-- Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
-- Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
-- Commit the transaction.
-- Verify that change was made and persists after commit.
BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
COMMIT;
SELECT * FROM animals;

-- Delete all records in the animals table, then roll back the transaction.
BEGIN;
DELETE FROM animals;
ROLLBACK;

-- Delete all animals born after Jan 1st, 2022.
-- Create a savepoint for the transaction.
-- Update all animals' weight to be their weight multiplied by -1.
-- Rollback to the savepoint
-- Update all animals' weights that are negative to be their weight multiplied by -1.
-- Commit transaction
BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT SP1;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO SP1;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

-- How many animals are there?
SELECT COUNT(*) FROM animals;

-- How many animals have never tried to escape?
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

-- What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, SUM(escape_attempts) FROM animals GROUP BY neutered;

-- What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-01-01' GROUP BY species;


-- What animals belong to Melody Pond?
SELECT * FROM animals JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT * FROM animals JOIN species ON animals.species_id = species.id WHERE species.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT * FROM owners LEFT JOIN animals ON owners.id = animals.owner_id;

-- How many animals are there per species?
SELECT species.name, COUNT(*) FROM species JOIN animals ON species.id = animals.species_id GROUP BY species.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT * FROM animals JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Jennifer Orwell' AND animals.species_id = 2;

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT * FROM animals JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

-- Who owns the most animals?
SELECT owners.full_name, COUNT(animals.owner_id) FROM owners LEFT JOIN animals ON owners.id = animals.owner_id GROUP BY owners.full_name ORDER BY COUNT(animals.owner_id) DESC LIMIT 1;


-- Who was the last animal seen by William Tatcher?
SELECT animals.name, visits.date_of_visit FROM animals JOIN visits ON animals.id = visits.animals_id JOIN vets ON vets.id = visits.vet_id WHERE vets.name = 'William Tatcher' ORDER BY visits.date_of_visit DESC LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT vets.name, COUNT(*) FROM vets JOIN visits ON visits.vet_id = vets.id JOIN animals ON animals.id = visits.animals_id WHERE vets.name = 'Stephanie Mendez' GROUP BY vets.name;

-- List all vets and their specialties, including vets with no specialties.
SELECT vets.name, species.name FROM vets LEFT JOIN specializations ON vets.id = specializations.vet_id LEFT JOIN species ON species.id = specializations.species_id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name, vets.name, visits.date_of_visit FROM animals JOIN visits ON animals.id = visits.animals_id JOIN vets ON vets.id = visits.vet_id WHERE vets.name = 'Stephanie Mendez' AND visits.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

-- What animal has the most visits to vets?
SELECT animals.name, COUNT(*) FROM animals JOIN visits ON animals.id = visits.animals_id GROUP BY animals.name ORDER BY COUNT(*) DESC LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT animals.name, vets.name, visits.date_of_visit FROM animals JOIN visits ON visits.animals_id = animals.id JOIN vets ON vets.id = visits.vet_id WHERE vets.name = 'Maisy Smith' ORDER BY visits.date_of_visit ASC LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT * FROM animals JOIN visits ON animals.id = visits.animals_id JOIN vets ON vets.id = visits.vet_id ORDER BY visits.date_of_visit DESC;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*) FROM visits JOIN animals ON animals.id = visits.animals_id JOIN vets ON vets.id = visits.vet_id LEFT JOIN specializations ON vets.id = specializations.vet_id WHERE vets.name != 'Stephanie Mendez' AND (animals.species_id != specializations.species_id OR specializations.species_id IS NULL);

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT species.name , COUNT(*) FROM visits JOIN vets ON vets.id = visits.vet_id JOIN animals ON animals.id = visits.animals_id JOIN species ON animals.species_id = species.id WHERE vets.name = 'Maisy Smith' GROUP BY species.name;




SELECT COUNT(*) FROM visits WHERE animals_id =4;
SELECT * FROM visits WHERE vet_id = 2;
SELECT * FROM owners where email = 'owner_18327@mail.com';
