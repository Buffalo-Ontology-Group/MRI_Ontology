import begin
from rdflib import Graph, Namespace


owl_file = "../ontology/MRIO-edit.owl"
ontology_iri = "http://purl.obolibrary.org/obo/"

# set up RDF graph for later querying
def make_data_graph(filename, ontology):
	graph = Graph().parse(filename)
	ontology_namepsace = Namespace(ontology)
	graph.namespace_manager.bind("obo", "http://purl.obolibrary.org/obo/" )
	return graph, ontology_namepsace
g, mrio = make_data_graph(owl_file, ontology_iri)

def find_analyses(seq_labels): #input should be list of strings with identifying IRIs for each SEQUENCE! NOT IMAGE!

    #list of image IRIs
    args = list([])

    #contruction of 1st query, linking sequences to images
    str_a = "PREFIX owl: <http://www.w3.org/2002/07/owl#> PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#> PREFIX root: <http://purl.obolibrary.org/obo/MRIO_0000341> PREFIX output: <http://purl.obolibrary.org/obo/OBI_0000299> SELECT DISTINCT ?seq ?seq_label ?image ?image_label WHERE { ?image rdfs:subClassOf* root: . ?image rdfs:label ?image_label . ?seq rdfs:label ?seq_label . ?seq rdfs:subClassOf [ a owl:Restriction; owl:onProperty output:; owl:someValuesFrom ?image ]. "
    str_c = "} order by ?image"
    for x in range(len(seq_labels)):
        str_b = f"filter (contains(str(?seq), '{seq_labels[x]}'))"
        q_s2i = (str_a + str_b + str_c)
        # print(q_s2i)
        r_s2i = g.query(q_s2i)
        #adding all image IRIs to list
        for r in r_s2i:
            args.append(str(r.image))

    #construction of 2nd and 3rd queries, linking images to single-input analyses and mutli-input analyses (respectively)
    str1 = "PREFIX owl: <http://www.w3.org/2002/07/owl#> PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#> PREFIX input: <http://purl.obolibrary.org/obo/OBI_0000293> PREFIX root: <http://purl.obolibrary.org/obo/MRIO_0000623> "
    str2 = "SELECT DISTINCT ?analysis ?analysis_label WHERE { ?analysis rdfs:label ?analysis_label . "
    str3 = " ?double_input owl:intersectionOf ("
    str4a = ") . ?analysis rdfs:subClassOf [a owl:Restriction; owl:onProperty input:; owl:someValuesFrom ?double_input] . }"
    str4b =  "?analysis rdfs:subClassOf [a owl:Restriction; owl:onProperty input:; owl:someValuesFrom "
    str5 = "] . }"
    size = len(args)
    str_dict = {}

    #output! dictionary listing IRIs and labels of all possible analyses
    analyses = {}
    analyses["analyses"] = []
    analyses["labels"] = []
    combo_list = list([])

    #implementing query 2 (single-input)
    for x in range(len(args)):        
        str_dict[args[x]] = {'prefix': f"PREFIX image{x}: <{args[x]}> ", 'image': f" image{x}: "}
        str1 = (str1 + str_dict[args[x]]['prefix'])
        single = (str1 + str2 + str4b + str(str_dict[args[x]]['image']) + str5)
        rs = g.query(single)

        #adding single-input analyses to output
        for r in rs:
            analyses['analyses'].append(str(r.analysis))
            analyses['labels'].append(str(r.analysis_label))
        combo_list.append(str_dict[args[x]]['image'])

    #establishing all possible combos based on the input images 
    from itertools import combinations
    def combos(args):
        comb = []
        for n in range(1,len(args)+1):
            comb.append([i for i in combinations(args,n)])
        for x in range(len(comb)):
            for y in range(len(comb[x])):
                comb[x][y] = ''.join(comb[x][y])
        try:
            del comb[0]
        except IndexError:
            return(comb)
        return comb
    A = combos(combo_list)

    #implementing query 3 (multi-input)
    for y in range(len(A)):
        for yy in range(len(A[y])):
            str8 = (str3 + str(A[y][yy]))
            mult = (str1 + str2 + str8 + str4a)
            # print(mult)
            rm = g.query(mult)

            #adding multi-input analyses to output
            for r in rm:
                analyses['analyses'].append(str(r.analysis))
                analyses['labels'].append(str(r.analysis_label))

    return analyses

@begin.start
def main(*acquisition_sequences: "IRIs of acquisition sequences to assign analyses for."):
    """
    This tool automatically assigns neuroimaging analyses given a set of MRI acquisition sequences.
    """

    acquisition_sequences = [ str(acquisition_sequence) for acquisition_sequence in acquisition_sequences ]
    print(acquisition_sequences)
    analyses = set([ analysis for analysis in  find_analyses(acquisition_sequences)['labels'] ])
    print(analyses)

