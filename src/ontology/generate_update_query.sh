#!/bin/bash

id=$1
fa=$2
te=$3
tr=$4
ti=$5

cat > ../sparql/update_query.ru << EOF
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
PREFIX obo: <http://purl.obolibrary.org/obo/>

INSERT DATA
{
  obo:MRIO_000$id obo:MRIO_0000384 "$fa"^^xsd:float ;
                         obo:MRIO_0000375 obo:MRIO_0000640 ;
                         obo:MRIO_0000377 "$te"^^xsd:float ;
                         obo:MRIO_0000376 "$tr"^^xsd:float ;
                         obo:MRIO_0000606 "$ti"^^xsd:float .
}
EOF
