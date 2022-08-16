#!/bin/bash

id=$1
fa=$2
te=$3
tr=$4
ti=$5

## Create SPARQL UPDATE query with IRI = MRIO_000$id
## and specified acquisition parameters;
## UPDATE query saved to ../sparql/update_query.ru
./generate_update_query.sh $id $fa $te $tr $ti 

## Run the UPDATE query to insert individual into copy ontology
echo -e "Adding individual MRIO_000$id with \n\tFlip angle=$fa \n\tTE=$te \n\tTR=$tr \n\tTI=$ti"
./run.sh robot query \
    -i MRIO-edit.owl \
    -u ../sparql/update_query.ru \
    -o MRIO-individuals.owl

## Use reasoner to classify new individual 
## and query for acquisition type
echo "Running HermiT reasoner to classify individual..."
./run.sh robot reason -r hermit \
    -i MRIO-individuals.owl \
    --axiom-generators ClassAssertion \
    -o MRIO-reasoned.owl

echo "Querying for acquisition type of individual..."
./run.sh robot query \
    --input MRIO-reasoned.owl \
    --query ../sparql/individuals.sparql individuals.csv

## Remove temporary files
#echo "Cleaning up..."
#rm MRIO-reasoned.owl MRIO-individuals.owl

