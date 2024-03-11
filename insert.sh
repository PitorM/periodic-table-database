#! /bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
cat atomic_mass.txt | while IFS="|" read A_NUMBER A_MASS
do
  INSERT_INTO_PROPERTIES=$($PSQL "UPDATE properties SET atomic_mass = $A_MASS WHERE atomic_number = $A_NUMBER ")
done

# insert into properties (atomic_number, type, atomic_mass, melting_point_celsius, boiling_point_celsius, type_id) values (9, 'nonmetal', 18.998, -220, -188.1, 2)