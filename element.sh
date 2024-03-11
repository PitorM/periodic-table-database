#! /bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

#  check for passed argument
if [[ $1 ]]
then # identify the type of argument
  if [[ ! $1 =~ ^[0-9]+$ ]]
  then # if not number treat as string
    if [[ ${#1} -gt 2 ]] # check for lenght to treat as symbol or name
    then # check using name
      ELEMENT=$($PSQL "SELECT * FROM properties FULL JOIN elements USING(atomic_number) FULL JOIN types USING(type_id)
      WHERE name ILIKE '$1' ")
      if [[  -z $ELEMENT ]]
      then # if the element does not exist
        echo "I could not find that element in the database."
      else
        echo "$ELEMENT" | while IFS="|" read TYPE_ID A_NUMBER A_MASS M_P B_P SYMBOL NAME TYPE
        do
          echo -e "The element with atomic number $A_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $A_MASS amu. $NAME has a melting point of $M_P celsius and a boiling point of $B_P celsius."
        done
      fi
    else #check using symbol
      ELEMENT=$($PSQL "SELECT * FROM properties FULL JOIN elements USING(atomic_number) FULL JOIN types USING(type_id)
      WHERE symbol = '$1' ")
      if [[  -z $ELEMENT ]]
      then # if the element does not exist
        echo "I could not find that element in the database."
      else
          echo "$ELEMENT" | while IFS="|" read TYPE_ID A_NUMBER A_MASS M_P B_P SYMBOL NAME TYPE
        do 
          echo -e "The element with atomic number $A_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $A_MASS amu. $NAME has a melting point of $M_P celsius and a boiling point of $B_P celsius."
        done
      fi
    fi
  else # if argument a number
      ELEMENT=$($PSQL "SELECT * FROM properties FULL JOIN elements USING(atomic_number) FULL JOIN types USING(type_id)
      WHERE atomic_number = $1 ")
      if [[ -z $ELEMENT ]]
      then # if the element does not exist
        echo "I could not find that element in the database."
      else 
        echo "$ELEMENT" | while IFS="|" read TYPE_ID A_NUMBER A_MASS M_P B_P SYMBOL NAME TYPE
        do
          echo -e "The element with atomic number $A_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $A_MASS amu. $NAME has a melting point of $M_P celsius and a boiling point of $B_P celsius."
        done
      fi
  fi
else # if an argument was not provided
  echo "Please provide an element as an argument."
fi
