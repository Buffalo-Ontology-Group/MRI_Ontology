# MRI Ontology (MRIO)
An ontology for the representation of MRI acquisition and analysis.

MRIO builds on the Ontology for Biomedical Investigations (OBI) to flush out the process of acquiring MR images, analyzing these images, and interpretting the results of these analyses.
A select set of terms from Uberon are imported to relate MRI analyses to the specific brain regions.
To cut down on complexity, OBI and Uberon were filtered to use only the terms and axioms we needed. These terms can be found in:
 - `src/ontology/imports/obi_terms.txt`
 - `src/ontology/imports/uberon_terms.txt`

The goal of this ontology is to help improve communication between neuroimagers and researchers with little-to-no experience, standardize communication between neuroimagers, and serve as a backbone for full automation of the neuroimaging research process.
Because so much of neuroimaging research is conducted via programming, this ontology has the potential to integrate with software and greatly simplify the neuroimaging research process.

